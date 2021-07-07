Class {
	#name : #MicCleanAnnotationInParagraphTransformer,
	#superclass : #MicNodeTransformer,
	#instVars : [
		'goal'
	],
	#category : #'Microdown - Transformer'
}

{ #category : #accessing }
MicCleanAnnotationInParagraphTransformer >> goal: aBuildGoal [ 
	
	goal := aBuildGoal
]

{ #category : #testing }
MicCleanAnnotationInParagraphTransformer >> paragraphIsSingleton: aParagraph [
	^ aParagraph children size = 1
		or: [ self paragraphJustContainsALineBreakMore: aParagraph ]
]

{ #category : #testing }
MicCleanAnnotationInParagraphTransformer >> paragraphJustContainsALineBreakMore: aParagraph [
	^ aParagraph children size = 2
		and: [ aParagraph children second isKindOf: MicElement "I don't know what is the equivalent of PRLineBreak in Microdown" ]
]

{ #category : #testing }
MicCleanAnnotationInParagraphTransformer >> paragraphOnlyContainsAnnotation: aParagraph [
	^ ((aParagraph children size between: 1 and: 2) and: [ aParagraph children first isKindOf: MicAnnotationBlock ])
		and: [ self paragraphIsSingleton: aParagraph ]
]

{ #category : #'visiting-document' }
MicCleanAnnotationInParagraphTransformer >> visitParagraph: aParagraph [
	(self paragraphOnlyContainsAnnotation: aParagraph)
		ifTrue: [ self replace: {aParagraph children first} ]
]
