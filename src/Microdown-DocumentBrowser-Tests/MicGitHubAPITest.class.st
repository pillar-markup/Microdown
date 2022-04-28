"
A MicGitHubAPITest is a test class for testing the behavior of MicGitHubAPI
"
Class {
	#name : #MicGitHubAPITest,
	#superclass : #TestCase,
	#instVars : [
		'api'
	],
	#category : #'Microdown-DocumentBrowser-Tests-ResourceModel'
}

{ #category : #'api - accessing' }
MicGitHubAPITest >> ensureApi: anInteger for: aFullBlockClosure [ 
	api class apiCallsRemaining >= anInteger 
		ifTrue: [ aFullBlockClosure value ]
		ifFalse: [ self skip: 'Rate limit exhaused' ]
]

{ #category : #running }
MicGitHubAPITest >> setUp [
	super setUp.
	
	api := MicGitHubAPI new.
	MicGitHubAPI apiCallsRemaining = 60
		ifTrue: [ 
			[ api defaultBranch: 'pillar-markup' project: 'Microdown' ]
			on: MicGitHubAPIRateError 
			do: [ 'Just reading the default branch will set the number of API calls remaining' ]]
]

{ #category : #tests }
MicGitHubAPITest >> testGet [
	| url res |
	self ensureApi: 1 for: [
		url := 'https://api.github.com/repos/pillar-markup/Microdown'.
		res := api get: url.
		self assert: (res at: 'full_name') equals: 'pillar-markup/Microdown'.
		self assert: (res at: 'default_branch') equals: 'dev']
]

{ #category : #tests }
MicGitHubAPITest >> testIsCaching [
	| url res rate|
	self ensureApi: 1 for: [
		url := 'https://api.github.com/repos/pillar-markup/Microdown'.
		res := api get: url.
		self assert: (api class cache includesKey: url).
		rate := MicGitHubAPI apiCallsRemaining.
		api get: url.
		self assert: MicGitHubAPI apiCallsRemaining equals: rate
		].
]

{ #category : #tests }
MicGitHubAPITest >> testdefaultBranchProject [
	| branch |
	self ensureApi: 1 for: [
		branch := api defaultBranch: 'pillar-markup' project: 'Microdown'.
		self assert: branch equals: 'dev']
]

{ #category : #tests }
MicGitHubAPITest >> testdefaultBranchProject_Pharo [
	| branch |
	self ensureApi: 1 for: [
		branch := api defaultBranch: 'pharo-project' project: 'pharo'.
		self assert: (branch beginsWith: 'Pharo')]
]

{ #category : #tests }
MicGitHubAPITest >> testdefaultBranchProject_defaultBranch [
	
	| branch |
	self ensureApi: 1 for: [
		branch := api defaultBranch: 'JohnDoe' project: 'Calculator'.
		self assert: branch equals: 'main']
]
