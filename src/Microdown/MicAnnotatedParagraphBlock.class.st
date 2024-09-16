"
I represent a paragraph with the title. My title can only contain a string and my body can contain formatted text.

I was created with `!!label` with no space `!! label` (such as `@@note` `@@important` in Pillar).

```
!!note This is important so I used exclamation marks.
```

Now since Pillar 10.3 we used `>![` since it is closer to what Github uses. 

```
>![ note ] 
> This is important so I used exclamation marks.
```


### Known Limitations 
We should revisit the implementation because there is something unclear. 
The abstract class superclass does not look necessary.
"
Class {
	#name : 'MicAnnotatedParagraphBlock',
	#superclass : 'MicAbstractAnnotatedBlock',
	#instVars : [
		'validLabels'
	],
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'visiting' }
MicAnnotatedParagraphBlock >> accept: aVisitor [
 	^ aVisitor visitAnnotated: self
]

{ #category : 'parse support' }
MicAnnotatedParagraphBlock >> closeMe [
	super closeMe.
	self verifyLabel.
	body := self inlineParse: body
]

{ #category : 'testing' }
MicAnnotatedParagraphBlock >> defaultLabel [ 
	
	^ #note
]

{ #category : 'testing' }
MicAnnotatedParagraphBlock >> initialize [

	super initialize.
	validLabels := { #note. #important. #todo }
]

{ #category : 'testing' }
MicAnnotatedParagraphBlock >> lineMarkup [
	
	^ AnnotatedParagraphOpeningMarkup
]

{ #category : 'accessing' }
MicAnnotatedParagraphBlock >> text [

	^ String streamContents: [ :s |
		  self textElements do: [ :each | s nextPutAll: each plainText ] ]
]

{ #category : 'accessing' }
MicAnnotatedParagraphBlock >> textElements [

	^ self body
]

{ #category : 'parse support' }
MicAnnotatedParagraphBlock >> verifyLabel [

	| isValid |
	isValid := validLabels includes: label asLowercase.
	isValid
		ifTrue: [ label := label asLowercase ]
		ifFalse: [
			body := label , String space , body.
			label := self defaultLabel ]
]
