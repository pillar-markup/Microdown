"
I'm a block level element that represent contents that will never be interpreted.
- Contents on the first line is ignored.
- Contents starts from the following line after the `{{{`

Here is a test illustrating such behavior.

```
testFirstLineAfterMarkupShouldBeIgnored
	""contents starts on the following line of the {{{""
	| root |
	root := parser parse: '{{{ blabla
**Hello is ... cut for real

a paragraph on two lines**
}}}'.

	self assert: root children first bodyString equals: '**Hello is ... cut for real

a paragraph on two lines**'.
```	
"
Class {
	#name : 'MicRawParagraphBlock',
	#superclass : 'MicStartStopMarkupBlock',
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'visiting' }
MicRawParagraphBlock >> accept: aVisitor [
	^ aVisitor visitRawParagraph: self
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
