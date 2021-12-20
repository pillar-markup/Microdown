Class {
	#name : #MicPharoClassResource,
	#superclass : #MicAbstractResource,
	#instVars : [
		'theClass'
	],
	#category : #'Microdown-Core'
}

{ #category : #'instance creation' }
MicPharoClassResource class >> on: aClass reference: aReference [

	^ self new
		theClass: aClass;
		reference: aReference;
		yourself
]

{ #category : #accessing }
MicPharoClassResource >> asRenderedOn: aRenderer withinNode: aNode [

	^ aRenderer renderPharoClassResource: self inNode: aNode
]

{ #category : #accessing }
MicPharoClassResource >> asText [
	
	"Could be extended later to add syntax highlighting given an environment"
	^ self contents asText
]

{ #category : #accessing }
MicPharoClassResource >> contents [
	
	^ theClass definitionString
]

{ #category : #accessing }
MicPharoClassResource >> theClass [

	^ theClass
]

{ #category : #accessing }
MicPharoClassResource >> theClass: anObject [

	theClass := anObject
]
