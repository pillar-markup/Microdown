"
I am a simple interface for the github api. I am specialized for using the annonymous calls, and in particular I keep track of the rates (one can only make 60 calls an hour). In most cases this will be just fine.

One can access the remaining number of api calls through class side `apiCallsRemaining`. This should be done in tests to make sure the test will not fail, but can be skipped.

I cache my responses, in a LRU cache of 120 last calls (randomly picked number worth two hours af api calls).
"
Class {
	#name : #MicGitHubAPI,
	#superclass : #IceGitHubAPI,
	#classVars : [
		'APICount',
		'NextReset',
		'ResponseCache'
	],
	#category : #'Microdown-DocumentBrowser-ResourceModel'
}

{ #category : #rates }
MicGitHubAPI class >> apiCallsRemaining [
	| fullCount |
	fullCount := 60.
	APICount ifNil: [ ^ fullCount ].
	(NextReset < DateAndTime now) ifTrue: [ ^ fullCount ].
	^ APICount 
]

{ #category : #cache }
MicGitHubAPI class >> cache [
	ResponseCache   ifNil: [ ResponseCache := LRUCache new maximumWeight: 117; yourself ].
	^ ResponseCache
]

{ #category : #cache }
MicGitHubAPI class >> cache: aCache [
	"Only intended usage is for testing"
	ResponseCache := aCache
]

{ #category : #'class initialization' }
MicGitHubAPI class >> reset [
	<script>
	ResponseCache := nil.
	APICount := nil.
	
]

{ #category : #requesting }
MicGitHubAPI >> defaultBranch: user project: project [
	"Looks up the name of the default branch. returns nil if user/project does not exist"
	| response |
	[response := self get: ('repos/{1}/{2}' format: {user. project}).
	^ response at: 'default_branch' ifAbsent: [ 'main' ]]
	on: IceGitHubError 
	do: [ ^ 'main' ]
]

{ #category : #private }
MicGitHubAPI >> extractRateInfo: response [
	| unixTime |
	APICount := (response headers at: 'X-Ratelimit-Remaining') asNumber.
	unixTime := (response headers at: 'X-Ratelimit-Reset') asNumber.
	NextReset := DateAndTime fromUnixTime: unixTime.
	^ response
]

{ #category : #'private - requesting' }
MicGitHubAPI >> get: apiCallString [
	"I return a json structure as the result from the github api call"
	^ self class cache 
		at: apiCallString 
		ifAbsentPut: [ super get: apiCallString]
	
]

{ #category : #responses }
MicGitHubAPI >> handleUnauthorized: response [
	"I override this method as it was the least wrong place to access the response"
	self extractRateInfo: response.
	super handleUnauthorized: response.
]
