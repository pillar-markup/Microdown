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

{ #category : #accessing }
MicRawBlock class >> closingDelimiter [

 	^ RawCloserMarkup
]

{ #category : #testing }
MicRawBlock class >> isEvaluated [
	^ false
]

{ #category : #accessing }
MicRawBlock class >> openingDelimiter [

 	^ RawOpenerMarkup
]

{ #category : #parsing }
MicRawBlock class >> parse: delimiter stream: aTokenStream for: aParser [

	^ aParser
		  parseNonEvaluatedBlock: self
		  token: delimiter
		  stream: aTokenStream
]

{ #category : #visiting }
MicRawBlock >> accept: aVisitor [
	^ aVisitor visitRaw: self
]

{ #category : #operations }
MicRawBlock >> cleanSubstring [
	self substring: (MicInlineParser escapeReescape: self substring  except: '')
]

{ #category : #accessing }
MicRawBlock >> closingDelimiter [
	^ self class closingDelimiter
]

{ #category : #accessing }
MicRawBlock >> kind [

 	^ #raw
]

{ #category : #accessing }
MicRawBlock >> openingDelimiter [
	^ self class openingDelimiter
]
