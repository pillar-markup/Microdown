"
Raw lets the user place anything (so don't use it).

```
{{ raw contents}}
```
"
Class {
	#name : 'MicRawBlock',
	#superclass : 'MicInlineElement',
	#category : 'Microdown-ModelInline',
	#package : 'Microdown',
	#tag : 'ModelInline'
}

{ #category : 'testing' }
MicRawBlock class >> isEvaluated [
	^ false
]

{ #category : 'visiting' }
MicRawBlock >> accept: aVisitor [
	^ aVisitor visitRaw: self
]

{ #category : 'operations' }
MicRawBlock >> cleanSubstring [
	self substring: (MicInlineParser escapeReescape: self substring  except: '')
]

{ #category : 'accessing' }
MicRawBlock >> closingDelimiter [

 	^ RawCloserMarkup
]

{ #category : 'accessing' }
MicRawBlock >> kind [

 	^ #raw
]

{ #category : 'accessing' }
MicRawBlock >> openingDelimiter [

 	^ RawOpenerMarkup
]
