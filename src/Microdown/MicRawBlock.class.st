"
Raw lets the user place anything (so don't use it).

```
{{ raw contents}}
```
"
Class {
	#name : #MicRawBlock,
	#superclass : #MicInlineElement,
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

{ #category : #testing }
MicRawBlock >> cleanSubstring [
	"overrides to do nothing - super removes backslash, which we should not in raw"
]

{ #category : #accessing }
MicRawBlock >> closingDelimiter [

 	^ MicRawCloserDelimiter markup
]

{ #category : #accessing }
MicRawBlock >> kind [

 	^ #raw
]

{ #category : #accessing }
MicRawBlock >> openingDelimiter [

 	^ MicRawOpenerDelimiter markup
]
