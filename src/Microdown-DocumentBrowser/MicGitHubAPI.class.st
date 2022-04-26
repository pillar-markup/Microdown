"
I am a simple interface for the github api. I am specialized for using the annonymous calls, and in particular I keep track of the rates (one can only make 60 calls an hour). In most cases this will be just fine.

One can access the remaining number of api calls through class side `apiCallsRemaining`. This should be done in tests to make sure the test will not fail, but can be skipped.

I cache my responses, in a LRU cache of 120 last calls (randomly picked number worth two hours af api calls).
"
Class {
	#name : #MicGitHubAPI,
	#superclass : #Object,
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

{ #category : #operations }
MicGitHubAPI >> get: aString [ 
	| response |
	response := (self requestTo: aString) get; response.
	^ self processResponse: response
	
]
