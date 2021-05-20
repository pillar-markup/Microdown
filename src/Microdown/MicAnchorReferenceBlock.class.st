"
I represent a reference to a section, figure, environment. I follow the pattern `*@`, label, `@*`

```
See *@fig1@*
```

"
Class {
	#name : #MicAnchorReferenceBlock,
	#superclass : #MicInlineBlock,
	#category : #'Microdown-ModelInline'
}

{ #category : #testing }
MicAnchorReferenceBlock class >> isEvaluated [
	^ false
]

{ #category : #'as yet unclassified' }
MicAnchorReferenceBlock >> accept: aVisitor [
 	^ aVisitor visitAnchorReference: self
]

{ #category : #'as yet unclassified' }
MicAnchorReferenceBlock >> closingDelimiter [

 	^ MicAnchorReferenceCloserDelimiter markup
]

{ #category : #'as yet unclassified' }
MicAnchorReferenceBlock >> openingDelimiter [

 	^ MicAnchorReferenceOpenerDelimiter markup
]
