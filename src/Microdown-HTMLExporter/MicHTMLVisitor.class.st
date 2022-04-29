"
A first version of an HTML writer. 
We should rewrite it once the templatedWriter is working.
"
Class {
	#name : #MicHTMLVisitor,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'canvas'
	],
	#category : #'Microdown-HTMLExporter'
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

	MicHTMLDoc new
		addCSSFile: (MicCSSLocalProvider named: 'Tufte');	
		fromMicrodown: aMicrodownString;
		writeToFile

]

{ #category : #converting }
MicHTMLVisitor class >> serializeToHTMLDoc: aMicrodownString withStyle: aStyleName [
	"Serialize aMicrodownString <String> to a HTML file with CSS style named aStyleName and default for output directory and file name"

	MicHTMLDoc new
		addCSSFile: (MicCSSLocalProvider named: aStyleName);	
		fromMicrodown: aMicrodownString;
		writeToFile

]

{ #category : #initialization }
MicHTMLVisitor >> canvasClass [

	^ MicHTMLCanvas
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
	^ MicHTMLDoc new
		writeDocument: self contents;
		contents
]

{ #category : #visiting }
MicHTMLVisitor >> createAnchorWithId: anId [

	canvas tag
		name: 'a';
		parameterAt: 'id' put: anId;
		with: ''
]

{ #category : #initialization }
MicHTMLVisitor >> initialize [ 
	| stream |
	super initialize.
	stream := MicOutputStream new setStream: (WriteStream on: String empty).
	canvas := self canvasClass on: stream.
	
]

{ #category : #visiting }
MicHTMLVisitor >> isSyntaxHighlightingPossible [

	^ true
]

{ #category : #visiting }
MicHTMLVisitor >> languageForScript: aScript [

	^ aScript language isSpecified
		  ifTrue: [ aScript language ]
		  ifFalse: [ self configuration defaultScriptLanguage ]
]

{ #category : #initialization }
MicHTMLVisitor >> usedNewLine [
	"Return the encoded new line. Useful for tests."
	
	^ canvas stream usedNewLine
]

{ #category : #visiting }
MicHTMLVisitor >> visitAnchor: anAnchor [

	self createAnchorWithId: anAnchor label 
]

{ #category : #visiting }
MicHTMLVisitor >> visitAnnotated: anAnnotatedParagraph [

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
					self halt.
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
MicHTMLVisitor >> visitColumns: aMicColumnsBlock [ 
	"??"
]

{ #category : #visiting }
MicHTMLVisitor >> visitFigCaption: aFigCaptionBlock [

	canvas tag
		name: 'figcaption';
		with: [ 
			aFigCaptionBlock hasCaption ifTrue: [ 
				aFigCaptionBlock captionElements do: [:each | each accept: self ] ] ]
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
		with: aHeader header
	
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
		parameterAt: 'alt' put: (aMicFigureBlock hasChildren ifTrue: [ aMicFigureBlock text ] ifFalse: [ '' ]);
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
		parameterAt: 'href' put: aLink referencePath;
		addArguments: aLink;
		with: aLink caption

]

{ #category : #'visiting - inline elements' }
MicHTMLVisitor >> visitMonospace: aMonospace [

	canvas tag
		name: 'code';
		with: [ super visitMonospace: aMonospace ]
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

	canvas tag
		name: 'q';
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

{ #category : #'visiting - inline elements' }
MicHTMLVisitor >> visitText: aText [

	canvas nextPutAll: aText text
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
		with: anUnorderedListItem listItemText.
	canvas newLine.
	anUnorderedListItem hasChildren
		ifTrue: [ 
			 anUnorderedListItem hasNestedChildren
				ifTrue: [ 
					| listItemWithoutText |
					listItemWithoutText := anUnorderedListItem copy.
					listItemWithoutText children removeFirst.
					self visitUnorderedList: listItemWithoutText ]
				ifFalse: [ 
					| listItemWithoutFirst |
					listItemWithoutFirst := anUnorderedListItem copy.
					listItemWithoutFirst children removeFirst.					
					self visitUnorderedListItem: listItemWithoutFirst ] ]
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
MicHTMLVisitor >> writeCounterForScript: aScript [

	aScript counter isValidCounter ifFalse: [ ^ self ].
	self writeCounter: aScript counter.
	self writeCounterDefinitionSeparator
]

{ #category : #writing }
MicHTMLVisitor >> writeTableHeaders: headers [
	canvas tag
		name: 'tr';
		with: [ headers do: [ :cell | canvas tag name: 'th'; with: [self visitAll: cell]] ].
	canvas newLine
		
]

{ #category : #writing }
MicHTMLVisitor >> writeTableRows: rows [
	rows do: [ :row |
		canvas tag
			name: 'tr';
			with: [ row do: [ :cell | canvas tag name: 'td'; with: [self visitAll: cell]] ].
		canvas newLine]
		
]
