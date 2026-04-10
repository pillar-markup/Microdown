"
I represent a reference to a section, figure, or environment. I follow the pattern `*@`, label, `@*`.

For example:
```text
See *@fig1@*
```
"
Class {
	#name : 'MicAnchorReferenceBlock',
	#superclass : 'MicUnEvaluatedBlock',
	#instVars : [
		'reference'
	],
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'accessing' }
MicAnchorReferenceBlock class >> closingDelimiter [

 	^ AnchorReferenceCloserMarkup
]

{ #category : 'accessing' }
MicAnchorReferenceBlock class >> openingDelimiter [

 	^ AnchorReferenceOpenerMarkup
]

{ #category : 'visiting' }
MicAnchorReferenceBlock >> accept: aVisitor [
 	^ aVisitor visitAnchorReference: self
]

{ #category : 'accessing' }
MicAnchorReferenceBlock >> anchorLabel [ 
	
	^ bodyString 
]

{ #category : 'accessing' }
MicAnchorReferenceBlock >> reference [

	^ reference
]

{ #category : 'accessing' }
MicAnchorReferenceBlock >> reference: anObject [

	reference := anObject
]
