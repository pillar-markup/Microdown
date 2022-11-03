"
Raw lets the user place anything (so don't use it).

```
{{ raw contents}}
```
"
Class {
	#name : #MicRawBlock2,
	#superclass : #MicUnEvaluatedBlock2,
	#category : #'Microdown-InlineParser'
}

{ #category : #accessing }
MicRawBlock2 class >> closingDelimiter [

 	^ RawCloserMarkup
]

{ #category : #accessing }
MicRawBlock2 class >> openingDelimiter [

 	^ RawOpenerMarkup
]

{ #category : #visiting }
MicRawBlock2 >> accept: aVisitor [
	^ aVisitor visitRaw: self
]
