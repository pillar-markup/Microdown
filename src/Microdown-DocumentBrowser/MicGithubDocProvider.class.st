"
I am a provider for documents stored on github. 
In particular I am able to find microdown documents in the doc folder of a project.

Normally one can not traverse folders on the web, but github has a specific api for that which I utilize.

To get the documents of a specific project, the github uri scheme is:
github://user/project[:branch][/pathToDoc]

Branch can be omitted, in which case the branch currently designated as default on github is used.
If no pathToDoc is given it is assumed to be doc.


"
Class {
	#name : #MicGithubDocProvider,
	#superclass : #MicAbstractDocProvider,
	#instVars : [
		'user',
		'project',
		'branch',
		'docFolder',
		'githubConnection'
	],
	#category : #'Microdown-DocumentBrowser-Model'
}

{ #category : #'as yet unclassified' }
MicGithubDocProvider class >> pharoDocs [
	"return a document collection of the help files stored in the pharo repository"
	^ self onUri: 'github://pharo-project/pharo' 
]

{ #category : #public }
MicGithubDocProvider >> _readme [
	"I am obsolete, but has some non-trivial code which need to be migrated"
]

{ #category : #accessing }
MicGithubDocProvider >> branch [

	^ branch
]

{ #category : #private }
MicGithubDocProvider >> buildDocumentCollection: docs [
	"docs is an array of association, mapping paths to microdown documents"
	| groups collection |
	groups := docs sort: [ :a :b | a key pathString < b key pathString ].
	groups := groups groupedBy: [ :assoc | assoc key segments first ].
	collection := groups associations collect: [ :assoc | |localRoot documents docCol children|
		localRoot := assoc key.
		documents := (assoc value select: [ :a | a key size = 1 ])
			collect: [:a | a value].
		children := (assoc value select: [ :a | a key size > 1 ])
			collect: [ :a | a key dropFirstSegment -> a value ].
		docCol := documents, (self buildDocumentCollection: children).
		"If the only contents is a single file, do not encapsulate it a collection"
		(documents size = 1 and: [ children isEmpty ])
			ifTrue: [ documents first ]
			ifFalse: [ MicDocumentCollection new
				children: docCol;
				title: localRoot]
		 ].
	^ collection 
]

{ #category : #private }
MicGithubDocProvider >> decomposeDocUri [
	"the doc uri is on the form: github://user/project:branch/docfolder"
	| projectAndBranch |
	docUri host ifNotNil: [ user := docUri host ].
	projectAndBranch := docUri segments first splitOn: ':'.
	project := projectAndBranch first.
	branch := projectAndBranch size > 1 
		ifTrue: [ projectAndBranch second ]
		ifFalse: [ self lookupDefaultBranch ].
	docFolder := docUri segments size > 1 
		ifTrue: [ docUri segments second ]
		ifFalse: [ 'doc' ]
	
	
]

{ #category : #accessing }
MicGithubDocProvider >> docFolder [

	^ docFolder
]

{ #category : #private }
MicGithubDocProvider >> docPaths [
	"I return an ordered collection of paths for microdown documents in the doc tree
	microdown is using .md or .mic extensions"
	
	| docURL json |
	json := STONJSON fromString: (self githubConnection get: self urlForDocFolder ).
	"get the url for reading the doc folder only"
	docURL := ((json at: 'tree') detect: [ :e| {'doc'. 'wiki'} includes:(e at: 'path')]) at: 'url'.
	"read the subfolder structure too"
	docURL := docURL , '?recursive=1'.
	json := STONJSON fromString: (self githubConnection  get: docURL).
	^ (((json at: 'tree') 
		select: [ :e| ((e at: 'type') = 'blob')]) 
		collect: [:e| Path from: (e at: 'path')])
		select: [ :p | p segments last 
			in: [ :name | (name endsWith: '.md') | (name endsWith: '.mic') ] ]
]

{ #category : #accessing }
MicGithubDocProvider >> githubConnection [
	githubConnection ifNil: [ githubConnection := ZnClient new ].
	^ githubConnection 
]

{ #category : #accessing }
MicGithubDocProvider >> githubConnectionClose [
	
	githubConnection ifNotNil: [githubConnection close]
]

{ #category : #public }
MicGithubDocProvider >> initialize [
	self decomposeDocUri 
	
	
]

{ #category : #accessing }
MicGithubDocProvider >> loadDocumentAt: path [
	"load and resolve the document at path"
	|url source doc section |
	url := self urlForFile: path pathString.
	source := self githubConnection  get: url.
	doc := Microdown parse: source.
	doc := Microdown resolve: doc fromUri: self urlForDocFolder asZnUrl.
	section := MicSectionBlock fromRoot: doc header: path pathString.
	section propertyAt: #source put: source.
	section propertyAt: #url put: path pathString.
	^ section
	
	
]

{ #category : #public }
MicGithubDocProvider >> loadDocuments [
	"Load all documents from my specification"
	|  docCounter pathsAndDocuments |
	docCounter := 1.
	[	[:job |
		pathsAndDocuments := self docPaths collect: [ :path | 
				job 
					title: path segments last;
					progress: (docCounter / 10).
				docCounter := (docCounter % 10) + 1.
				path -> (self loadDocumentAt: path) ].
		] asJob run.
	] ensure: 
			[ self githubConnectionClose ].
	^ MicDocumentCollection new
		title: docUri asString;
		children: (self buildDocumentCollection: pathsAndDocuments);
		parent: self.
	
]

{ #category : #private }
MicGithubDocProvider >> lookupDefaultBranch [
	"Looks up the name of the default branch. returns nil if user/project does not exist"
	| request response |
	'"default_branch": "Pharo10"'.
	request := 'https://api.github.com/repos/{1}/{2}' format: {user. project}.
	response := STONJSON fromString: (self githubConnection get: request).
	^ response at: 'default_branch' ifAbsent: [ nil ]
	
]

{ #category : #accessing }
MicGithubDocProvider >> project [

	^ project
]

{ #category : #private }
MicGithubDocProvider >> urlForDocFolder [
	^ branch 
		ifNil: [ self error: 'branch must be have a value at the moment' ]
		ifNotNil: [ 'https://api.github.com/repos/{1}/{2}/git/trees/{3}' format: { user. project. branch }]
]

{ #category : #private }
MicGithubDocProvider >> urlForFile: aPath [
	^ 'https://raw.githubusercontent.com/{1}/{2}/{3}/{4}/{5}' 
			format: { user. project. branch. docFolder. aPath }
]

{ #category : #accessing }
MicGithubDocProvider >> user [

	^ user
]
