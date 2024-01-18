"
I am responsible for formatting a codeblock for MicRichTextComposer.

If the codeblock is written as:
```text
  ```languageTag
  	some source code
  ```
```
I will find a subclass matching `languageTag`.
My subclasses identify tags it they will handle.
"
Class {
	#name : 'MicRichTextCodeBlockStyler',
	#superclass : 'Object',
	#category : 'Microdown-RichTextComposer-Composer',
	#package : 'Microdown-RichTextComposer',
	#tag : 'Composer'
}

{ #category : 'documentation' }
MicRichTextCodeBlockStyler class >> buildMicroDownUsing: aBuilder  withComment: aComment [
	super buildMicroDownUsing: aBuilder  withComment: aComment.
	"Only add this list here, not in my subclasses"
	self = MicRichTextCodeBlockStyler ifFalse: [ ^ self ].
	aBuilder newLine.
	aBuilder header: [ aBuilder text: 'Subclasses implementing stylers:' ] withLevel: 2.
	aBuilder unorderedListDuring: [ 
		self allSubclasses do: [ :class |
			aBuilder item: [ 
				aBuilder text: (class styleTags joinUsing: ', ' last: ' and '), ' is implemented by ' .
				aBuilder monospace: (class name)]
			]]
]

{ #category : 'accessing' }
MicRichTextCodeBlockStyler class >> styleTags [
	^ #()
]

{ #category : 'accessing' }
MicRichTextCodeBlockStyler class >> stylerFor: languageName [
	^ (self allSubclasses 
		detect: [ :cl | (cl styleTags collect: #asLowercase) includes: languageName asLowercase   ] 
		ifNone: [ MicRichTextCodeBlockStylerDefault]) new

]

{ #category : 'accessing' }
MicRichTextCodeBlockStyler >> style: sourceString [ 
	^ self subclassResponsibility
]
