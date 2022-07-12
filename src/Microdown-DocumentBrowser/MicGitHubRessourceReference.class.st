"
I am a resource reference to documentation ressources in non-cloned github projects.
Normally one can not traverse folders on the web, but github has a specific api for that which I utilize.

To get the documents of a specific project, the github uri scheme is:
github://user/project[:branch][/pathToDoc]

Branch can be omitted, in which case the branch currently designated as default on github is used.
If no pathToDoc is given it is assumed to be doc.

## Performance and API restrictions
The performance of looking up the folder structure in github is not all that good. In addition, there is a restriction on the number of github api calls which can be done per hour (if one use authenthication the restrictions are more favorable).

To aid with both, I use a two level caching system.
- Class side - I cache instances of me based on user, project and branch. This cache is a LRUCache.
- Instance side - as I can get the whole folder structure in one call, I cache this structure.
"
Class {
	#name : #MicGitHubRessourceReference,
	#superclass : #MicAbsoluteResourceReference,
	#instVars : [
		'user',
		'project',
		'branch',
		'docFolder',
		'children'
	],
	#category : #'Microdown-DocumentBrowser-ResourceModel'
}

{ #category : #'instance creation' }
MicGitHubRessourceReference class >> handlesUriScheme: scheme [
	^ scheme = 'github'
]

{ #category : #accessing }
MicGitHubRessourceReference >> binaryReadStream [
	"return the binaryStream I refer to"
	^ self error: 'Binary streams to github items not yet supporteds'.
]

{ #category : #accessing }
MicGitHubRessourceReference >> branch [

	^ branch
]

{ #category : #'document browser' }
MicGitHubRessourceReference >> browserIcon [
	^ self iconNamed: #github
]

{ #category : #'document browser' }
MicGitHubRessourceReference >> browserTitle [
	^ self uri query
		ifNotNil:[:query | query at: #fullPath]
		ifNil: [ self uri printString ]
]

{ #category : #accessing }
MicGitHubRessourceReference >> contents [
	"This is inefficient, but can be done"
	| response content |
	response := self githubPathLookup.
	content := response 
		at: #content 
		ifAbsent: [MicResourceReferenceError signal: 'I am a directory and has no contents'].
	^ content base64Decoded asString
]

{ #category : #accessing }
MicGitHubRessourceReference >> docFolder [

	^ docFolder
]

{ #category : #private }
MicGitHubRessourceReference >> extractFolderReferencesFrom: response [
	| folders raw docPath |
	folders := (response at: #tree) select: [ :elem | (elem at: #type) = #tree].
	"github://user/project:sha"
	raw := 'github://{1}/{2}' format: { user. project }.
	docPath := self branch,'/', (self docFolder joinUsing: '/').
	^ folders collect: [ :folder |  
		MicResourceReference fromUri: (raw ,':', (folder at: #sha),'?fullPath=', docPath, '/', (folder at: #path))]
]

{ #category : #private }
MicGitHubRessourceReference >> extractMicrodownDocReferencesFrom: response [
	| docs path |
	docs := (response at: #tree) select: [ :elem | 
		(elem at: #type) = #blob and:[ #(md mic) includes: ((elem at: #path) copyAfterLast: $.) ]].
	docs ifEmpty: [ ^#() ].
	path := self pathStringForRawAccess.
	^ docs collect: [ :doc |  MicResourceReference fromUri: path, '/', (doc at: #path)]
]

{ #category : #private }
MicGitHubRessourceReference >> githubApi [
	^ MicGitHubAPI new
]

{ #category : #private }
MicGitHubRessourceReference >> githubPathLookup [
	"I return the response object from the trees api - see https://docs.github.com/en/rest/reference/git#get-a-tree"
	| request response |
	request := self githubTreesApiRequest.
	self docFolder do: [ :segment |
		response := self githubApi get: request.
		request := ((response at: #tree) 
			detect: [ :elem | (elem at: #path) = segment ]) at: #url.
		request := request withoutPrefix: 'https://api.github.com/'.
		 ].
	response := STONJSON fromString: (ZnEasy get: ('https://api.github.com/',request) )entity contents.
	^ response
]

{ #category : #private }
MicGitHubRessourceReference >> githubTreesApiRequest [
	"See documentation at: https://docs.github.com/en/rest/reference/git#get-a-tree"
	 ^ 'repos/{1}/{2}/git/trees/{3}' 
			format: { user. project. branch }
]

{ #category : #accessing }
MicGitHubRessourceReference >> loadChildren [
	children 
		ifNil:[ | response folders microdownDocs|
			response := self githubPathLookup.
			folders := self extractFolderReferencesFrom: response.
			microdownDocs := self extractMicrodownDocReferencesFrom: response.
			children := folders , microdownDocs].
	^ children
]

{ #category : #private }
MicGitHubRessourceReference >> lookupDefaultBranch [
	
	^ self githubApi defaultBranch: user project: project
	
]

{ #category : #private }
MicGitHubRessourceReference >> pathStringForRawAccess [
	"I return the path string to be used for the raw.githubusercontent.com access to blobs"
	| path |
	path := 'https://raw.githubusercontent.com/{1}/{2}' 
		format: { user. project}.
	self docFolder 
		ifNotEmpty: [ ^ path, '/' , self branch, '/', (self docFolder joinUsing: '/') ].
	self uri query 
		ifNil: [ ^ path, '/', self branch ].
	^ path ,'/', (self uri query at: #fullPath ifAbsent: [''])
]

{ #category : #accessing }
MicGitHubRessourceReference >> project [

	^ project
]

{ #category : #accessing }
MicGitHubRessourceReference >> uri: docUri [
	"I assume docUri to be a ZnURI on the form: github://user/project[:branch][/pathToDoc]"
	| projectAndBranch |
	super uri: docUri.
	user := docUri host.
	projectAndBranch := docUri segments first splitOn: ':'.
	project := projectAndBranch first.
	branch := projectAndBranch size > 1 
		ifTrue: [ projectAndBranch second ]
		ifFalse: [ self lookupDefaultBranch ].
	docFolder := docUri segments size > 1 
		ifTrue: [ docUri segments allButFirst asArray]
		ifFalse: [ #() ]
]

{ #category : #accessing }
MicGitHubRessourceReference >> user [

	^ user
]
