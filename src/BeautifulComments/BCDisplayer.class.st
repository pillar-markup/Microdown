"
I'm a little utils to display come ""rich text"".

```
BCDisplayer new open
```
"
Class {
	#name : #BCDisplayer,
	#superclass : #Object,
	#category : #BeautifulComments
}

{ #category : #'instance creation' }
BCDisplayer >> buildText [ 
 
	| textModel scrolledText |
	textModel := RubScrolledTextModel new interactionModel: self.
	scrolledText := textModel newScrolledText
		beReadOnly;
		beWrapped;
		yourself.
	scrolledText textArea font: StandardFonts codeFont.
	^ scrolledText
]

{ #category : #'instance creation' }
BCDisplayer >> contents [ 
	^ BCRichTextComposer new visit: (MicroDownParser new parse: '## Section Level 2
	
Followed by a nice paragraph
on multiple lines

')
]

{ #category : #'instance creation' }
BCDisplayer >> open [ 
	"self new open"
	| window text | 
	window := SystemWindow labelled: 'Beautiful Displayer'.
	window extent: 600@400.
	text := self buildText.
	text setText: self contents.
	window addMorph: text frame: (0 @ 0 corner: 1 @ 1).
	window openInWorld
]
