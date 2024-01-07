"
Raw lets the user place anything (so don't use it).

```
{{ raw contents}}
```
"
Class {
	#name : #MicRawBlock,
	#superclass : #MicUnEvaluatedBlock,
	#category : #'Microdown-InlineParser'
}

{ #category : #accessing }
MicRawBlock class >> closingDelimiter [

 	^ RawCloserMarkup
]

{ #category : #accessing }
MicRawBlock class >> openingDelimiter [

 	^ RawOpenerMarkup
]

{ #category : #visiting }
MicRawBlock >> accept: aVisitor [
	^ aVisitor visitRaw: self
]
