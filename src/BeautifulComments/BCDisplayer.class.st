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

	^ '
#Microdown is quite cool

Here is some code 

```language=Pharo&caption=Beautiful&label=Fig1
   1000 factorial / 999 factorial
```

Here is a figure and a link: [http://pharo.org](http://pharo.org).

![Pharologo without mic parameters.](https://files.pharo.org/media/logo/logo.png)

![Pharologo with mic parameters.](https://files.pharo.org/media/logo/logo.png|size=80&caption=Our great figure.)



Here is a list:
- item 1
  1. sub item 1 
  3. sub item 2
- item 2


**Bold**, _italic_, `monospace`

In Pharo, Microdown supports hyperlinks to: 
- classes e.g., `Point`, 
- methodes e.g., `Point class`, `Point>>#setX:setY:`, and 
- packages e.g., `#''Microdown-Tests''` (for packages).

You can edit this file clicking on `ClySyntaxHelpMorph>>#rawMicrodownSyntax`.
'
]

{ #category : #'instance creation' }
BCDisplayer >> contents1 [
	^ '## Section Level 2
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





'
]

{ #category : #'instance creation' }
BCDisplayer >> open [ 
	"self new open"
	| window text | 
	window := SystemWindow labelled: 'Beautiful Displayer'.
	window extent: 600@400.
	text := self buildText.
	text setText: self richContents.
	window addMorph: text frame: (0 @ 0 corner: 1 @ 1).
	window openInWorld
]

{ #category : #'instance creation' }
BCDisplayer >> richContents [
	^ BCRichTextComposer new visit: (MicroDownParser new parse: self contents)
]
