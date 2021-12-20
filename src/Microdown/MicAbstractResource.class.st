Class {
	#name : #MicAbstractResource,
	#superclass : #Object,
	#instVars : [
		'reference'
	],
	#category : #'Microdown-Core'
}

{ #category : #visiting }
MicAbstractResource >> accept: aVisitor [

	^ self subclassResponsibility
]

{ #category : #converting }
MicAbstractResource >> asForm [

	^ ImageReadWriter formFromStream: self binaryReadStream
]

{ #category : #visiting }
MicAbstractResource >> asRenderedOn: aRenderer withinNode: aFigure [

	^ self subclassResponsibility
]

{ #category : #accessing }
MicAbstractResource >> contents [
	
	self subclassResponsibility
]

{ #category : #accessing }
MicAbstractResource >> parseMicrodown [
	
	^ Microdown new parse: self contents
]

{ #category : #accessing }
MicAbstractResource >> reference [

	^ reference
]

{ #category : #accessing }
MicAbstractResource >> reference: anObject [

	reference := anObject
]
