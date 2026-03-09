"
I'm a block level element that represent contents that will never be interpreted.

```
{{{
here is some contents
that will never be changed
}}}
```
"
Class {
	#name : 'MicRawParagraphBlock',
	#superclass : 'MicStartStopMarkupBlock',
	#category : 'Microdown-Core',
	#package : 'Microdown',
	#tag : 'Core'
}

{ #category : 'visiting' }
MicRawParagraphBlock >> accept: aVisitor [
	^ aVisitor visitBlockLevelRawParagraph: self
]

{ #category : 'markups' }
MicRawParagraphBlock >> lineStartMarkup [

	^ BlockLevelRawOpenerMarkup 
]

{ #category : 'markups' }
MicRawParagraphBlock >> lineStopMarkup [

	^ MetaDataClosingBlockMarkup 
]

{ #category : 'printing' }
MicRawParagraphBlock >> printOn: aStream [

	aStream nextPutAll: '{{{'.
	aStream nextPutAll: self body.
	aStream nextPutAll: '}}}'
]
