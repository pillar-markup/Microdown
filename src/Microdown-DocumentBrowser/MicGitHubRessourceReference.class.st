"
I am a resource reference to documentation ressources in non-cloned github projects.
Normally one can not traverse folders on the web, but github has a specific api for that which I utilize.

To get the documents of a specific project, the github uri scheme is:
github://user/project[:branch][/pathToDoc]

Branch can be omitted, in which case the branch currently designated as default on github is used.
If no pathToDoc is given it is assumed to be doc.
"
Class {
	#name : #MicGitHubRessourceReference,
	#superclass : #MicResourceReference,
	#instVars : [
		'user',
		'project',
		'branch',
		'docFolder',
		'githubConnection'
	],
	#category : #'Microdown-DocumentBrowser-ResourceModel'
}

{ #category : #accessing }
MicGitHubRessourceReference >> branch [

	^ branch
]

{ #category : #accessing }
MicGitHubRessourceReference >> docFolder [

	^ docFolder
]

{ #category : #accessing }
MicGitHubRessourceReference >> githubConnection [
	githubConnection ifNil: [ githubConnection := ZnClient new ].
	^ githubConnection 
]

{ #category : #accessing }
MicGitHubRessourceReference >> lookupDefaultBranch [
	"Looks up the name of the default branch. returns nil if user/project does not exist"
	| request response |
	'"default_branch": "Pharo10"'.
	request := 'https://api.github.com/repos/{1}/{2}' format: {user. project}.
	response := STONJSON fromString: (self githubConnection get: request).
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
	docUri host ifNotNil: [ user := docUri host ].
	projectAndBranch := docUri segments first splitOn: ':'.
	project := projectAndBranch first.
	branch := projectAndBranch size > 1 
		ifTrue: [ projectAndBranch second ]
		ifFalse: [ self lookupDefaultBranch ].
	docFolder := docUri segments size > 1 
		ifTrue: [ docUri segments allButFirst asArray]
		ifFalse: [ {'docs'} ]
]

{ #category : #accessing }
MicGitHubRessourceReference >> user [

	^ user
]
