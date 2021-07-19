Class {
	#name : #MicCleanAnnotationInParagraph,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'goal'
	],
	#category : #'Microdown - Transformer'
}

{ #category : #accessing }
MicCleanAnnotationInParagraph >> goal: aBuildGoal [ 
	
	goal := aBuildGoal
]

{ #category : #testing }
MicCleanAnnotationInParagraph >> paragraphIsSingleton: aParagraph [
	^ aParagraph children size = 1
]

{ #category : #testing }
MicCleanAnnotationInParagraph >> paragraphOnlyContainsAnnotation: aParagraph [
	^ (aParagraph children first isKindOf: MicAnnotationBlock)
		and: [ self paragraphIsSingleton: aParagraph ]
]

{ #category : #'visiting-document' }
MicCleanAnnotationInParagraph >> visitParagraph: aParagraph [
	(self paragraphOnlyContainsAnnotation: aParagraph)
		ifTrue: [ self replace: {aParagraph children first} ]
]

{ #category : #visiting }
MicCleanAnnotationInParagraph >> visitText: aText [
]
