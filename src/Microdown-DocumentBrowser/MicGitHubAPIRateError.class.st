"
I am an error raised when there is not enough api calls left to complete the call.
Github restricts the number of api calls to 60 per hour
"
Class {
	#name : #MicGitHubAPIRateError,
	#superclass : #Error,
	#instVars : [
		'response'
	],
	#category : #'Microdown-DocumentBrowser-ResourceModel'
}

{ #category : #accessing }
MicGitHubAPIRateError >> response [

	^ response
]

{ #category : #accessing }
MicGitHubAPIRateError >> response: anObject [

	response := anObject
]
