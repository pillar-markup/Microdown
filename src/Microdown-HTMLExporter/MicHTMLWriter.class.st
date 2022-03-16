"
A first version of an HTML writer. 
We should rewrite it once the templatedWriter is working.
"
Class {
	#name : #MicHTMLWriter,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'canvas'
	],
	#category : #'Microdown-HTMLExporter'
}

{ #category : #converting }
MicHTMLWriter class >> asHTMLDocument: aMicrodownString [
	"Answer a <String> formatted as HTML with UTF-8 encoding from aMicrodownString as input"

	^ self new convertMicStringToDoc: aMicrodownString
]

{ #category : #converting }
MicHTMLWriter class >> asHTMLString: aMicrodownString [
	"Answer a <String> formatted as HTML from aMicrodownString as input"

	^ self new convertMicString: aMicrodownString
]

{ #category : #examples }
MicHTMLWriter class >> exampleHTMLDocument [
	<example>
	
	^ (Microdown asHTMLDocument: MicMicrodownSnippetFactory buildDocument) inspect.
]

{ #category : #examples }
MicHTMLWriter class >> exampleHTMLDocumentWithFigure [
	<example>
	
	^ (Microdown asHTMLDocument: '![AltText](my_directory/image.png label=42&width=90)') inspect.
]

{ #category : #examples }
MicHTMLWriter class >> exampleHTMLDocumentWithLink [
	<example>
	
	^ (Microdown asHTMLDocument: '[Pharo Website](http://pharo.org target=blank&rel=bookmark)') inspect.
]

{ #category : #examples }
MicHTMLWriter class >> exampleHTMLString [
	<example>
	
	^ (Microdown asHTMLString: MicMicrodownSnippetFactory buildDocument) inspect.
]

{ #category : #examples }
MicHTMLWriter class >> exampleHTMLStringWithLink [
	<example>
	
	^ (Microdown asHTMLString: '[Pharo Website](http://pharo.org target=_blank&rel=bookmark)') inspect.
]

{ #category : #initialization }
MicHTMLWriter >> canvasClass [

	^ MicHTMLCanvas
]

{ #category : #accessing }
MicHTMLWriter >> contents [ 
	"Answer a <String> of HTML formatted receiver's canvas"

	^ canvas contents
]

{ #category : #converting }
MicHTMLWriter >> convertMicFile: aFilename [

	| fileRef |

	fileRef := aFilename asFileReference.
	self visit: (Microdown parse: fileRef contents).
	(fileRef parent / (fileRef basenameWithoutExtension: 'md') , 'html') asFileReference 
		writeStreamDo: [ : writeStream | writeStream nextPutAll: self contents ]
]

{ #category : #converting }
MicHTMLWriter >> convertMicString: aMicString [
	"Answer a <String> representing the HTML equivalent of Microdown formatted aMicString "

	self visit: (Microdown parse: aMicString).
	^ self contents
]

{ #category : #converting }
MicHTMLWriter >> convertMicStringToDoc: aMicString [
	"Answer a <String> representing the HTML equivalent of Microdown formatted aMicString "

	self visit: (Microdown parse: aMicString).
	^ MicHTMLDocBuilder new
		contents: self contents;
		document
]

{ #category : #visiting }
MicHTMLWriter >> createAnchorWithId: anId [

	canvas tag
		name: 'a';
		parameterAt: 'id' put: anId;
		with: ''
]

{ #category : #initialization }
MicHTMLWriter >> initialize [ 
	| stream |
	super initialize.
	stream := MicOutputStream new setStream: (WriteStream on: (String new: 1000)).
	canvas := self canvasClass on: stream.
	
]

{ #category : #visiting }
MicHTMLWriter >> isSyntaxHighlightingPossible [

	^ true
]

{ #category : #visiting }
MicHTMLWriter >> languageForScript: aScript [

	^ aScript language isSpecified
		  ifTrue: [ aScript language ]
		  ifFalse: [ self configuration defaultScriptLanguage ]
]

{ #category : #initialization }
MicHTMLWriter >> usedNewLine [
	"Return the encoded new line. Useful for tests."
	
	^ canvas stream usedNewLine
]

{ #category : #visiting }
MicHTMLWriter >> visitAnchor: anAnchor [

	self createAnchorWithId: anAnchor label 
]

{ #category : #visiting }
MicHTMLWriter >> visitAnnotated: anAnnotatedParagraph [

	canvas newLine.
	canvas tag
		name: 'section';
		parameterAt: 'class' put: 'annotation';
		with: [ 
			canvas tag
				name: 'label';
				with: anAnnotatedParagraph label.
			canvas tag
				name: 'div';
				with: [ super visitAnnotated: anAnnotatedParagraph ] ].
]

{ #category : #visiting }
MicHTMLWriter >> visitBold: aBoldText [

	canvas tag
		name: 'strong';
		with: [ super visitBold: aBoldText ]
]

{ #category : #visiting }
MicHTMLWriter >> visitCitation: aCitation [

	canvas tag
		name: 'cite';
		with: aCitation ref.

]

{ #category : #visiting }
MicHTMLWriter >> visitCode: aCodeBlock [

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
MicHTMLWriter >> visitCodeblock: aCodeBlock [

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
					language := self languageForScript: aCodeBlock.
					language isSyntaxHighlightingPossible ifTrue: [ 
						code parameterAt: 'class' put: language printString ].
					code with: [ canvas lines: aCodeBlock text ] ].
			canvas tag
				name: 'figcaption';
				with: [ 
					aCodeBlock hasLabel ifTrue: [ 
							self createAnchorWithId: aCodeBlock label.
							self writeCounterForScript: aCodeBlock ].
					aCodeBlock hasCaption ifTrue: [ 
							self visitAll: aCodeBlock caption children ] ] ].
	canvas newLine
]

{ #category : #visiting }
MicHTMLWriter >> visitFigCaption: aFigCaptionBlock [

	canvas tag
		name: 'figcaption';
		with: [ 
			aFigCaptionBlock hasCaption ifTrue: [ 
				aFigCaptionBlock captionElements do: [:each | each accept: self ] ] ]
]

{ #category : #visiting }
MicHTMLWriter >> visitFigure: aFigure [
	"Write mark up elements related with photo in the receiver's canvas"

	canvas tag
		name: 'figure';
		with: [ self visitImg: aFigure ]

]

{ #category : #visiting }
MicHTMLWriter >> visitHeader: aHeader [

	canvas newLine.	
	canvas tag 
		name: 'h',  aHeader level asString;
		with: aHeader header
	
]

{ #category : #visiting }
MicHTMLWriter >> visitImg: aMicFigureBlock [
	"Write mark up elements related with image tag in the receiver's canvas.
	Mandatory attributes:
		src - Specifies the path to the image
		alt - Specifies an alternate text for the image, if the image for some reason cannot be displayed"
	
	canvas tag
		name: 'img';
		parameterAt: 'src' put: aMicFigureBlock reference path;
		parameterAt: 'alt' put: (aMicFigureBlock hasChildren ifTrue: [ aMicFigureBlock text ] ifFalse: [ '' ]);
		addArguments: aMicFigureBlock;
		with: [ self visitFigCaption: aMicFigureBlock ]
]

{ #category : #visiting }
MicHTMLWriter >> visitItalic: aItalicText [

	canvas tag
		name: 'em';
		with: [ super visitItalic: aItalicText ]
]

{ #category : #visiting }
MicHTMLWriter >> visitLink: aLink [
	"Write markup hyperlink, which is used to link from one page to another"
	
	canvas tag
		name: 'a';
		parameterAt: 'href' put: aLink referencePath;
		addArguments: aLink;
		with: aLink caption

]

{ #category : #visiting }
MicHTMLWriter >> visitMonospace: aMonospace [

	canvas tag
		name: 'code';
		with: [ super visitMonospace: aMonospace ]
]

{ #category : #visiting }
MicHTMLWriter >> visitParagraph: aParagraph [

	canvas newLine.
	canvas tag
		name: 'p';
		with: [ super visitParagraph: aParagraph ]
]

{ #category : #visiting }
MicHTMLWriter >> visitQuote: aQuote [

	canvas tag
		name: 'q';
		with: [ 
			super visitMonospace: aQuote ]
]

{ #category : #'visiting - list' }
MicHTMLWriter >> visitStrike: aStrike [

	canvas tag
		name: 'strike';
		with: [ super visitStrike: aStrike ]
]

{ #category : #visiting }
MicHTMLWriter >> visitTable: aTable [

	| restRows |
	canvas newLine.
	canvas tag
		name: 'table';
		with: [ 
			canvas newLine.
			aTable hasHeader
				ifTrue: [ 
					self writeTableHeaders: aTable rows first. 
					restRows := aTable rows allButFirst  ] 
				ifFalse: [ restRows := aTable rows ].
			self writeTableRows: restRows.
			 ]
]

{ #category : #visiting }
MicHTMLWriter >> visitText: aText [

	canvas nextPutAll: aText text
]

{ #category : #visiting }
MicHTMLWriter >> visitUnorderedList: anUnorderedList [

	canvas newLine.
	canvas tag
		name: 'ul';
		with: [ 
			canvas newLine. 
			super visitUnorderedList: anUnorderedList  ]
]

{ #category : #visiting }
MicHTMLWriter >> visitUnorderedListItem: anUnorderedListItem [
	"will not work with we have text decorators such as bold, italic, monospace"
	
	canvas tag
		name: 'li';
		with: anUnorderedListItem text.
	canvas newLine
]

{ #category : #visiting }
MicHTMLWriter >> writeCounter: aCounter [

	"Write on the canvas the string representation of ==aCounter=="

	^ aCounter elements
		  do: [ :each | self writeCounterElement: each ]
		  separatedBy: [ self writeCounterElementSeparator ]
]

{ #category : #visiting }
MicHTMLWriter >> writeCounterDefinitionSeparator [

	canvas nextPutAll: '. '
]

{ #category : #visiting }
MicHTMLWriter >> writeCounterElement: aCounterElement [

	canvas nextPutAll: aCounterElement asString
]

{ #category : #visiting }
MicHTMLWriter >> writeCounterForScript: aScript [

	aScript counter isValidCounter ifFalse: [ ^ self ].
	self writeCounter: aScript counter.
	self writeCounterDefinitionSeparator
]

{ #category : #writing }
MicHTMLWriter >> writeTableHeaders: headers [
	canvas tag
		name: 'tr';
		with: [ headers do: [ :cell | canvas tag name: 'th'; with: [self visitAll: cell]] ].
	canvas newLine
		
]

{ #category : #writing }
MicHTMLWriter >> writeTableRows: rows [
	rows do: [ :row |
		canvas tag
			name: 'tr';
			with: [ row do: [ :cell | canvas tag name: 'td'; with: [self visitAll: cell]] ].
		canvas newLine]
		
]
