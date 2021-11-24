"
I am a visitor that produces rich text (class Text) based on a pillar document model.
I am implemented using a canvas/brush pattern. The class offers multiple configurations: an offline mode, 
a not rendering mode, and a not catching exceptions (to ease debugging).

The main API is the method: `BCRichTextComposer class>>#renderComment:of:`.

Web-based images or LaTeX rendering requires network access and are cached.



!!Note The composer should be improved to render better and in nicer ways elements. 

#### Advanced  
For the LaTeX rendering, internet connexion is required. 
You can also turn it off/on doing

```
BCRichTextComposer putOffLine
```

In addition, images fetched via http requests are cached to avoid multiple http requests.
The cache can be reset executing `PRRichTextComposer resetCache`. When the system is off line and an image is requested, a placeholder is computed but not put in the cache. This way when the system is put online the requested elements will be requested and put in the cache (without needing to flush placeholders from the cache).
When the system is online but the request failed I display an uncached placeholder.

It means that web-based images can be prefilled and Pharo images can be provided preloaded. 

When you want to get all the errors (typically to debug and fix them), you can configure the system to stop capturing errors using 

```
PRRichTextComposer captureErrors: false

```
\'


#### Known limits
Monospaced text (e.g., `Point`, `Point class`,  `Point>>#setX:setY:`, or `#'Pillar-ExporterPillar'`) uses TextAction to trigger browser opening on the corresponding element. It would be better to use a TextLink because the styler is aware of them. 


"
Class {
	#name : #MicRichTextComposer,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'canvas',
		'codeStyler',
		'textStyler'
	],
	#category : #'Microdown-RichTextComposer-Composer'
}

{ #category : #public }
MicRichTextComposer class >> asRichText: aDoc [
	
	^ self new asRichText: aDoc

]

{ #category : #examples }
MicRichTextComposer class >> exampleLatex [
	<sampleInstance>

	^ self parseAndCompose:
'V_i = C_0 - C_3
\frac{C_1\cos(\theta_i+C_3)}{C_4+C_1\cos(\theta_i+C_2)}'
]

{ #category : #examples }
MicRichTextComposer class >> exampleMicrodown1 [
	<sampleInstance>
	^ self parseAndCompose:  '### First section
and this is just **first** line 
1. Line 1 More here More here `More here More here` More here More here More here More here More here More here
   - Kasper tries the strange thing Kasper tries the strange thingKasper tries the strange thingKasper tries the strange thingKasper tries the strange thingKasper tries the strange thingKasper tries the strange thing
   - And one more _silly_ thingie
1. Line 2
   - Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla
   - Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla
1. Line 3'
]

{ #category : #examples }
MicRichTextComposer class >> exampleMicrodown11 [
	<sampleInstance>
	^ self parseAndCompose:
'### Latex mathematics 
It is possible to render latex math via a web services. Future version will cache the resulting expressions. 

$
 \frac{C_1\cos(\theta_i+C_3)}{C_4+C_1\cos(\theta_i+C_2)}
$

Cool eh?
'
]

{ #category : #examples }
MicRichTextComposer class >> exampleMicrodown1Large [
	<sampleInstance>
	^ self new textStyler: MicTextStylerLarge new; asRichText:  (Microdown parse: '# First section
and this is just **first** line 
1. Line 1 More here More here `More here More here` More here More here More here More here More here More here
   - Kasper tries the strange thing Kasper tries the strange thingKasper tries the strange thingKasper tries the strange thingKasper tries the strange thingKasper tries the strange thingKasper tries the strange thing
   - And one more _silly_ thingie
1. Line 2
   - Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla
   - Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla
1. Line 3')
]

{ #category : #examples }
MicRichTextComposer class >> exampleMicrodown3 [
	<sampleInstance>
	^ self parseAndCompose:
					'## Code Blocks
this is just _first_ line

```
Metacello new
   baseline: ''PillarRichTextExporter'';
   repository: ''github://kasperosterbye/PillarRichTextRender'';
   load.
```' 


]

{ #category : #examples }
MicRichTextComposer class >> exampleMicrodown4 [
	<sampleInstance>
	^ self parseAndCompose:
					'## Annotations
this is just _first_ line

!!todo remember to do annotations
and this is the second line'
]

{ #category : #examples }
MicRichTextComposer class >> exampleMicrodown5 [
	<sampleInstance>
	^ self parseAndCompose:
					'### Links
This is just first line with an inline web ref [Pharo](http://pharo.org/)

[Click me to go to http://pharo.org](http://pharo.org/)

Here are direct links to classes and method
- `String`
- `String>>#trim`

And this is another line'
]

{ #category : #examples }
MicRichTextComposer class >> exampleMicrodown6 [
	<sampleInstance>
	^ self parseAndCompose:
					'### Figures
This is just **first** line. Figures accessed via HTTP requests are cached for speed reasons. 
At max you should get one request per picture.

![A super nice Pharo logo.](https://files.pharo.org/media/logo/logo.png)

And this is the last line'
]

{ #category : #examples }
MicRichTextComposer class >> exampleMicrodown7 [
	<sampleInstance>
	^ self parseAndCompose:
					'# First section

1. `Point` should open a class browser on Point.
2. `Point class` should open a class browser on Point.
3. `Point >> setX:setY:` should open a browser on the correspoding method.
4. `#''Pillar-ExporterRichText''` should open a browser on the package.
5. But `Borrrrrken` does not display the same.
' 
]

{ #category : #examples }
MicRichTextComposer class >> exampleMicrodown8 [
	<sampleInstance>
	^ self parseAndCompose:
					'```language=PharoExpression
1 + 2 * 3  
```
' 
]

{ #category : #examples }
MicRichTextComposer class >> exampleMicrodown9 [
	<sampleInstance>
	
	^ self parseAndCompose: 
'In future versions, we should introduce adapted colorizer for expressions and for method bodies.
```language=PharoMethod
foo: arg
	^ arg + self
```
'
]

{ #category : #'class initialization' }
MicRichTextComposer class >> initialize [ 
	"self initialize"
	MicCodeStylerSpec initializeCache.
]

{ #category : #public }
MicRichTextComposer class >> microdownAsRichText: aString [
	
	^ self new visit: (Microdown parse: aString)

]

{ #category : #public }
MicRichTextComposer class >> parseAndCompose: aString [
	
	^ self new visit: (Microdown parse: aString)

]

{ #category : #'visiting - document' }
MicRichTextComposer >> anchorFor: anImageOrMorph of: aNode [

	aNode arguments at: #width ifPresent: [ :width |
		(width endsWith: '%') 
			ifTrue: [ |scale|
				scale := width initialIntegerOrNil.
				scale ifNotNil: [ 
					^ MicScalingTextAnchor new original: anImageOrMorph; scale: scale; yourself
					 ]]
		   ifFalse:  [ 
				width initialIntegerOrNil 
					ifNotNil: [ :absWidth | |absHeight|
						absHeight := anImageOrMorph height / anImageOrMorph width *absWidth.
						anImageOrMorph isMorph 
							ifTrue: [ ^ TextAnchor new anchoredMorph: (anImageOrMorph extent: absWidth @ absHeight) ]
							ifFalse: [ ^ TextAnchor new anchoredMorph: (anImageOrMorph scaledToSize: absWidth @ absHeight) ]
						  ]
		 ]].
	^ TextAnchor new anchoredMorph: anImageOrMorph
]

{ #category : #public }
MicRichTextComposer >> asRichText: aDocument [
	
	^ self visit: aDocument
]

{ #category : #accessing }
MicRichTextComposer >> codeStyler [

	^ codeStyler
]

{ #category : #initialization }
MicRichTextComposer >> initialize [
	super initialize.
	codeStyler := MicCodeStylerSpec. "Yes, the class"
	self textStyler:  MicTextStyler new 
]

{ #category : #private }
MicRichTextComposer >> latexFor: aString onError: aBlock [
	"return a MicResourceReference to an image for the latex formula in aString"
	| ref |
	ref := MicResourceReference fromUri: 'https://latex.codecogs.com/png.latex?', aString urlEncoded.
	^ ref loadImage
		ifNotNil: [ :image | image asText]
		ifNil: [ aBlock value asText ]
]

{ #category : #private }
MicRichTextComposer >> renderTableCell: aCell [
	"a cell is an array of nodes. Each element should be rendered and concatenated"
	^ aCell inject: Text new into: [ :txt :part | 
		txt, (MicRichTextComposer new visit: part)
		 ]
]

{ #category : #'visiting - document' }
MicRichTextComposer >> resizeImage: anImage of: aFigure [

	| scaledImage |
	scaledImage := anImage.
	"aFigure arguments at: #width ifPresent: [ :s |
		hostMorph 
			ifNotNil: [
				scaledImage := anImage scaledToSize: ( s asNumber in: [ :scale | 
					(hostMorph width / 100 * scale) @ (hostMorph height / 100 * scale)]).
		 ]]."
	^ scaledImage
]

{ #category : #accessing }
MicRichTextComposer >> textStyler [

	^ textStyler
]

{ #category : #accessing }
MicRichTextComposer >> textStyler: aTextStyler [

	textStyler := aTextStyler.
]

{ #category : #initialization }
MicRichTextComposer >> theme [

	^  Smalltalk ui theme
]

{ #category : #accessing }
MicRichTextComposer >> todo [ 
	^ 'there is too much hspace after a section when it is followed by a paragraph. 
This also because people will not want to to not let a newline between the header and paragraph when writing the text.'
]

{ #category : #visiting }
MicRichTextComposer >> visit: aDocument [
	
	canvas := MicRichTextCanvas new textStyler: self textStyler; yourself  .
	super visit: aDocument.
	^ canvas contents
]

{ #category : #'visiting - document' }
MicRichTextComposer >> visitAnnotatedParagraph: anAnnotatedParagraph [
	"Do nothing - You are supposed to use specialized annotations"
	self error: 'You are not supposed to be here - did you misspell an annotation type?'
	
]

{ #category : #'visiting -  format' }
MicRichTextComposer >> visitBold: anObject [
	canvas 
		includeAttribute: TextEmphasis bold 
		in: [ super visitBold: anObject ]
	
]

{ #category : #'visiting - document' }
MicRichTextComposer >> visitCode: aCodeBlock [

	canvas newLineIfNotAlready.
	canvas indentIn: [ 
		canvas
			<< (self codeStyler 
				style: aCodeBlock body 
				asLanguage: aCodeBlock language);
			newLine.
		aCodeBlock hasCaption ifTrue: [ 
			canvas 
				includeAttribute: TextEmphasis bold 
				in: [ 
					canvas
						<< aCodeBlock caption asText;
					newLine ]]].
]

{ #category : #'visiting -  format' }
MicRichTextComposer >> visitColumn: columnBlock [
	"I do nothing - handled by columns"
	
	
]

{ #category : #'visiting -  format' }
MicRichTextComposer >> visitColumns: columnsBlock [
	"I render the using MicRichTable which is dedicated to this. I insert the table as an image (form)"
	| columns columnsBlocks totalWidth|
	canvas newLineIfNotAlready.
	columnsBlocks := columnsBlock children select: [ :c | c isKindOf: MicColumnBlock].
	columns := columnsBlocks collect: [ :column | |colText|
		colText := Microdown asRichText: (MicRootBlock new children: column children;yourself).
		RubScrolledTextMorph new setText: colText. 
		].
	totalWidth := columns sum: [ :col | col textArea width].
	columns do: [ :morph |
		canvas << ((String value: 1) asText addAttribute: 
			(MicScalingTextAnchor new 
				original: morph;
				"There need to be a bit of extra space assigned (5%)"
				scale: (morph textArea width / totalWidth * 100)-5;
				"Need to add a bit of space (15) for the scrollbar to disappear"
				freezeHeight: morph textArea height+15))].
	canvas newLine 
	
	
]

{ #category : #'visiting - document' }
MicRichTextComposer >> visitEnvironment: anObject [
	self error: 'It was a halt'.
	"What is this textBlock idea? Clean!"
	anObject name = 'textBlock'
		ifTrue:[
			canvas indentIn: [  
				canvas 
					includeAttribute: TextEmphasis italic  
					in: [self visitFormat: anObject]] ]
		ifFalse: [canvas << ('>>> Environment ' , anObject name , 
						'is not supported in RichText Pillar <<<') asText]
]

{ #category : #'visiting - inline elements' }
MicRichTextComposer >> visitFigure: aFigure [

	| image textContribution |
	image := aFigure reference loadImage.
	image ifNotNil: [ 
		textContribution := (String value: 1) asText 
			addAttribute: (self anchorFor: image of: aFigure ) ].
	canvas << (textContribution ifNil: [ aFigure caption asText ])
]

{ #category : #'visiting - document' }
MicRichTextComposer >> visitHeader: aHeader [

	canvas newLineIfNotAlready.
	canvas
		includeAttribute: (self textStyler headerLevelFont: aHeader level)
		in: [ super visitHeader: aHeader ].
	canvas newLine
]

{ #category : #'visiting - document' }
MicRichTextComposer >> visitHorizontalLine: anHorizontalLine [
	
	canvas newLineIfNotAlready.
	canvas includeAttribute: TextEmphasis underlined in: [ canvas << ('     ' repeat: 20) asText ].
	canvas newLine.	
]

{ #category : #'visiting -  format' }
MicRichTextComposer >> visitItalic: anObject [
	canvas 
		includeAttribute: TextEmphasis italic 
		in: [ super visitItalic: anObject ]
]

{ #category : #'visiting - document' }
MicRichTextComposer >> visitLink: aLink [

	| attribute |
	attribute := TextAction new
		             actOnClickBlock: [ 
			             WebBrowser openOn: aLink url ];
		             yourself.
	canvas includeAttribute: attribute in: [ super visitLink: aLink ]
]

{ #category : #'visiting - list' }
MicRichTextComposer >> visitListItem: anItem [
	| bullet |
	"The depth counter and bullet type in `visitOrderedList` and `visitUnorderedList`"
	bullet := (anItem propertyAt: #kind) = #ordered
		ifTrue: [ (anItem propertyAt: #counter) asString asText , String tab ]
		ifFalse: [ (anItem propertyAt: #bullet) asText , String tab ].
	bullet addAttribute: (TextIndent tabs: canvas nesting - 1).
	canvas newLineIfNotAlready.
	canvas << bullet.
	canvas indentIn: [ super visitListItem: anItem ].

]

{ #category : #'visiting - document' }
MicRichTextComposer >> visitMath:  aMicMathEnvironment [

	| aString |
	aString := aMicMathEnvironment body.
	aString ifEmpty: [ ^self ].
	canvas << (self latexFor: aString onError: ['& - LATEX ERROR - &' asText] )
]

{ #category : #'visiting - document' }
MicRichTextComposer >> visitMathInline: aMicMathInline [ 
	| aString  |
	aString := aMicMathInline substring .
   aString ifEmpty: [^ self].
	canvas << (self latexFor: aString onError: [ '$ - LATEX ERROR - $' asText ])
]

{ #category : #'visiting -  format' }
MicRichTextComposer >> visitMonospace: anObject [
	"Notice - I add a highlight to the backgorund rather than mono-spaced."
	| backgroundColor sem |
	backgroundColor := self textStyler monospaceBackgroundColor.
	
	self flag: #fixMe.
	"Right now we stupidly emit TextAction but we should emit TextClassLink and revisit them."
	canvas 
		includeAttribute: (TextBackgroundColor color: backgroundColor) 
		in: [ 
			sem := MicSemanticAction from: anObject text.
			sem hasEntity 
				ifTrue: [ canvas 
								includeAttribute: (TextAction new actOnClickBlock: [ sem entity browse ]) 
								in: [ super visitMonospace: anObject ] ]
				ifFalse: [ super visitMonospace: anObject]].  
]

{ #category : #'visiting - list' }
MicRichTextComposer >> visitOrderedList: anObject [
	"here we annotate items with their kind and the depth"
	| counter |
	canvas newLineIfNotAlready.
	canvas indentIn: [counter := 1.
		anObject children
			do: [ :item | 
				item propertyAt: #kind put: #ordered.
				item
					propertyAt: #counter
					put: (self textStyler counterFor: counter atLevel: canvas nesting - 1).
				counter := counter + 1 ].
		super visitOrderedList: anObject ].
	canvas newLine
]

{ #category : #'visiting - document' }
MicRichTextComposer >> visitParagraph: anObject [
	
	canvas newLineIfNotAlready.
	super visitParagraph: anObject.
]

{ #category : #'visiting - document' }
MicRichTextComposer >> visitParameters: anObject [
	"do nothing for now"
	
	^ self
]

{ #category : #'visiting -  format' }
MicRichTextComposer >> visitStrike: anObject [

	canvas 
		includeAttribute: TextEmphasis struckOut 
		in: [ super visitStrike: anObject ]
]

{ #category : #'visiting -  format' }
MicRichTextComposer >> visitTable: tableBlock [
	"I render the using MicRichTable which is dedicated to this. I insert the table as an image (form)"
	| headers rows table anchoredTable renderedRows |
	renderedRows := tableBlock rows collect: [ :oneRow | oneRow collect: [ :cell | self renderTableCell: cell ]].
	tableBlock hasHeader
		ifTrue: [ 
			headers := renderedRows first. 
			rows := renderedRows allButFirst  ]
		ifFalse: [ 
			headers := (1 to: renderedRows first size) collect: [:i | i printString asText].
			rows := renderedRows].
	"Create the Morphic Table and insert it"
	table := MicRichTextTable headers: headers rows: rows.
	tableBlock hasHeader
		ifFalse: [ 
			table extent: table extent - (0 @ '1' asTextMorph height). "not showing the headers"
			table hideColumnHeaders  ].
	anchoredTable := (String value: 1) asText addAttribute: (TextAnchor new anchoredMorph: table).
	canvas newLineIfNotAlready;newLine.
	canvas << anchoredTable
	
]

{ #category : #'visiting -  format' }
MicRichTextComposer >> visitText: anInlineBlock [
	"we should set attribute because it would override link and others."
	canvas << anInlineBlock substring asText
]

{ #category : #'visiting - list' }
MicRichTextComposer >> visitUnorderedList: anObject [
	canvas newLineIfNotAlready.
	canvas
		indentIn: [ 
			anObject children
				do: [ :item | 
					item propertyAt: #kind put: #unordered.
					item
						propertyAt: #bullet
						put: (self textStyler bulletForLevel: canvas nesting - 1) ].
			super visitUnorderedList: anObject ].
	canvas newLine
]
