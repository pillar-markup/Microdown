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
		'explanation',
		'specification'
	],
	#classInstVars : [
		'allMessages'
	],
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'accessing' }
MicResult class >> allMessages [
	^ allMessages ifNil: [ 
		allMessages := Dictionary new.
		allMessages
			at: #anchorIsMissing put: 'A reference refers to a missing anchor';
			at: #twoAnchorsSameName put: '2 anchors are declared with the same name'.
		^ allMessages ]
]

{ #category : 'accessing' }
MicResult class >> explanation: aMethodSymbol withSpecification: aSpecification [
	^ self new explanation: (self allMessages at: aMethodSymbol); specification: aSpecification asString; yourself.
]

{ #category : 'accessing' }
MicResult >> explanation [

	^ explanation
]

{ #category : 'accessing' }
MicResult >> explanation: anObject [

	explanation := anObject
]

{ #category : 'accessing' }
MicResult >> printOn: aStream [
	aStream nextPutAll: 'Error explanation: "', self explanation asString, '", with specification: "', self specification asString, '"'
	
]

{ #category : 'accessing' }
MicResult >> specification [

	^ specification
]

{ #category : 'accessing' }
MicResult >> specification: anObject [

	specification := anObject
]
