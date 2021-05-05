"
Raw lets the user place anything (so don't use it).

```
{{ raw contents}}
```
"
Class {
	#name : #MicRawInlineBlock,
	#superclass : #MicAbstractInlineBlock,
	#category : #'Microdown-ModelInline'
}

{ #category : #testing }
MicRawInlineBlock class >> isEvaluated [
	^ false
]

{ #category : #accessing }
MicRawInlineBlock >> closingDelimiter [

	^ MicRawCloserDelimiter markup
]

{ #category : #accessing }
MicRawInlineBlock >> openingDelimiter [

	^ MicRawOpenerDelimiter markup
]
