"
I represent a paragraph with the title. My title can only contain a string while my body can contain formatted text.

I'm created with `!!paragraph` (such as `@@note` `@@important` in Pillar).

!!note This is important so I used exclamatation mark.

### Known limits. 
We should revisit the implementation because there is something unclear. 
Currently we cannot add list for example inside a annotatedBlock.
See [https://github.com/pillar-markup/MicroDown/issues/54](https://github.com/pillar-markup/MicroDown/issues/54)

"
Class {
	#name : 'MicAnnotatedBlock',
	#superclass : 'MicAbstractAnnotatedBlock',
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'visiting' }
MicAnnotatedBlock >> accept: aVisitor [
 	^ aVisitor visitAnnotated: self
]

{ #category : 'parse support' }
MicAnnotatedBlock >> closeMe [
	super closeMe.
	body := self inlineParse: body
]

{ #category : 'testing' }
MicAnnotatedBlock >> lineMarkup [
	
	^ AnnotatedParagraphMarkup
]

{ #category : 'accessing' }
MicAnnotatedBlock >> text [

	^ String streamContents: [ :s | self textElements do: [ :each | s nextPutAll: each substring ] ]
]

{ #category : 'accessing' }
MicAnnotatedBlock >> textElements [

	^ self body
]
