"
A first version of an HTML writer. 
We should rewrite it once the templatedWriter is working.
"
Class {
	#name : #MicHTMLVisitor,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'canvas',
		'configuration'
	],
	#category : #'Microdown-HTMLExporter-Visitor'
}

{ #category : #converting }
MicHTMLVisitor class >> asHTMLDocument: aMicrodownString [
	"Answer a <String> formatted as HTML with UTF-8 encoding from aMicrodownString as input"

	^ self new convertMicStringToDoc: aMicrodownString
]

{ #category : #converting }
MicHTMLVisitor class >> asHTMLString: aMicrodownString [
	"Answer a <String> formatted as HTML from aMicrodownString as input"

	^ self new convertMicString: aMicrodownString
]

{ #category : #converting }
MicHTMLVisitor class >> asHTMLString: aMicrodownString configuration: aMicHTMLConfiguration [
	"Answer a <String> formatted as HTML from aMicrodownString as input"

	^ self new 
		configuration: aMicHTMLConfiguration;
		convertMicString: aMicrodownString
]

{ #category : #examples }
MicHTMLVisitor class >> exampleHTMLDocument [
	<example>
	
	^ (Microdown asHTMLDocument: MicMicrodownSnippetFactory buildDocument) inspect.
]

{ #category : #examples }
MicHTMLVisitor class >> exampleHTMLDocumentWithFigure [
	<example>
	
	^ (Microdown asHTMLDocument: '![AltText](my_directory/image.png label=42&width=90)') inspect.
]

{ #category : #examples }
MicHTMLVisitor class >> exampleHTMLDocumentWithLink [
	<example>
	
	^ (Microdown asHTMLDocument: '[Pharo Website](http://pharo.org target=blank&rel=bookmark)') inspect.
]

{ #category : #examples }
MicHTMLVisitor class >> exampleHTMLString [
	<example>
	
	^ (Microdown asHTMLString: MicMicrodownSnippetFactory buildDocument) inspect.
]

{ #category : #examples }
MicHTMLVisitor class >> exampleHTMLStringWithLink [
	<example>
	
	^ (Microdown asHTMLString: '[Pharo Website](http://pharo.org target=_blank&rel=bookmark)') inspect.
]

{ #category : #converting }
MicHTMLVisitor class >> serializeToHTMLDoc: aMicrodownString [
	"Serialize aMicrodownString <String> to a HTML file with default for output name, directory and CSS"

	self
		serializeToHTMLDoc: aMicrodownString
		withStyle: MicCSSProvider defaultFramework
]

{ #category : #converting }
MicHTMLVisitor class >> serializeToHTMLDoc: aMicrodownString withStyle: aStyleName [
	"Serialize aMicrodownString <String> to a HTML file with CSS style named aStyleName and default for output directory and file name"

	MicHTMLDocument new
		addCSSNamed: aStyleName;
		fromMicrodown: aMicrodownString;
		writeToFile

]

{ #category : #initialization }
MicHTMLVisitor >> canvasClass [

	^ MicHTMLCanvas
]

{ #category : #accessing }
MicHTMLVisitor >> configuration [

	^ configuration
		ifNil: [ configuration := MicHTMLConfiguration new ]
]

{ #category : #accessing }
MicHTMLVisitor >> configuration: anObject [

	configuration := anObject
]

{ #category : #accessing }
MicHTMLVisitor >> contents [ 
	"Answer a <String> of HTML formatted receiver's canvas"

	^ canvas contents
]

{ #category : #converting }
MicHTMLVisitor >> convertMicFile: aFilename [

	| fileRef |

	fileRef := aFilename asFileReference.
	self visit: (Microdown parse: fileRef contents).
	(fileRef parent / (fileRef basenameWithoutExtension: 'md') , 'html') asFileReference 
		writeStreamDo: [ : writeStream | writeStream nextPutAll: self contents ]
]

{ #category : #converting }
MicHTMLVisitor >> convertMicString: aMicString [
	"Answer a <String> representing the HTML equivalent of Microdown formatted aMicString "

	self visit: (Microdown parse: aMicString).
	^ self contents
]

{ #category : #converting }
MicHTMLVisitor >> convertMicStringToDoc: aMicString [
	"Answer a <String> representing the HTML equivalent of Microdown formatted aMicString "

	self visit: (Microdown parse: aMicString).
	^ MicHTMLDocument new
		configuration: self configuration;
		writeDocument: self contents;
		contents
]

{ #category : #initialization }
MicHTMLVisitor >> crAsNewLine [ 
	canvas crAsNewLine
]

{ #category : #initialization }
MicHTMLVisitor >> crlfAsNewLine [ 
	canvas crlfAsNewLine
]

{ #category : #initialization }
MicHTMLVisitor >> initialize [ 
	| stream |
	super initialize.
	stream := MicOutputStream new setStream: (WriteStream on: String empty).
	canvas := self canvasClass on: stream.
	
]

{ #category : #initialization }
MicHTMLVisitor >> lfAsNewLine [ 
	canvas lfAsNewLine
]

{ #category : #'visiting - list' }
MicHTMLVisitor >> metaDataFromAssociations: aDictionary [
	"Write the receiver's metadata from aDictionary"

	aDictionary associationsDo: [ : metadataAssociation |
		self configuration writeFromMetadataAssociation: metadataAssociation ].

]

{ #category : #defaults }
MicHTMLVisitor >> minQuoteThreshold [
	"Answer a <Number> which is the number of characters used as the limit between short and long quotations"
	
	^ 50
]

{ #category : #initialization }
MicHTMLVisitor >> usedNewLine [
	"Return the encoded new line. Useful for tests."
	
	^ canvas stream usedNewLine
]

{ #category : #visiting }
MicHTMLVisitor >> visitAnchor: anAnchor [
	"Target could be any tag, h1, h2, a, etc., it is only a placeholder for a hyperlink"

	canvas tag
		name: 'a';
		parameterAt: 'id' put: anAnchor label;
		with: String empty

]

{ #category : #visiting }
MicHTMLVisitor >> visitAnchorReference: anAnchor [
	"Linking to an element on the same page"

	canvas tag
		name: 'a';
		parameterAt: 'href' put: '#' , anAnchor substring;
		with: anAnchor substring

]

{ #category : #visiting }
MicHTMLVisitor >> visitAnnotated: anAnnotatedParagraph [

	canvas newLine.
	canvas tag
		name: 'section';
		parameterAt: 'id' put: anAnnotatedParagraph label;
		with: [ 
			canvas tag
				name: 'label';
				parameterAt: 'for' put: anAnnotatedParagraph label;
				with: [ super visitAnnotated: anAnnotatedParagraph ] ].
]

{ #category : #'visiting - inline elements' }
MicHTMLVisitor >> visitBold: aBoldText [

	canvas tag
		name: 'strong';
		with: [ super visitBold: aBoldText ]
]

{ #category : #'visiting - extensions' }
MicHTMLVisitor >> visitCitation: aCitation [

	canvas tag
		name: 'cite';
		with: aCitation ref.

]

{ #category : #visiting }
MicHTMLVisitor >> visitCode: aCodeBlock [

	canvas newLine.
	canvas tag
		name: 'pre';
		with: [ 
			| code |
			code := canvas tag
				        name: 'code';
				        yourself.
			"language := self languageForScript: aCodeBlock.
			language isSyntaxHighlightingPossible ifTrue: [ 
			code parameterAt: 'class' put: language printString ]."
			code with: [ canvas lines: aCodeBlock body ] ].
			"canvas tag
				name: 'figcaption';
				with: [ 
					aCodeBlock hasLabel ifTrue: [ 
							self createAnchorWith: aCodeBlock label.
							self writeCounterForScript: aCodeBlock ].
					aCodeBlock hasCaption ifTrue: [ 
							self visitAll: aCodeBlock caption children ] ]" .
	canvas newLine
]

{ #category : #visiting }
MicHTMLVisitor >> visitCodeblock: aCodeBlock [

	canvas tag
		name: 'figure';
		with: [ 
			canvas tag
				name: 'pre';
				with: [ 
					| code language |
					code := canvas tag
						        name: 'code';
						        yourself.
					"(language := self languageForScript: aCodeBlock) isSyntaxHighlightingPossible 
						ifTrue: [ code parameterAt: 'class' put: language printString ]."
					code with: [ canvas lines: aCodeBlock text ] ].
			canvas tag
				name: 'figcaption';
				with: [ 
					aCodeBlock hasLabel ifTrue: [ 
							self visitAnchor: aCodeBlock.
							self writeCounterForScript: aCodeBlock ].
					aCodeBlock hasCaption ifTrue: [ 
							self visitAll: aCodeBlock caption children ] ] ].
	canvas newLine
]

{ #category : #visiting }
MicHTMLVisitor >> visitColumn: aMicColumnsBlock [ 
	"??"
]

{ #category : #visiting }
MicHTMLVisitor >> visitColumns: aMicColumnsBlock [ 
	"??"
]

{ #category : #visiting }
MicHTMLVisitor >> visitFigCaption: aFigCaptionBlock [

	canvas tag
		name: 'figcaption';
		with: [ self visitAll: aFigCaptionBlock children ]
]

{ #category : #'visiting - inline elements' }
MicHTMLVisitor >> visitFigure: aFigure [
	"Write mark up elements related with photo in the receiver's canvas"

	canvas tag
		name: 'figure';
		with: [ self visitImg: aFigure ]

]

{ #category : #visiting }
MicHTMLVisitor >> visitHeader: aHeader [

	canvas newLine.	
	canvas tag 
		name: 'h',  aHeader level asString;
		with: [ self visitAll: aHeader children]
	
]

{ #category : #visiting }
MicHTMLVisitor >> visitHorizontalLine: aHorizontalLine [

	canvas tag
		name: 'hr';
		with: ''
]

{ #category : #visiting }
MicHTMLVisitor >> visitImg: aMicFigureBlock [
	"Write mark up elements related with image tag in the receiver's canvas.
	Mandatory attributes:
		src - Specifies the path to the image
		alt - Specifies an alternate text for the image, if the image for some reason cannot be displayed"
	
	canvas tag
		name: 'img';
		parameterAt: 'src' put: aMicFigureBlock reference path;
		parameterAt: 'alt' put: aMicFigureBlock altText;
		addArguments: aMicFigureBlock;
		with: [ self visitFigCaption: aMicFigureBlock ]
]

{ #category : #'visiting - inline elements' }
MicHTMLVisitor >> visitItalic: aItalicText [

	canvas tag
		name: 'i';
		with: [ super visitItalic: aItalicText ]
]

{ #category : #'visiting - inline elements' }
MicHTMLVisitor >> visitLink: aLink [
	"Write markup hyperlink, which is used to link from one page to another"

	canvas tag
		name: 'a';
		parameterAt: 'target' put: self configuration targetAttribute;
		parameterAt: 'href' put: aLink referencePath;
		addArguments: aLink;
		with: [self visitAll: aLink children]

]

{ #category : #'visiting - list' }
MicHTMLVisitor >> visitListItem: anItem [

	canvas raw: [ super visitListItem: anItem ].

]

{ #category : #visiting }
MicHTMLVisitor >> visitMath: anObject [

	"<script src=""https://polyfill.io/v3/polyfill.min.js?features=es6""></script>
<script id=""MathJax-script"" async src=""https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js""></script>"

]

{ #category : #visiting }
MicHTMLVisitor >> visitMetaData: aMetaData [

	self metaDataFromAssociations: aMetaData body.
	super visitMetaData: aMetaData.
]

{ #category : #'visiting - inline elements' }
MicHTMLVisitor >> visitMonospace: aMonospace [

	canvas tag
		name: 'code';
		with: [ super visitMonospace: aMonospace ]
]

{ #category : #'visiting - list' }
MicHTMLVisitor >> visitOrderedList: anOrderedList [

	canvas newLine.
	canvas tag
		name: 'ol';
		with: [ 
			canvas newLine. 
			super visitOrderedList: anOrderedList  ]
]

{ #category : #'visiting - list' }
MicHTMLVisitor >> visitOrderedListItem: anOrderedListItem [
	"will not work with we have text decorators such as bold, italic, monospace"

	canvas tag
		name: 'li';
		with: [ super visitOrderedListItem: anOrderedListItem ].
	canvas newLine.

]

{ #category : #visiting }
MicHTMLVisitor >> visitParagraph: aParagraph [

	canvas newLine.
	canvas tag
		name: 'p';
		with: [ super visitParagraph: aParagraph ]
]

{ #category : #visiting }
MicHTMLVisitor >> visitQuote: aQuote [
	"If the quote text size exceeds a minimum threshold, use blockquote which is appropriate for long quotations"
	
	| tagName |
	tagName := aQuote text size > self minQuoteThreshold
		ifTrue: [ 'blockquote' ]
		ifFalse: [ 'q' ].
	canvas tag
		name: tagName;
		with: [ super visitQuote: aQuote ]
]

{ #category : #'visiting - inline elements' }
MicHTMLVisitor >> visitStrike: aStrike [

	canvas tag
		name: 'strike';
		with: [ super visitStrike: aStrike ]
]

{ #category : #visiting }
MicHTMLVisitor >> visitTable: aTable [

	canvas newLine.
	canvas tag
		name: 'table';
		with: [ 
			canvas newLine.
			self visitTableRows: aTable ]
]

{ #category : #writing }
MicHTMLVisitor >> visitTableHeaders: header [

	self visitTableRow: header withTag: 'th'.
		
]

{ #category : #writing }
MicHTMLVisitor >> visitTableRow: row [

	self visitTableRow: row withTag: 'td'
]

{ #category : #writing }
MicHTMLVisitor >> visitTableRow: row withTag: aString [
	"Private - Generalized visiting row to handle both table header and table row (td)"

	canvas tag
		name: 'tr';
		with: [ 
			row do: [ : cell |
				canvas tag 
					name: aString; 
					with: [ self visitAll: cell ] ] ].
	canvas newLine			
]

{ #category : #writing }
MicHTMLVisitor >> visitTableRows: aTable [

	| remainingRows |

	aTable hasHeader
		ifTrue: [ 
			self visitTableHeaders: aTable rows first. 
			remainingRows := aTable rows allButFirst  ] 
		ifFalse: [ remainingRows := aTable rows ].

	remainingRows do: [ : row | self visitTableRow: row ]
]

{ #category : #'visiting - inline elements' }
MicHTMLVisitor >> visitText: aText [

	canvas nextPutAll: (
		(aText text copyReplaceAll: String cr with: '<br>') 
			copyReplaceAll: String lf with: '<br />'). 

]

{ #category : #'visiting - list' }
MicHTMLVisitor >> visitUnorderedList: anUnorderedList [

	canvas newLine.
	canvas tag
		name: 'ul';
		with: [ 
			canvas newLine. 
			super visitUnorderedList: anUnorderedList  ]
]

{ #category : #'visiting - list' }
MicHTMLVisitor >> visitUnorderedListItem: anUnorderedListItem [
	"will not work with we have text decorators such as bold, italic, monospace"

	canvas tag
		name: 'li';
		with: [ super visitUnorderedListItem: anUnorderedListItem ].
	canvas newLine.

]

{ #category : #visiting }
MicHTMLVisitor >> writeCounter: aCounter [

	"Write on the canvas the string representation of ==aCounter=="

	^ aCounter elements
		  do: [ :each | self writeCounterElement: each ]
		  separatedBy: [ self writeCounterElementSeparator ]
]

{ #category : #visiting }
MicHTMLVisitor >> writeCounterDefinitionSeparator [

	canvas nextPutAll: '. '
]

{ #category : #visiting }
MicHTMLVisitor >> writeCounterElement: aCounterElement [

	canvas nextPutAll: aCounterElement asString
]

{ #category : #visiting }
MicHTMLVisitor >> writeCounterElementSeparator [

	self shouldBeImplemented
]

{ #category : #visiting }
MicHTMLVisitor >> writeCounterForScript: aScript [

	aScript counter isValidCounter ifFalse: [ ^ self ].
	self writeCounter: aScript counter.
	self writeCounterDefinitionSeparator
]
