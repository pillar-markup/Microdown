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
		'monospaceBackgroundColor',
		'superscriptColor',
		'subscriptColor',
		'annotatedParagraphColor',
		'annotatedParagraphAnnotationColor',
		'annotatedParagraphAlignment'
	],
	#classVars : [
		'CaptureErrors',
		'HeaderFontSizes',
		'HeaderFonts',
		'ImageCache',
		'NotRendering',
		'OffLine',
		'Stylers'
	],
	#classInstVars : [
		'imageCache'
	],
	#category : #'Microdown-RichTextComposer'
}

{ #category : #private }
MicRichTextComposer class >> bulletForLevel: level [
	| kind |
	kind := level % 2.
	kind = 0
		ifTrue: [ ^ $• asText ].
	kind = 1
		ifTrue: [ ^ $- asText ]
]

{ #category : #images }
MicRichTextComposer class >> cachedImageFromUrl: aUrl [
	
	^ OffLine 
		ifFalse: [
			ImageCache 
				at: aUrl asString
				ifAbsentPut: [ self rawImageFrom: aUrl ] ] 
		ifTrue: [ self imageOffLineFromUrl: aUrl ]
]

{ #category : #'class initialization' }
MicRichTextComposer class >> captureErrors [
	
	^ CaptureErrors
]

{ #category : #'class initialization' }
MicRichTextComposer class >> captureErrors: aBoolean [
	"self captureErrors: false"
	CaptureErrors := aBoolean
]

{ #category : #styler }
MicRichTextComposer class >> codeStylerForMethod: aString [
	<codeblockStylerFor: 'Method'>
	^MicSmalltalkTextStyler new 
		isForWorkspace: false; 
		styledTextFor: aString asText
]

{ #category : #styler }
MicRichTextComposer class >> codeStylerForPharo: aString [
	<codeblockStylerFor: 'Pharo'>
	"For full methods use style 'Method'"
	^MicSmalltalkTextStyler new 
		isForWorkspace: true; 
		styledTextFor: aString asText
]

{ #category : #styler }
MicRichTextComposer class >> codeStylerForSmalltalk: aString [
	<codeblockStylerFor: 'Smalltalk'>
	^MicSmalltalkTextStyler new 
		isForWorkspace: true; 
		styledTextFor: aString asText
]

{ #category : #private }
MicRichTextComposer class >> computeHeaderFonts [
	
	HeaderFonts := Array new:  HeaderFontSizes size.
	1 to: HeaderFontSizes size do: [ :index |
		HeaderFonts at: index put: 
			(TextFontReference
				toFont:
					(StrikeFont
						familyName: 'Bitmap Source Sans Pro'
						pointSize: (HeaderFontSizes at: index)))
			  ]
]

{ #category : #private }
MicRichTextComposer class >> counterFor: counter atLevel: level [
	| kind |
	kind := level % 3.
	kind = 0
		ifTrue: [ ^ counter asString asText , '.' ].
	kind = 1
		ifTrue: [ ^ ($a asInteger + (counter - 1)) asCharacter asText , ')' ].
	kind = 2
		ifTrue: [ ^ ($A asInteger + (counter - 1)) asCharacter asText , ')' ]
]

{ #category : #styler }
MicRichTextComposer class >> defaultStyler: aString [
	<codeblockStylerFor: 'default'>
	"Pay attention without this one the logic can loop."
	
	^ self codeStylerForPharo: aString
]

{ #category : #examples }
MicRichTextComposer class >> exampleMicrodown1 [
	<example>
	(self microdownAsRichText: '### First section
and this is just **first** line 
1. Line 1 More here More here `More here More here` More here More here More here More here More here More here
   - Kasper tries the strange thing Kasper tries the strange thingKasper tries the strange thingKasper tries the strange thingKasper tries the strange thingKasper tries the strange thingKasper tries the strange thing
   - And one more _silly_ thingie
1. Line 2
   - Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla
   - Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla
1. Line 3') inspect
]

{ #category : #examples }
MicRichTextComposer class >> exampleMicrodown11 [
	<example>
	(self microdownAsRichText:
'### Latex mathematics 
It is possible to render latex math via a web services. Future version will cache the resulting expressions. 

$
 \frac{C_1\cos(\theta_i+C_3)}{C_4+C_1\cos(\theta_i+C_2)}
$

Cool eh?
') inspect
]

{ #category : #examples }
MicRichTextComposer class >> exampleMicrodown3 [
	<example>
	(self microdownAsRichText:
					'## Code Blocks
this is just _first_ line

```
Metacello new
   baseline: ''PillarRichTextExporter'';
   repository: ''github://kasperosterbye/PillarRichTextRender'';
   load.
```') inspect


]

{ #category : #examples }
MicRichTextComposer class >> exampleMicrodown4 [
	<example>
	(self microdownAsRichText:
					'## Annotations
this is just _first_ line

!!todo remember to do annotations
and this is the second line') inspect
]

{ #category : #examples }
MicRichTextComposer class >> exampleMicrodown5 [
	<example>
	(self microdownAsRichText:
					'### Links
This is just first line with an inline web ref [Pharo](http://pharo.org/)

[Click me to go to http://pharo.org](http://pharo.org/)

Here are direct links to classes and method
- `String`
- `String>>#trim`

And this is another line') inspect
]

{ #category : #examples }
MicRichTextComposer class >> exampleMicrodown6 [
	<example>
	(self microdownAsRichText:
					'### Figures
This is just **first** line. Figures accessed via HTTP requests are cached for speed reasons. 
At max you should get one request per picture.

![A super nice Pharo logo.](https://files.pharo.org/media/logo/logo.png)

And this is the last line') inspect
]

{ #category : #examples }
MicRichTextComposer class >> exampleMicrodown7 [
	<example>
	(self microdownAsRichText:
					'# First section

1. `Point` should open a class browser on Point.
2. `Point class` should open a class browser on Point.
3. `Point >> setX:setY:` should open a browser on the correspoding method.
4. `#''Pillar-ExporterRichText''` should open a browser on the package.
5. But `Borrrrrken` does not display the same.
') inspect
]

{ #category : #examples }
MicRichTextComposer class >> exampleMicrodown8 [
	<example>
	(self microdownAsRichText:
					'```language=PharoExpression
1 + 2 * 3  
```
') inspect
]

{ #category : #examples }
MicRichTextComposer class >> exampleMicrodown9 [
	<example>
	
	(self microdownAsRichText: 
'In future versions, we should introduce adapted colorizer for expressions and for method bodies.
```language=PharoMethod
foo: arg
	^ arg + self
```
') inspect
]

{ #category : #private }
MicRichTextComposer class >> headerFontSizes: anArray [

	HeaderFontSizes := anArray.
	self computeHeaderFonts 
]

{ #category : #private }
MicRichTextComposer class >> headerFonts: anArray [

	HeaderFontSizes := anArray
]

{ #category : #private }
MicRichTextComposer class >> headerLevelFont: level [
	"I return a font annotation to be used with Attributes"

	^ HeaderFonts at: level
]

{ #category : #'class initialization' }
MicRichTextComposer class >> imageAt: urlString put: aForm [	
	"the cache contains results of for example ZnEasy getPng:, i.e., a form"
	
	ImageCache at: urlString put: aForm
]

{ #category : #accessing }
MicRichTextComposer class >> imageCache [
	^ imageCache ifNil: [ imageCache := LRUCache new ]
]

{ #category : #'images internal' }
MicRichTextComposer class >> imageOffLineFromUrl: aUrl [
	"we are off but the image is there so we return it,"
	^ ImageCache 
			at: aUrl asString
			ifPresent: [ :i | i ]
			ifAbsent: [ (StringMorph contents: 'The HTTP request got unsuccessful. 
When you will be online, you should see: ' , aUrl asString) imageForm  ]
			
]

{ #category : #'images internal' }
MicRichTextComposer class >> imageUnexpectedContentFromUrl: aUrl [
	"The request got unexpected content if the image is there so we return it. We do not cache the failing case image form so that we do not polute the cache."
	
	^ ImageCache 
			at: aUrl asString
			ifPresent: [ :i | i ]
			ifAbsent: [ (StringMorph contents: 'The HTTP request ', aUrl asString, ' returned an unexpected content.' ) imageForm  ]
			
]

{ #category : #'class initialization' }
MicRichTextComposer class >> initialize [ 
	"self initialize"
	self offline: false.
	self notRendering: false.
	self resetCache.
	self headerFontSizes: #(18 14 12 11 10 10).
	self initializeStylers.
	self captureErrors: true.
]

{ #category : #'class initialization' }
MicRichTextComposer class >> initializeStylers [
	"self initializeStylers"

	Stylers := Dictionary
		newFromAssociations: ((PragmaCollector
			filter: [ :prg | 
				prg selector = 'codeblockStylerFor:' and: [ 
					"When debugging stylers, make sure no old ones are included"
				prg method methodClass isObsolete not ] ]) reset
			collected collect: [ :prg | prg arguments first asLowercase-> prg method ])
]

{ #category : #styler }
MicRichTextComposer class >> languageStylerFor: aLanguage [

	^ Stylers
		at: aLanguage asLowercase
		ifAbsent: [ self languageStylerFor: 'default' ]
]

{ #category : #examples }
MicRichTextComposer class >> latexExample [
	<example>

	(MicRichTextComposer new visit: 
		(MicMathInlineBlock new 
		substring:
'V_i = C_0 - C_3
\frac{C_1\cos(\theta_i+C_3)}{C_4+C_1\cos(\theta_i+C_2)}')) inspect
]

{ #category : #styler }
MicRichTextComposer class >> latexMathStylerFor: aString [
	"<codeblockStylerFor:'latexMath'>
	
	this is totally bogus: this method does not return a styler but just an image."
	
	| expressionUrl |
   aString ifEmpty: [^'' asText].
	expressionUrl := 'https://latex.codecogs.com/png.latex?', aString urlEncoded.
	^self loadExternalImageFromURL: expressionUrl errorText: 'Latex error'.
]

{ #category : #private }
MicRichTextComposer class >> loadExternalImageFromURL: aUrl errorText: errorDesc [
	"I return a Text instance with an loaded from a url"
	
	| anchoredImage |
	self flag: #cleanAndRevisit.
	"there is duplication in the visitFigure: method!!!"
	anchoredImage := self imageCache 
		at: aUrl 
		ifAbsentPut: [ 
			[ anchoredImage := (String value: 1) asText
					addAttribute: (TextAnchor new anchoredMorph: (ZnEasy getPng: aUrl)).
				anchoredImage ] 
			on: Exception 
			do: [ errorDesc asText addAttribute: TextColor red ]
		].
	^ anchoredImage 
]

{ #category : #examples }
MicRichTextComposer class >> microdownAsRichText: aString [
	
	^ self new visit: (Microdown new resolvedTreeFrom: aString)

]

{ #category : #'class initialization' }
MicRichTextComposer class >> notRendering [
	"When notRendering, the comments are just displayed as plain text."
	
	^ NotRendering
]

{ #category : #'class initialization' }
MicRichTextComposer class >> notRendering: aBoolean [
	NotRendering := aBoolean
]

{ #category : #'class initialization' }
MicRichTextComposer class >> offline [

	^ OffLine
]

{ #category : #'class initialization' }
MicRichTextComposer class >> offline: aBoolean [

	OffLine := aBoolean

]

{ #category : #settings }
MicRichTextComposer class >> preferencesSettingsOn: aBuilder [
	<systemsettings>
	(aBuilder group: #comments)
		label: 'Comment rendering';  
		parent: #appearance;
		description: 'All settings concerned with the control of nice comment rendering';
		with: [
		(aBuilder setting: #offline)
			label: 'To enable offline mode';
			target: self;
			default: false;
			description: '
			When online is chosen, requests to external images are only performed when they are not in the image cache (since requesting systematically HTTP may lead of latency. Each figure is cached, so the request is at most done one per external references. When the system is online but the request failed we return a placeholder that is not cached.
			
			When offline, requests to external images are not performed. The cache can be reset executing PRRichTextComposer resetCache. When the system is off line and an image is requested, a placeholder is computed but not put in the cache. This way when the system is put online the requested elements will be requested and put in the cache (without needing to flush placeholders from the cache).'. 
			(aBuilder setting: #notRendering)
				label: 'To disable richtext rendering';
				default: false;
				target: self;
				description: 'Comments are by default rendered via Pillar in Richtext. When this setting is on, they are rendered as plain text (showing their Microdown definitions).'. 
			(aBuilder setting: #captureErrors)
				label: 'To disable rendering error capture';
				default: true;
				target: self;
				description: 'By default if there is an error during the rendering of the comments, various errors are trapped. If you want to get such errors to debug the system, you should turn off this settings.'. 
			
			]
]

{ #category : #'class initialization' }
MicRichTextComposer class >> putOffline [

	self offline: true
]

{ #category : #'class initialization' }
MicRichTextComposer class >> putOnline [

	self offline: false
]

{ #category : #'images internal' }
MicRichTextComposer class >> rawImageFrom: aURL [
	| block |
	self flag: #fixMeOnceNewExceptionIsAvailable.
	block := [ ZnEasy getImageOfType: (ZnMimeType main: 'image' sub: '*') fromUrl: aURL ].
	self captureErrors
		ifFalse: [ ^ block value ].

	^ [[ block
		on: ZnHttpUnsuccessful 
		do: [ :ex | self unsuccessfulRequestFromUrl: aURL ]]
			on: ZnUnexpectedContentType 
			do: [ :ex | self imageUnexpectedContentFromUrl: aURL ]] on: Error do: [ ] 
		
]

{ #category : #examples }
MicRichTextComposer class >> render: aString [ 
	"Render a string, in case of error, just return it."
	
	self notRendering 	
		ifTrue: [ ^ aString ].
	self captureErrors 
		ifFalse: [ ^ self microdownAsRichText: aString ].
	^ [ self microdownAsRichText: aString ] 
			on: STONReaderError, MicParsingError, MessageNotUnderstood, SubclassResponsibility 
			do: [ aString  ]
]

{ #category : #examples }
MicRichTextComposer class >> renderComment: aString of: aClassOrPackage [ 
	"Return aString as part of the templated class comment, when rendering is on.
	Else aString."
	
	| builder |
	builder := MicroDownParser builder.
	aClassOrPackage buildMicroDownUsing: builder withComment: aString.
	^ self render: builder contents
]

{ #category : #'class initialization' }
MicRichTextComposer class >> resetCache [

	ImageCache := Dictionary new
]

{ #category : #styler }
MicRichTextComposer class >> style: aString asLanguage: aLanguage [
	"render aString according to the styler named aLanguage"
	
	| styler |
	styler := self languageStylerFor: aLanguage asLowercase.
	^ styler
		valueWithReceiver: styler methodClass soleInstance 
		arguments: (Array with: aString)
]

{ #category : #styler }
MicRichTextComposer class >> textStyler: aString [
	<codeblockStylerFor: 'text'>
	
	^aString asText
]

{ #category : #'images internal' }
MicRichTextComposer class >> unsuccessfulRequestFromUrl: aUrl [
	
	^ ImageCache 
			at: aUrl asString
			ifPresent: [ :i | i ]
			ifAbsent: [ (StringMorph contents: 'The HTTP request ',  aUrl asString,  ' got unsuccessful.') imageForm  ]
			
]

{ #category : #accessing }
MicRichTextComposer >> annotatedParagrapAlignment [
	^ annotatedParagraphAlignment 
]

{ #category : #accessing }
MicRichTextComposer >> annotatedParagraphAnnotationColor [
	^ annotatedParagraphAnnotationColor 
]

{ #category : #accessing }
MicRichTextComposer >> annotatedParagraphAnnotationColor: aColor [
	annotatedParagraphAnnotationColor := aColor
]

{ #category : #accessing }
MicRichTextComposer >> annotatedParagraphColor [
	^ annotatedParagraphColor 
]

{ #category : #accessing }
MicRichTextComposer >> annotatedParagraphColor: aColor [
	annotatedParagraphColor := aColor
]

{ #category : #initialization }
MicRichTextComposer >> defaultAnnotatedParagraphColor [
	^ TextColor blue
]

{ #category : #initialization }
MicRichTextComposer >> defaultSuperscriptColor [
	^ TextColor blue
]

{ #category : #initialization }
MicRichTextComposer >> initialize [
	super initialize.
	monospaceBackgroundColor := self theme settings windowColor.
	superscriptColor := self defaultSuperscriptColor.
	subscriptColor := TextColor red.
	annotatedParagraphColor := self defaultAnnotatedParagraphColor.
	annotatedParagraphAnnotationColor := TextEmphasis bold.
	annotatedParagraphAlignment := TextAlignment leftFlush
]

{ #category : #accessing }
MicRichTextComposer >> monospaceBackgroundColor [

	^ monospaceBackgroundColor
]

{ #category : #accessing }
MicRichTextComposer >> monospaceBackgroundColor: aColor [

	monospaceBackgroundColor := aColor
]

{ #category : #images }
MicRichTextComposer >> renderMathExpression: aString [
	
	canvas << (self class latexMathStylerFor: aString)
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

	| anchoredImage |
	anchoredImage := anImage.
	aFigure arguments at: #width ifPresent: [ :s | 
		anchoredImage := anImage scaledToSize: s asNumber @ s asNumber ].
	^ anchoredImage
]

{ #category : #accessing }
MicRichTextComposer >> subscriptColor [
	^ subscriptColor 
]

{ #category : #accessing }
MicRichTextComposer >> subscriptColor: anObject [
	subscriptColor := anObject
]

{ #category : #accessing }
MicRichTextComposer >> superscriptColor [
	^ superscriptColor 
]

{ #category : #accessing }
MicRichTextComposer >> superscriptColor: anObject [
	superscriptColor := anObject
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
	
	canvas := MicRichTextCanvas new.
	super visit: aDocument.
	^ canvas contents
]

{ #category : #'visiting - document' }
MicRichTextComposer >> visitAnnotatedParagraph: anAnnotatedParagraph [
	self error: 'this was a halt.'.
	canvas newLineIfNotAlready.
	canvas
		includeAttribute: self annotatedParagrapAlignment
		in: [ 
			canvas
				includeAttribute: self annotatedParagraphAnnotationColor
				in: [ canvas << anAnnotatedParagraph annotation capitalized asText ].
			canvas
				includeAttribute: self annotatedParagrapAlignment
				in: [ canvas
						includeAttribute: self annotatedParagraphColor
						in: [ self visitParagraph: anAnnotatedParagraph ] ] ].
	canvas newLine.
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
			<< (self class 
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
	"Try to read a png file (only one supported right now), else use alt text"
	
	aFigure isImageFile ifTrue: [
	| anchoredImage url |
	url := aFigure url.
	"this url should be renamed resources"
	"this logic has to be revisited with the new resolver."
	
	anchoredImage := url isWeb
		                 ifFalse: [ 
									"should probably fix this."
									(aFigure originPath fileSystem / aFigure url path) isFile
										ifTrue: [ 
											aFigure originPath fileSystem / (aFigure url) path
				                 		binaryReadStreamDo: [ :stream | 
				                 		ImageReadWriter formFromStream: stream ] 
											]
							        ]
		                 ifTrue: [ self class cachedImageFromUrl: url url ].
	anchoredImage ifNotNil: [ 
		anchoredImage := self resizeImage: anchoredImage of: aFigure.
		anchoredImage := (String value: 1) asText addAttribute: (TextAnchor new anchoredMorph: anchoredImage).
		canvas << anchoredImage ].
	aFigure caption ifEmpty: [ ^self ].
	
	canvas newLine.
	canvas includeAttribute: TextEmphasis bold in: [  ]].
	"	on: Exception
		do: [ self visitChildrenOf: aFigure ]. pay attention url return the rest https://files.pharo.org/media/logo/logo.png%7Csize=80&caption=Our%20great%20figure so we will have to add a method to only return the url part."
	canvas
		tab;
		tab;
		tab;
		<< aFigure caption asText
]

{ #category : #'visiting - document' }
MicRichTextComposer >> visitHeader: aHeader [

	canvas newLineIfNotAlready.
	canvas
		includeAttribute: (self class headerLevelFont: aHeader level)
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
	attribute := nil.
	aLink url isWeb ifTrue: [
		attribute := TextAction new
			actOnClickBlock: [ WebBrowser openOn: aLink url printString ];
			yourself ].
	attribute
		ifNotNil: [ canvas
			includeAttribute: attribute
			in: [ super visitLink: aLink ] ]
		ifNil: [ super visitLink: aLink ]
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

	| text |
	text := aMicMathEnvironment body. 
	(OffLine | text isNil)
		ifTrue: [ text 
						ifNotNil: [ canvas << '&'; cr; << text; << '&']
						ifNil: [ canvas << '&'; cr; << 'Your math environment is strange its body is nil'; << '&' ] ]
		ifFalse: [ canvas cr.
					canvas indentIn: [ self renderMathExpression: text ].
					 canvas cr ]
]

{ #category : #'visiting - document' }
MicRichTextComposer >> visitMathInline: aMicMathInline [ 
	
	OffLine 
		ifTrue: [ canvas << '$', aMicMathInline text, '$' ]
		ifFalse: [ canvas << (self class latexMathStylerFor: aMicMathInline text)]
]

{ #category : #'visiting -  format' }
MicRichTextComposer >> visitMonospace: anObject [
	"Notice - I add a highlight to the backgorund rather than mono-spaced."
	| backgroundColor sem |
	backgroundColor := self monospaceBackgroundColor.
	
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
					put: (self class counterFor: counter atLevel: canvas nesting - 1).
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
	anchoredTable := (String value: 1) asText addAttribute: (TextAnchor new anchoredMorph: table asForm).
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
						put: (self class bulletForLevel: canvas nesting - 1) ].
			super visitUnorderedList: anObject ].
	canvas newLine
]
