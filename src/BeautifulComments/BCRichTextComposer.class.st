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
	#name : #BCRichTextComposer,
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
	#category : #BeautifulComments
}

{ #category : #private }
BCRichTextComposer class >> bulletForLevel: level [
	| kind |
	kind := level % 2.
	kind = 0
		ifTrue: [ ^ $• asText ].
	kind = 1
		ifTrue: [ ^ $- asText ]
]

{ #category : #'class initialization' }
BCRichTextComposer class >> captureErrors [
	
	^ CaptureErrors
]

{ #category : #'class initialization' }
BCRichTextComposer class >> captureErrors: aBoolean [
	
	CaptureErrors := aBoolean
]

{ #category : #'styler - declaration' }
BCRichTextComposer class >> codeStylerFor: aString [
	<codeblockStylerFor: 'Smalltalk'>
	
	^SHRBTextStyler new 
		isForWorkspace: true; 
		styledTextFor: aString asText
]

{ #category : #private }
BCRichTextComposer class >> computeHeaderFonts [
	
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
BCRichTextComposer class >> counterFor: counter atLevel: level [
	| kind |
	kind := level % 3.
	kind = 0
		ifTrue: [ ^ counter asString asText , '.' ].
	kind = 1
		ifTrue: [ ^ ($a asInteger + (counter - 1)) asCharacter asText , ')' ].
	kind = 2
		ifTrue: [ ^ ($A asInteger + (counter - 1)) asCharacter asText , ')' ]
]

{ #category : #'styler - declaration' }
BCRichTextComposer class >> defaultStyler: aString [
	<codeblockStylerFor: 'default'>
	"Pay attention without this one the logic can loop."
	
	^ self codeStylerFor: aString
]

{ #category : #'styler - declaration' }
BCRichTextComposer class >> expressionStylerFor: aString [
	<codeblockStylerFor: 'PharoExpression'>
	
	^SHRBTextStyler new 
		isForWorkspace: true; 
		styledTextFor: aString asText
]

{ #category : #private }
BCRichTextComposer class >> headerFontSizes: anArray [

	HeaderFontSizes := anArray.
	self computeHeaderFonts 
]

{ #category : #private }
BCRichTextComposer class >> headerFonts: anArray [

	HeaderFontSizes := anArray
]

{ #category : #private }
BCRichTextComposer class >> headerLevelFont: level [
	"I return a font annotation to be used with Attributes"

	^ HeaderFonts at: level
]

{ #category : #'class initialization' }
BCRichTextComposer class >> imageAt: urlString put: aForm [	
	"the cache contains results of for example ZnEasy getPng:, i.e., a form"
	
	ImageCache at: urlString put: aForm
]

{ #category : #accessing }
BCRichTextComposer class >> imageCache [
	^ imageCache ifNil: [ imageCache := LRUCache new ]
]

{ #category : #'class initialization' }
BCRichTextComposer class >> initialize [ 
	"self initialize"
	self offline: false.
	self notRendering: false.
	self resetCache.
	self headerFontSizes: #(18 14 12 11 10 10).
	self initializeStylers.
	self captureErrors: true.
]

{ #category : #'class initialization' }
BCRichTextComposer class >> initializeStylers [
	"self initializeStylers"
	Stylers := Dictionary
		newFromAssociations: ((PragmaCollector
						filter: [ :prg | prg selector = 'codeblockStylerFor:' ]) reset
						collected collect: [ :p | p arguments first asLowercase-> p method ])
]

{ #category : #stylers }
BCRichTextComposer class >> languageStylerFor: aLanguage [

	^ Stylers
		at: aLanguage asLowercase
		ifAbsent: [ self languageStylerFor: 'default' ]
]

{ #category : #examples }
BCRichTextComposer class >> latexExample [
	<example>
	self flag: #todo. "to fix we should use a MicInlineMath... here"
	(BCRichTextComposer new visit: 
		(PRMathInTextAnnotation new 
		add: (PRText new text:
'V_i = C_0 - C_3
\frac{C_1\cos(\theta_i+C_3)}{C_4+C_1\cos(\theta_i+C_2)}')))

 inspect
]

{ #category : #styling }
BCRichTextComposer class >> latexMathStylerFor: aString [
	"<codeblockStylerFor:'latexMath'>
	
	this is totally bogus: this method does not return a styler but just an image."
	
	| expressionUrl |
	expressionUrl := 'https://latex.codecogs.com/png.latex?', aString urlEncoded.
	^self loadExternalImageFromURL: expressionUrl errorText: 'Latex error'.
]

{ #category : #private }
BCRichTextComposer class >> loadExternalImageFromURL: aUrl errorText: errorDesc [
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

{ #category : #'styler - declaration' }
BCRichTextComposer class >> methodStylerFor: aString [
	<codeblockStylerFor:'PharoMethod'>
	
	"when we use a pharo method for an expression the styler breaks for method pattern. So it should be fixed in the future but for now we make sure that at least it does not breaks."
	^[ SHRBTextStyler new 
		isForWorkspace: false; 
		styledTextFor: aString asText ] on: SubscriptOutOfBounds do: [ aString asText ]
]

{ #category : #'class initialization' }
BCRichTextComposer class >> notRendering [
	"When notRendering, the comments are just displayed as plain text."
	
	^ NotRendering
]

{ #category : #'class initialization' }
BCRichTextComposer class >> notRendering: aBoolean [
	NotRendering := aBoolean
]

{ #category : #'class initialization' }
BCRichTextComposer class >> offline [

	^ OffLine
]

{ #category : #'class initialization' }
BCRichTextComposer class >> offline: aBoolean [

	OffLine := aBoolean

]

{ #category : #settings }
BCRichTextComposer class >> preferencesSettingsOn: aBuilder [
	<systemsettings>
	(aBuilder group: #comments)
		label: 'Comment rendering';  
		parent: #appearance;
		description: 'All settings concerned with the notifications popup look''n feel';
		with: [
		(aBuilder setting: #offline)
			label: 'To set offline mode';
			target: self;
			default: false;
			description: '
			When oneline is chosen, requests to external images are only performed when they are not in the image cache (since requesting systematically HTTP may lead of latency. Each figure is cached, so the request is at most done one per external references. When the system is online but the request failed we return a placeholder that is not cached.
			
			When offline, requests to external images are not performed. The cache can be reset executing PRRichTextComposer resetCache. When the system is off line and an image is requested, a placeholder is computed but not put in the cache. This way when the system is put online the requested elements will be requested and put in the cache (without needing to flush placeholders from the cache).'. 
			(aBuilder setting: #notRendering)
				label: 'To set off the rendering in richtext';
				default: false;
				target: self;
				description: 'Comments are by default rendered via Pillar in Richtext. When this setting is on, they are rendered as plain text (showing their Microdown definitions).'. 
			
			
			]
]

{ #category : #'class initialization' }
BCRichTextComposer class >> putOffline [

	self offline: true
]

{ #category : #'class initialization' }
BCRichTextComposer class >> putOnline [

	self offline: false
]

{ #category : #'class initialization' }
BCRichTextComposer class >> resetCache [

	ImageCache := Dictionary new
]

{ #category : #stylers }
BCRichTextComposer class >> style: aString asLanguage: aLanguage [
	"render aString according to the styler named aLanguage"
	
	| styler |
	styler := self languageStylerFor: aLanguage asLowercase.
	^ styler
		valueWithReceiver: styler methodClass soleInstance 
		arguments: (Array with: aString)
]

{ #category : #'styler - declaration' }
BCRichTextComposer class >> textStyler: aString [
	<codeblockStylerFor: 'text'>
	
	^aString asText
]

{ #category : #accessing }
BCRichTextComposer >> annotatedParagrapAlignment [
	^ annotatedParagraphAlignment 
]

{ #category : #accessing }
BCRichTextComposer >> annotatedParagraphAnnotationColor [
	^ annotatedParagraphAnnotationColor 
]

{ #category : #accessing }
BCRichTextComposer >> annotatedParagraphAnnotationColor: aColor [
	annotatedParagraphAnnotationColor := aColor
]

{ #category : #accessing }
BCRichTextComposer >> annotatedParagraphColor [
	^ annotatedParagraphColor 
]

{ #category : #accessing }
BCRichTextComposer >> annotatedParagraphColor: aColor [
	annotatedParagraphColor := aColor
]

{ #category : #images }
BCRichTextComposer >> cachedImageFromUrl: aUrl [
	
	^ OffLine 
		ifFalse: [
			ImageCache 
				at: aUrl asString
				ifAbsentPut: [ self rawImageFrom: aUrl ] ] 
		ifTrue: [ self imageOffLineFromUrl: aUrl ]
]

{ #category : #initialization }
BCRichTextComposer >> defaultAnnotatedParagraphColor [
	^ TextColor blue
]

{ #category : #initialization }
BCRichTextComposer >> defaultSuperscriptColor [
	^ TextColor blue
]

{ #category : #'images internal' }
BCRichTextComposer >> imageOffLineFromUrl: aUrl [
	"we are off but the image is there so we return it,"
	^ ImageCache 
			at: aUrl asString
			ifPresent: [ :i | i ]
			ifAbsent: [ (StringMorph contents: 'The HTTP request got unsuccessful. 
When you will be online, you should see: ' , aUrl asString) imageForm  ]
			
]

{ #category : #'images internal' }
BCRichTextComposer >> imageUnexpectedContentFromUrl: aUrl [
	"The request got unexpected content if the image is there so we return it. We do not cache the failing case image form so that we do not polute the cache."
	
	^ ImageCache 
			at: aUrl asString
			ifPresent: [ :i | i ]
			ifAbsent: [ (StringMorph contents: 'The HTTP request ', aUrl asString, ' returned an unexpected content.' ) imageForm  ]
			
]

{ #category : #initialization }
BCRichTextComposer >> initialize [
	super initialize.
	monospaceBackgroundColor := self theme settings windowColor.
	superscriptColor := self defaultSuperscriptColor.
	subscriptColor := TextColor red.
	annotatedParagraphColor := self defaultAnnotatedParagraphColor.
	annotatedParagraphAnnotationColor := TextEmphasis bold.
	annotatedParagraphAlignment := TextAlignment leftFlush
]

{ #category : #accessing }
BCRichTextComposer >> monospaceBackgroundColor [

	^ monospaceBackgroundColor
]

{ #category : #accessing }
BCRichTextComposer >> monospaceBackgroundColor: aColor [

	monospaceBackgroundColor := aColor
]

{ #category : #'images internal' }
BCRichTextComposer >> rawImageFrom: aURL [
	| block |
	self flag: #fixMeOnceNewExceptionIsAvailable.
	block := [ ZnEasy getImageOfType: (ZnMimeType main: 'image' sub: '*') fromUrl: aURL ].
	self class captureErrors
		ifFalse: [ ^ block value ].

	^ [ block
		on: ZnHttpUnsuccessful 
		do: [ :ex | self unsuccessfulRequestFromUrl: aURL ]]
			on: ZnUnexpectedContentType 
			do: [ :ex | self imageUnexpectedContentFromUrl: aURL ]
		
]

{ #category : #images }
BCRichTextComposer >> renderMathExpression: aString [
	
	canvas << (self class latexMathStylerFor: aString)
]

{ #category : #accessing }
BCRichTextComposer >> subscriptColor [
	^ subscriptColor 
]

{ #category : #accessing }
BCRichTextComposer >> subscriptColor: anObject [
	subscriptColor := anObject
]

{ #category : #accessing }
BCRichTextComposer >> superscriptColor [
	^ superscriptColor 
]

{ #category : #accessing }
BCRichTextComposer >> superscriptColor: anObject [
	superscriptColor := anObject
]

{ #category : #initialization }
BCRichTextComposer >> theme [

	^  Smalltalk ui theme
]

{ #category : #accessing }
BCRichTextComposer >> todo [ 
	^ 'there is too much hspace after a section when it is followed by a paragraph. 
This also because people will not want to to not let a newline between the header and paragraph when writing the text.'
]

{ #category : #'images internal' }
BCRichTextComposer >> unsuccessfulRequestFromUrl: aUrl [
	
	^ ImageCache 
			at: aUrl asString
			ifPresent: [ :i | i ]
			ifAbsent: [ (StringMorph contents: 'The HTTP request ',  aUrl asString,  ' got unsuccessful.') imageForm  ]
			
]

{ #category : #visiting }
BCRichTextComposer >> visit: aDocument [
	
	canvas := BCRichTextCanvas new.
	super visit: aDocument.
	^ canvas contents
]

{ #category : #'visiting - document' }
BCRichTextComposer >> visitAnnotatedParagraph: anAnnotatedParagraph [
	self halt.
	canvas newLineIfNotAlready.
	canvas newLine.
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
BCRichTextComposer >> visitBold: anObject [
	canvas 
		includeAttribute: TextEmphasis bold 
		in: [ super visitBold: anObject ]
	
]

{ #category : #'visiting - document' }
BCRichTextComposer >> visitCode: aCodeBlock [
	
	canvas newLineIfNotAlready.
	canvas newLine.
	canvas
		indentIn: [  
			canvas
				indentIn: [ 
					
					canvas << (self class  
						style: aCodeBlock body 
						asLanguage: aCodeBlock firstTag)
			] ].
	canvas newLine.

]

{ #category : #'visiting - document' }
BCRichTextComposer >> visitEnvironment: anObject [
	self halt.
	self flag: #fixme.
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

{ #category : #'visiting - document' }
BCRichTextComposer >> visitFigure: aFigure [
	"Try to read a png file (only one supported right now), else use alt text"
	| anchoredImage |

	
	
	"for now I cancel the catching of all exceptions because it is a blackhole."
	"[" 
	anchoredImage := (String value: 1) asText
		addAttribute: (TextAnchor new anchoredMorph: (self cachedImageFromUrl: aFigure url)).
		canvas << anchoredImage 
		"] 
		on: Exception  
		do: [self visitAll: aFigure children]."
	"pay attention url return the rest https://files.pharo.org/media/logo/logo.png%7Csize=80&caption=Our%20great%20figure so we will have to add a method to only return the url part."
]

{ #category : #'visiting - document' }
BCRichTextComposer >> visitHeader: aHeader [

	canvas newLineIfNotAlready.
	canvas newLine.
	canvas
		includeAttribute: (self class headerLevelFont: aHeader level)
		in: [ super visitHeader: aHeader ].
	canvas newLine
]

{ #category : #'visiting - document' }
BCRichTextComposer >> visitHorizontalLine: anHorizontalLine [
	
	canvas includeAttribute: TextEmphasis underlined in: [ canvas << ('     ' repeat: 20) asText ].
	canvas newLine.	
]

{ #category : #'visiting -  format' }
BCRichTextComposer >> visitItalic: anObject [
	canvas 
		includeAttribute: TextEmphasis italic 
		in: [ super visitItalic: anObject ]
]

{ #category : #'visiting - document' }
BCRichTextComposer >> visitLink: aLink [
	| attribute |
	attribute := nil.
	(#(http https) includes: aLink url scheme )
		ifTrue: [ attribute := TextAction new actOnClickBlock: [ WebBrowser openOn: aLink url printString ]].
	attribute
		ifNotNil:
			[ canvas includeAttribute: attribute in: [ super visitLink: aLink ] ]
		ifNil: [ super visitLink: aLink ]
]

{ #category : #'visiting - list' }
BCRichTextComposer >> visitListItem: anItem [
	| bullet |
	"The depth counter and bullet type in `visitOrderedList` and `visitUnorderedList`"
	bullet := (anItem propertyAt: #kind) = #ordered
		ifTrue: [ (anItem propertyAt: #counter) asString asText , String tab ]
		ifFalse: [ (anItem propertyAt: #bullet) asText , String tab ].
	bullet addAttribute: (TextIndent tabs: canvas nesting - 1).
	canvas newLineIfNotAlready.
	canvas << bullet.
	super visitListItem: anItem.
	"canvas newLineIfNotAlready."
]

{ #category : #'visiting - document' }
BCRichTextComposer >> visitMathEnvironment:  aMicMathEnvironment [

	| text |
	self halt.
	text := aMicMathEnvironment text. 
	(OffLine | text isNil)
		ifTrue: [ text 
						ifNotNil: [ canvas << '&'; cr; << text; << '&']
						ifNil: [ canvas << '&'; cr; << 'Your math environment is strange its body is nil'; << '&' ] ]
		ifFalse: [ canvas cr.
					canvas indentIn: [ self renderMathExpression: text ].
					 canvas cr ]
]

{ #category : #'visiting - document' }
BCRichTextComposer >> visitMathInline: aMicMathInline [ 
	
	OffLine 
		ifTrue: [ canvas << '$', aMicMathInline text, '$' ]
		ifFalse: [ canvas << (self class latexMathStylerFor: aMicMathInline text)]
]

{ #category : #'visiting -  format' }
BCRichTextComposer >> visitMonospace: anObject [
	"Notice - I add a highlight to the backgorund rather than mono-spaced."
	| backgroundColor sem |
	backgroundColor := self monospaceBackgroundColor.
	
	self flag: #fixMe.
	"Right now we stupidly emit TextAction but we should emit TextClassLink and revisit them."
	canvas 
		includeAttribute: (TextBackgroundColor color: backgroundColor) 
		in: [ 
			sem := BCSemanticAction from: anObject text.
			sem hasEntity 
				ifTrue: [ canvas 
								includeAttribute: (TextAction new actOnClickBlock: [ sem entity browse ]) 
								in: [ super visitMonospace: anObject ] ]
				ifFalse: [ super visitMonospace: anObject]].  
]

{ #category : #'visiting - list' }
BCRichTextComposer >> visitOrderedList: anObject [
	"here we annotate items with their kind and the depth"
	| counter |
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
BCRichTextComposer >> visitParagraph: anObject [
	
	"canvas newLineIfNotAlready."
	canvas newLine.
	super visitParagraph: anObject.
	canvas newLine.
]

{ #category : #'visiting - document' }
BCRichTextComposer >> visitParameters: anObject [
	"do nothing for now"
	
	^ self
]

{ #category : #'visiting -  format' }
BCRichTextComposer >> visitStrike: anObject [

	canvas 
		includeAttribute: TextEmphasis struckOut 
		in: [ super visitStrike: anObject ]
]

{ #category : #'visiting -  format' }
BCRichTextComposer >> visitText: anInlineBlock [
	"we should set attribute because it would override link and others."
	canvas << anInlineBlock substring asText
]

{ #category : #'visiting - list' }
BCRichTextComposer >> visitUnorderedList: anObject [

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
