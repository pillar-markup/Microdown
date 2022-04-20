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
		'githubConnection'
	],
	#classVars : [
		'RefCache'
	],
	#category : #'Microdown-DocumentBrowser-ResourceModel'
}

{ #category : #origins }
MicGitHubRessourceReference class >> cache [
	RefCache  ifNil: [ RefCache := LRUCache new ].
	^ RefCache
]

{ #category : #origins }
MicGitHubRessourceReference class >> cache: aCache [
	"Only intended usage is for testing"
	RefCache := aCache
]

{ #category : #origins }
MicGitHubRessourceReference class >> newFromUri: aUri [
	| key |
	key := aUri host,'/', aUri segments first.
	^ self cache 
		at: key 
		ifAbsentPut: [ self new uri: aUri; yourself ]
]

{ #category : #origins }
MicGitHubRessourceReference class >> reset [
	<script>
	RefCache := nil
	
]

{ #category : #accessing }
MicGitHubRessourceReference >> branch [

	^ branch
]

{ #category : #accessing }
MicGitHubRessourceReference >> contents [
	"This is inefficient, but can be done"
	| response content |
	response := self githubPathLookup.
	content := response at: #content.
	^ content base64Decoded asString
]

{ #category : #accessing }
MicGitHubRessourceReference >> docFolder [

	^ docFolder
]

{ #category : #private }
MicGitHubRessourceReference >> extractFolderReferencesFrom: response [
	| folders raw |
	folders := (response at: #tree) select: [ :elem | (elem at: #type) = #tree].
	"github://user/project:sha"
	raw := 'github://{1}/{2}' format: { user. project }.
	^ folders collect: [ :folder |  MicResourceReference fromUri: (raw ,':', (folder at: #sha))]
]

{ #category : #private }
MicGitHubRessourceReference >> extractMicrodownDocReferencesFrom: response [
	| docs raw |
	docs := (response at: #tree) select: [ :elem | 
		(elem at: #type) = #blob and:[ #(md mic) includes: ((elem at: #path) copyAfterLast: $.) ]].
	"https://raw.githubusercontent.com/pillar-markup/Microdown/dev/doc/testMicrodown/readme.md"
	raw := 'https://raw.githubusercontent.com/{1}/{2}/{3}/{4}' format: { user. project. branch. (docFolder joinUsing: '/') }.
	^ docs collect: [ :doc |  MicResourceReference fromUri: (raw ,'/', (doc at: #path))]
]

{ #category : #'as yet unclassified' }
MicGitHubRessourceReference >> githubPathLookup [
	"I return the response object from the trees api - see https://docs.github.com/en/rest/reference/git#get-a-tree"
	| request response |
	request := self githubTreesApiRequest.
	1 to: self docFolder size do: [ :index |
		response := STONJSON fromString: (ZnEasy get: request )entity contents.
		request := ((response at: #tree) detect: [ :elem | (elem at: #path) = (self docFolder at: index) ]) at: #url.
		 ].
	response := STONJSON fromString: (ZnEasy get: request )entity contents.
	^ response
]

{ #category : #private }
MicGitHubRessourceReference >> githubTreesApiRequest [
	"https://docs.github.com/en/rest/reference/git#get-a-tree"
	 ^ 'https://api.github.com/repos/{1}/{2}/git/trees/{3}' 
			format: { user. project. branch }
]

{ #category : #testing }
MicGitHubRessourceReference >> isMicrodownOrFolder: elem [

	^ ((elem at: #type) = #tree)
		or:[(elem at: #type) = #blob and:[ #(md mic) includes: ((elem at: #path) copyAfterLast: $.) ]]
]

{ #category : #accessing }
MicGitHubRessourceReference >> loadChildren [ 
	| response folders microdownDocs|
	response := self githubPathLookup.
	folders := self extractFolderReferencesFrom: response.
	microdownDocs := self extractMicrodownDocReferencesFrom: response.
	^ folders , microdownDocs
]

{ #category : #accessing }
MicGitHubRessourceReference >> lookupDefaultBranch [
	"Looks up the name of the default branch. returns nil if user/project does not exist"
	| request response |
	'"default_branch": "Pharo10"'.
	request := 'https://api.github.com/repos/{1}/{2}' format: {user. project}.
	response := STONJSON fromString: (ZnEasy get: request) entity contents.
	^ response at: 'default_branch' ifAbsent: [ 'main' ]
	
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
