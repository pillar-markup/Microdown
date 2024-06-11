"
Raw lets the user place anything (so don't use it).

Example:
```text
{{ raw contents }}
```
"
Class {
	#name : 'MicRawBlock',
	#superclass : 'MicUnEvaluatedBlock',
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'accessing' }
MicRawBlock class >> closingDelimiter [

 	^ RawCloserMarkup
]

{ #category : 'accessing' }
MicRawBlock class >> openingDelimiter [

 	^ RawOpenerMarkup
]

{ #category : 'visiting' }
MicRawBlock >> accept: aVisitor [
	^ aVisitor visitRaw: self
]
