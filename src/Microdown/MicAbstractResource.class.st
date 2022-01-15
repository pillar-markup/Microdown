"
I represent found/resolved resources. 
Do not confuse me with ResourceReference, a resource reference is a reference to an unresolved and potentially not reachable or unexisting resource.

For now I know how to convert myself into a form, a document tree, 
"
Class {
	#name : #MicAbstractResource,
	#superclass : #Object,
	#instVars : [
		'reference'
	],
	#category : #'Microdown-Core'
}

{ #category : #converting }
MicAbstractResource >> asForm [

	^ ImageReadWriter formFromStream: self binaryReadStream
]

{ #category : #visiting }
MicAbstractResource >> asRenderedOn: aRenderer withinNode: aFigure [

	^ self subclassResponsibility
]

{ #category : #converting }
MicAbstractResource >> binaryReadStream [
	
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
