Class {
	#name : #MicPharoMethodResource,
	#superclass : #MicAbstractResource,
	#instVars : [
		'theMethod'
	],
	#category : #'Microdown-Core'
}

{ #category : #'instance creation' }
MicPharoMethodResource class >> on: aMethod reference: aReference [

	^ self new
		theMethod: aMethod;
		reference: aReference;
		yourself
]

{ #category : #visiting }
MicPharoMethodResource >> asRenderedOn: aRenderer withinNode: aFigure [

	^ aRenderer renderMethod: self inNode: aFigure
]

{ #category : #accessing }
MicPharoMethodResource >> asText [
	
	"Hook to add syntax highlighting"
	^ self contents asText
]

{ #category : #accessing }
MicPharoMethodResource >> contents [
	
	^ theMethod definitionString
]

{ #category : #accessing }
MicPharoMethodResource >> theMethod [

	^ theMethod
]

{ #category : #accessing }
MicPharoMethodResource >> theMethod: anObject [

	theMethod := anObject
]
