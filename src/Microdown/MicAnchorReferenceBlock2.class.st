"
I represent a reference to a section, figure, environment. I follow the pattern `*@`, label, `@*`

```
See *@fig1@*
```

"
Class {
	#name : #MicAnchorReferenceBlock2,
	#superclass : #MicUnEvaluatedBlock2,
	#instVars : [
		'reference'
	],
	#category : #'Microdown-InlineParser'
}

{ #category : #accessing }
MicAnchorReferenceBlock2 class >> closingDelimiter [

 	^ AnchorReferenceCloserMarkup
]

{ #category : #accessing }
MicAnchorReferenceBlock2 class >> openingDelimiter [

 	^ AnchorReferenceOpenerMarkup
]

{ #category : #visiting }
MicAnchorReferenceBlock2 >> accept: aVisitor [
 	^ aVisitor visitAnchorReference: self
]
