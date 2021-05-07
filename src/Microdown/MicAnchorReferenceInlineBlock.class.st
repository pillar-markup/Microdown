"
I represent a reference to a section, figure, environment. I follow the pattern `*@`, label, `@*`

```
See *@fig1@*
```

"
Class {
	#name : #MicAnchorReferenceInlineBlock,
	#superclass : #MicAbstractInlineBlock,
	#category : #'Microdown-ModelInline'
}

{ #category : #testing }
MicAnchorReferenceInlineBlock class >> isEvaluated [
	^ false
]

{ #category : #'as yet unclassified' }
MicAnchorReferenceInlineBlock >> accept: aVisitor [
 	^ aVisitor visitAnchorReferenceBlock: self
]

{ #category : #'as yet unclassified' }
MicAnchorReferenceInlineBlock >> closingDelimiter [

 	^ MicAnchorReferenceCloserDelimiter markup
]

{ #category : #'as yet unclassified' }
MicAnchorReferenceInlineBlock >> openingDelimiter [

 	^ MicAnchorReferenceOpenerDelimiter markup
]
