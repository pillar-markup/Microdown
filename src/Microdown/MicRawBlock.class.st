"
Raw lets the user place anything (so don't use it).

```
{{ raw contents}}
```
"
Class {
	#name : #MicRawBlock,
	#superclass : #MicInlineBlock,
	#category : #'Microdown-ModelInline'
}

{ #category : #testing }
MicRawBlock class >> isEvaluated [
	^ false
]

{ #category : #visiting }
MicRawBlock >> accept: aVisitor [
	^ aVisitor visitRaw: self
]

{ #category : #accessing }
MicRawBlock >> closingDelimiter [

 	^ MicRawCloserDelimiter markup
]

{ #category : #accessing }
MicRawBlock >> openingDelimiter [

 	^ MicRawOpenerDelimiter markup
]
