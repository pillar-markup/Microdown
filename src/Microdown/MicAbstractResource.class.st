Class {
	#name : #MicAbstractResource,
	#superclass : #Object,
	#instVars : [
		'reference'
	],
	#category : #'Microdown-Core'
}

{ #category : #accessing }
MicAbstractResource >> asForm [

	self subclassResponsibility
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
