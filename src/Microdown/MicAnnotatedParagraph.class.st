"
I represent a paragraph with the title. My title can only contain a string and my body can contain formatted text.

I'm created with `!!paragraph` (such as `@@note` `@@important` in Pillar).

!!note This is important so I used exclamation marks.
 
### Known Limitations 
We should revisit the implementation because there is something unclear. 
For example, we cannot currently add lists inside an annotatedBlock.
See [https://github.com/pillar-markup/MicroDown/issues/54](https://github.com/pillar-markup/MicroDown/issues/54)
"
Class {
	#name : 'MicAnnotatedParagraph',
	#superclass : 'MicAbstractAnnotatedBlock',
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'visiting' }
MicAnnotatedParagraph >> accept: aVisitor [
 	^ aVisitor visitAnnotated: self
]

{ #category : 'parse support' }
MicAnnotatedParagraph >> closeMe [
	super closeMe.
	body := self inlineParse: body
]

{ #category : 'testing' }
MicAnnotatedParagraph >> lineMarkup [
	
	^ AnnotatedParagraphMarkup
]

{ #category : 'accessing' }
MicAnnotatedParagraph >> text [

	^ String streamContents: [ :s |
		  self textElements do: [ :each | s nextPutAll: each plainText ] ]
]

{ #category : 'accessing' }
MicAnnotatedParagraph >> textElements [

	^ self body
]
