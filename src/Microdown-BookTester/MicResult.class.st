"
I represent an error result raised by MicReferenceChecker.

I am composed of:
- an explanation (of my error)
- a specification (the name of concerned file or reference)

All recognized error explanation are in allResult dictionary.

Use my constructor to instantiate me.

"
Class {
	#name : 'MicResult',
	#superclass : 'Object',
	#instVars : [
		'message',
		'status',
		'source',
		'explanation'
	],
	#category : 'Microdown-BookTester-Results',
	#package : 'Microdown-BookTester',
	#tag : 'Results'
}

{ #category : 'kinds' }
MicResult class >> errorType [

	^ self subclassResponsibility 
]

{ #category : 'kinds' }
MicResult class >> headerString [

	^ 'Unreferenced Figures'
]

{ #category : 'accessing' }
MicResult >> explanation [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
MicResult >> message [

	^ message
]

{ #category : 'accessing' }
MicResult >> message: anObject [

	message := anObject
]

{ #category : 'accessing' }
MicResult >> sourceFileReference [

	^ source
]

{ #category : 'accessing' }
MicResult >> sourceFileReference: anObject [

	source := anObject
]

{ #category : 'accessing' }
MicResult >> status [

	^ status
]

{ #category : 'accessing' }
MicResult >> status: anObject [

	status := anObject
]

{ #category : 'accessing' }
MicResult >> stonFormatExplanation [

	^ self subclassResponsibility
]
