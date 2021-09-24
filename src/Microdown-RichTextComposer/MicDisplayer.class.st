"
I'm a little utils to display come ""rich text"".

```
MicDisplayer new open
```
"
Class {
	#name : #MicDisplayer,
	#superclass : #Object,
	#category : #'Microdown-RichTextComposer'
}

{ #category : #'grammar - Script' }
MicDisplayer class >> script [ 
	<script>
	MicDisplayer new open
]

{ #category : #'instance creation' }
MicDisplayer >> buildText [ 
 
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
MicDisplayer >> contents [

	^ '
	
# Lists

- easy 
- peasy
- nice

And some others 

10. Ordered item
   	- unordered1
   - unordered2
11. Ordered item


Here is a list:
- item 1
  1. sub item 1
     pillou pilpu, yes we are on the second line
     and the third line.
  3. sub item 2
- item 2


# Math support

You can use an environment or a simple expression in text such as $C_0 - C_3$ or $f(a) = \\frac{1}{2\\pi i} \\oint_{\\gamma} \\frac{f(z)}{z - a} dz$.

Here are some example of environments:

&
V_i = C_0 - C_3
&

&
\\sin(x) = \\sum_{n=0}^{\\infty} \\frac{(-1)^{n}x^{2n+1}}{(2n+1)!}
&


# Code 

```language=Pharo&caption=A beautiful code snippet&label=Fig1
1000 factorial / 999 factorial
>>> 1000
```

# Figures 
Here is a figure and a link: [http://pharo.org](http://pharo.org).

![Pharologo without mic parameters.](https://files.pharo.org/media/logo/logo.png)

![Pharologo with mic parameters.](https://files.pharo.org/media/logo/logo.png?size=80&caption=Our great figure.)



# Formats and hyperlinks

**Bold**, _italic_, `monospace`

In Pharo, Microdown supports hyperlinks to: 
- classes e.g., `Point`, 
- methodes e.g., `Point class`, `Point>>#setX:setY:`, and 
- packages e.g., `#''Microdown-Tests''` (for packages).


'
]

{ #category : #'instance creation' }
MicDisplayer >> contents1 [
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
MicDisplayer >> open [ 
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
MicDisplayer >> richContents [
	^ MicRichTextComposer new visit: (MicroDownParser new parse: self contents)
]
