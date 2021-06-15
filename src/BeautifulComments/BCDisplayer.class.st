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

{ #category : #'grammar - Script' }
BCDisplayer class >> script [ 
	<script>
	BCDisplayer new open
]

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
## About Paragraphs	
Followed by a nice paragraph 
on multiple lines

And another **paragraph** (written in bold) just for the _fun_ (the fun must be in italic) and some ~strike~. 

# Section Level 1
## Section Level 2
### Section Level 3
#### Section Level 4
##### Section Level 5
###### Section Level 6

# About monospace

This is `monospace` and this is `Point>>#degrees` and ` Point `

# Code

```
1 + 2
3 + 4
```





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
