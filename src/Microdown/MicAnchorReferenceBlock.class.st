"
I represent a reference to a section, figure, environment. I follow the pattern `*@`, label, `@*`

```
See *@fig1@*
```

"
Class {
	#name : 'MicAnchorReferenceBlock',
	#superclass : 'MicUnEvaluatedBlock',
	#instVars : [
		'reference'
	],
	#category : 'Microdown-InlineParser',
	#package : 'Microdown',
	#tag : 'InlineParser'
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
MicAnchorReferenceBlock >> reference [

	^ reference
]

{ #category : 'accessing' }
MicAnchorReferenceBlock >> reference: anObject [

	reference := anObject
]
