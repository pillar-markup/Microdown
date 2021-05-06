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

{ #category : #visiting }
MicAnchorReferenceInlineBlock >> accept: aVisitor [
	^ aVisitor visitMicAnchorReferenceBlock: self
]

{ #category : #'as yet unclassified' }
MicAnchorReferenceInlineBlock >> closingDelimiter [ 

	^ MicAnchorReferenceCloserDelimiter markup
]

{ #category : #'as yet unclassified' }
MicAnchorReferenceInlineBlock >> openingDelimiter [

	^ MicAnchorReferenceOpenerDelimiter markup
]
