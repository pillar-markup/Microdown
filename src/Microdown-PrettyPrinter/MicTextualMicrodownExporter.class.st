"
I export a Microdown document back to Microdown text: I am the pretty printer of Microdown. I visit the tree produced by the parser (`Microdown parse:`) and write each element with its Microdown syntax.

## Life cycle: who creates me and who uses me

1. A client creates me with `new` and sends me `visit:` with a document or any element; I answer the Microdown text. For example `NTNote>>generateMetaDataElements` (TheNoteTaker) writes the metadata block of a note this way.
2. `MicTextDocumentMaker>>basicWriter` creates me as the default writer of a `MicTemplatedWriter`, which asks me for `contents` and `folderName` and delegates to me the elements it has no template for.
3. `MicTextualMicrodownExporter>>visitAnnotated:` creates a second instance of me to write the children of an annotated paragraph and puts its `contents` between brackets.
4. I am used once: my stream keeps what I wrote, so a new document needs a new instance.

## Responsibility:

- I turn each kind of Microdown element (headers, paragraphs, lists, tables, code blocks, figures, links, formats, metadata, environments, ...) back into Microdown text.
- I take care of the new lines between blocks and of the nesting of lists.
- I escape the characters that Microdown would otherwise interpret (`backSlashString:`).

## Collaborators: 

- `MicrodownVisitor`: my superclass, it walks the tree and calls my `visit...:` methods.
- `MicMicrodownTextualBuilder` (`Microdown builder`): I delegate the Microdown syntax to it (`paragraph:`, `bold:`, `unorderedListDuring:`, `metaDataFromAssociations:`, ...).
- `MicTemplatedWriter`, through `MicTextDocumentMaker`: uses me as its default writer.

## Why I am not a subclass of `MicDocumentWriter`

`MicDocumentWriter` is the root of the LaTeX and Beamer writers. Moving me under it was considered and judged not worth it:

- It writes through a `MicExportCanvas` on a `MicOutputStream`, created in its `initialize` from `canvasClass`. I write through a `MicMicrodownTextualBuilder`, which already knows the Microdown syntax; a canvas would sit unused next to it, or the builder would have to take over the canvas protocol (`on:`, `crAsNewLine`, `lfAsNewLine`, `crlfAsNewLine`, `writingRaw:`, `stream usedNewLine`).
- What it adds is not needed for Microdown output: the choice of line ending (I always use `String cr`, set with `setNewLineCharacterString:`), and raw writing with the encoding of special characters (a raw format is written back as is between `{{` and `}}`, see `visitRaw:`).
- The price is small: I do not understand `write:` nor the line ending messages. Clients send me `visit:`, which answers the text, or `contents`.

## Public API and Key Messages

- `new` creates me; there is nothing to configure.
- `visit: aMicElement` writes the element and answers the Microdown text.
- `contents` answers the text written so far.

## Examples

```
MicTextualMicrodownExporter scriptRoundTrip
```

## Internal Representation

- `stream`: the `WriteStream` holding the text I write.
- `builder`: a `MicMicrodownTextualBuilder` writing on `stream`, with `String cr` as new line.
- `inList`: true while I write the items of the outermost list, so that nested lists do not start with an empty line.
"
Class {
	#name : 'MicTextualMicrodownExporter',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'stream',
		'builder',
		'inList'
	],
	#pools : [
		'MicSharedPool'
	],
	#category : 'Microdown-PrettyPrinter',
	#package : 'Microdown-PrettyPrinter'
}

{ #category : 'script' }
MicTextualMicrodownExporter class >> scriptRoundTrip [
	"Parse a Microdown text and export the document back as Microdown text: the header, the bold and monospace text and the list come back in Microdown syntax."

	<example>
	| document |
	document := Microdown parse: '# Title

A **bold** and `code` paragraph.

- one
- two'.
	^ (self new visit: document) inspect
]

{ #category : 'helpers' }
MicTextualMicrodownExporter >> backSlashString: aString [

	^ String streamContents: [ :st | 
		aString doWithIndex: [ :each :i | 
			((Delimiters includes: each asString) or:
				 (Delimiters includes:
					  each asString , (aString at: (i + 1 min: aString size)) asString)) 
			ifTrue: [ st nextPutAll: '\' ].
		st nextPutAll: each asString ]]
]

{ #category : 'build' }
MicTextualMicrodownExporter >> blockPrint: aMicText [

	| text |
	text := self classPrint: aMicText.
	text := text , ' "' , aMicText substring , '"'.
	^ text
]

{ #category : 'API' }
MicTextualMicrodownExporter >> buildRowHeader: row [

	builder newLine.
	row do: [ :cell | builder headCell ].
	^ builder raw: '|'
]

{ #category : 'build' }
MicTextualMicrodownExporter >> classPrint: aMicFigure [

	^ aMicFigure class asString
]

{ #category : 'accessing' }
MicTextualMicrodownExporter >> contents [ 
	^ stream contents
]

{ #category : 'io' }
MicTextualMicrodownExporter >> folderName [
	^ 'mic'
]

{ #category : 'accessing' }
MicTextualMicrodownExporter >> inList [
	^ inList

]

{ #category : 'initialization' }
MicTextualMicrodownExporter >> initialize [ 
	super initialize.
	stream := (String new: 10000) writeStream.
	builder := Microdown builder.
	builder setStream: stream.
	builder setNewLineCharacterString: String cr.
	inList := false
]

{ #category : 'build' }
MicTextualMicrodownExporter >> parametersPrint: aDictionnary [

	| text lastKey |
	lastKey := aDictionnary keys last.
	text := 'parameters:'.
	aDictionnary keysAndValuesDo: [ :k :v |
		text := text , k ,'=', v.
		k = lastKey 
			ifFalse: [ 
				text := text , '&' ]].
	^ text
]

{ #category : 'setting' }
MicTextualMicrodownExporter >> setFalseInList [
	inList := false

]

{ #category : 'setting' }
MicTextualMicrodownExporter >> setTrueInList [
	inList := true

]

{ #category : 'API' }
MicTextualMicrodownExporter >> visit: aMicElement [
	"Entry point to launch the traversal."
	
	super visit: aMicElement. 
	^ stream contents
]

{ #category : 'visit - block' }
MicTextualMicrodownExporter >> visitAnchor: anAnchor [
	
	builder anchor: anAnchor label
]

{ #category : 'visit - format' }
MicTextualMicrodownExporter >> visitAnchorReference: anAnchorReference [
	
	builder anchorReference: anAnchorReference bodyString
]

{ #category : 'visit - block' }
MicTextualMicrodownExporter >> visitAnnotated: anAnnotated [

	| textualExporter |
	textualExporter := MicTextualMicrodownExporter new.
	textualExporter visitChildrenOf: anAnnotated.

	builder
		annotated: anAnnotated label
		paragraph: [ builder textWithBracket: textualExporter contents ]
]

{ #category : 'templating ping pong' }
MicTextualMicrodownExporter >> visitAnnotated: anAnnotated from: templated [
	"Write anAnnotated for a templated writer that has no template for it: its children are written by the templated writer."

	builder annotated: anAnnotated label paragraph: [ builder textWithBracket: (templated contentsOfChildrenOf: anAnnotated) ]
]

{ #category : 'visit - format' }
MicTextualMicrodownExporter >> visitAnnotation: anAnnotation [

	builder raw: anAnnotation openingDelimiter.
	builder raw: anAnnotation bodyString.
	builder raw: anAnnotation closingDelimiter
]

{ #category : 'visit - format' }
MicTextualMicrodownExporter >> visitBold: aBoldFormat [

	builder bold: [ super visitBold: aBoldFormat ]
]

{ #category : 'templating ping pong' }
MicTextualMicrodownExporter >> visitBold: aBold from: templated [
	"Write aBold for a templated writer that has no template for it: its children go back to the templated writer."

	builder bold: [ templated visitChildrenOf: aBold ]
]

{ #category : 'visit - block' }
MicTextualMicrodownExporter >> visitChildrenWithoutBackslash: aChildren [
	aChildren do: [ :each | self visitTextWithoutBackslash: each ]
]

{ #category : 'visit - block' }
MicTextualMicrodownExporter >> visitCode: aMicCodeBlock [ 

	builder newLine.
	builder
		  codeblock: aMicCodeBlock body
		  firstLineAssociations: aMicCodeBlock arguments withoutDefaultValue associations
		  withCaption: [ super visitCode: aMicCodeBlock ]

]

{ #category : 'visit - block' }
MicTextualMicrodownExporter >> visitComment: aComment [

	builder comment: aComment text
]

{ #category : 'visit - block' }
MicTextualMicrodownExporter >> visitEnvironment: anEnvironment [
	builder newLine.
	builder
		environment: anEnvironment environmentName 
		body: [ super visitEnvironment: anEnvironment ]
		arguments: anEnvironment arguments justTheArguments .
	
]

{ #category : 'templating ping pong' }
MicTextualMicrodownExporter >> visitEnvironment: anEnvironment from: templated [
	"Write anEnvironment for a templated writer that has no template for it: its children go back to the templated writer."

	builder newLine.
	builder
		environment: anEnvironment environmentName
		body: [ templated visitChildrenOf: anEnvironment ]
		arguments: anEnvironment arguments justTheArguments
]

{ #category : 'visit - format' }
MicTextualMicrodownExporter >> visitFigure: aFigure [
	
	builder newLine.
	builder
		figureURL: aFigure url
		withCaption: [ super visitFigure: aFigure ]
		
]

{ #category : 'templating ping pong' }
MicTextualMicrodownExporter >> visitFigure: aFigure from: templated [
	"Write aFigure for a templated writer that has no template for it: its caption goes back to the templated writer."

	builder newLine.
	builder figureURL: aFigure url withCaption: [ templated visitChildrenOf: aFigure ]
]

{ #category : 'visiting - html extensions' }
MicTextualMicrodownExporter >> visitHTMLTagParagraph: anHTMLTagParagraph [

	self visitHTMLTagParagraph: anHTMLTagParagraph from: self
]

{ #category : 'templating ping pong' }
MicTextualMicrodownExporter >> visitHTMLTagParagraph: anHTMLTagParagraph from: aVisitor [
	"Write the tag lines of anHTMLTagParagraph; aVisitor (myself or a templated writer without a template for it) writes its children."

	builder newLine.
	builder raw: '<' , anHTMLTagParagraph label.
	anHTMLTagParagraph hasArguments ifTrue: [ builder raw: ' ' , anHTMLTagParagraph argumentString ].
	builder raw: '>'.
	aVisitor visitChildrenOf: anHTMLTagParagraph.
	builder newLine.
	builder raw: anHTMLTagParagraph lineStopMarkup
]

{ #category : 'visit - block' }
MicTextualMicrodownExporter >> visitHeader: aHeader [
	
	builder newLine.
	builder 
		header: [ self visitAll: aHeader headerElements ] 
		withLevel: aHeader level
]

{ #category : 'templating ping pong' }
MicTextualMicrodownExporter >> visitHeader: aHeader from: templated [
	"Write aHeader for a templated writer that has no template for it: its children go back to the templated writer."

	builder newLine.
	builder header: [ templated visitAll: aHeader headerElements ] withLevel: aHeader level
]

{ #category : 'visit - block' }
MicTextualMicrodownExporter >> visitHorizontalLine: aHorizontalLine [

	builder horizontalLine
]

{ #category : 'visit - format' }
MicTextualMicrodownExporter >> visitInputFile: anInputfile [

	builder inputFile: anInputfile fullNameString
]

{ #category : 'visit - format' }
MicTextualMicrodownExporter >> visitItalic: anItalicFormatBlock [

	builder italic: [ super visitItalic: anItalicFormatBlock ]
]

{ #category : 'templating ping pong' }
MicTextualMicrodownExporter >> visitItalic: anItalic from: templated [
	"Write anItalic for a templated writer that has no template for it: its children go back to the templated writer."

	builder italic: [ templated visitChildrenOf: anItalic ]
]

{ #category : 'visit - format' }
MicTextualMicrodownExporter >> visitLink: aLink [

	builder 
		externalLink: aLink url 
		withDescription: [ super visitLink: aLink ]
]

{ #category : 'templating ping pong' }
MicTextualMicrodownExporter >> visitLink: aLink from: templated [
	"Write aLink for a templated writer that has no template for it: its children go back to the templated writer."

	builder externalLink: aLink url withDescription: [ templated visitChildrenOf: aLink ]
]

{ #category : 'visit - list' }
MicTextualMicrodownExporter >> visitListItem: anItem [
	"here we do not handle the prefix - or a number"

	builder itemBody: [ super visitListItem: anItem ]
]

{ #category : 'templating ping pong' }
MicTextualMicrodownExporter >> visitListItem: anItem from: templated [
	"Write anItem for a templated writer that has no template for it: its children go back to the templated writer."

	builder itemBody: [ templated visitChildrenOf: anItem ]
]

{ #category : 'visit - block' }
MicTextualMicrodownExporter >> visitMath: aMicMath [

	 builder
		  mathblock: aMicMath body
		  firstLineAssociations: aMicMath arguments associations
		  withCaption: [ super visitMath: aMicMath ]

]

{ #category : 'visit - format' }
MicTextualMicrodownExporter >> visitMathInline: aMicMathInline [

	builder mathInline: aMicMathInline bodyString
]

{ #category : 'visit - block' }
MicTextualMicrodownExporter >> visitMetaData: aMetaData [

	builder metaDataFromAssociations: aMetaData body associations
]

{ #category : 'visit - format' }
MicTextualMicrodownExporter >> visitMonospace: aMonospaceFormat [

	builder 
		writeDuring: [ self visitChildrenWithoutBackslash: aMonospaceFormat children ] 
		surroundBy: aMonospaceFormat openingDelimiter and: aMonospaceFormat closingDelimiter

]

{ #category : 'visiting - list' }
MicTextualMicrodownExporter >> visitOrderedList: anOrderedList [

	self visitOrderedList: anOrderedList from: self
]

{ #category : 'templating ping pong' }
MicTextualMicrodownExporter >> visitOrderedList: anOrderedList from: aVisitor [
	"Write anOrderedList; aVisitor (myself or a templated writer without a template for it) writes its items."

	| block |
	block := [ ].
	self inList ifFalse: [
			builder newLine.
			self setTrueInList.
			block := [ self setFalseInList ] ].
	"the problem if we use accept is that anitem is not an orderd or unordered. 
	There is only one kind of item. So we cannot use the dispatch."

	builder orderedListDuring: [
		anOrderedList children do: [ :orderedItem | builder orderedItem: [ builder itemBody: [ aVisitor visitEach: orderedItem ] ] ] ].

	block value
]

{ #category : 'visit - list' }
MicTextualMicrodownExporter >> visitOrderedListItem2: anItem [

	builder orderedItem: [ super visitOrderedListItem: anItem ]
]

{ #category : 'visit - block' }
MicTextualMicrodownExporter >> visitParagraph: aParagraph [

	builder newLine.
	builder 
		paragraph: [ super visitParagraph: aParagraph ]
]

{ #category : 'templating ping pong' }
MicTextualMicrodownExporter >> visitParagraph: aParagraph from: templated [
	"Write aParagraph for a templated writer that has no template for it: its children go back to the templated writer."

	builder newLine.
	builder paragraph: [ templated visitChildrenOf: aParagraph ]
]

{ #category : 'visit - format' }
MicTextualMicrodownExporter >> visitQuote: aQuote [

	builder quoteBlock: aQuote text
]

{ #category : 'templating ping pong' }
MicTextualMicrodownExporter >> visitQuote: aQuote from: templated [
	"Write aQuote for a templated writer that has no template for it: its children go back to the templated writer."

	builder writeQuoteCodeBlockDuring: [ templated visitChildrenOf: aQuote ]
]

{ #category : 'visit - format' }
MicTextualMicrodownExporter >> visitRaw: aRawFormat [

	builder rawFormat: aRawFormat bodyString
]

{ #category : 'visit - block' }
MicTextualMicrodownExporter >> visitRoot: aRoot [

	builder 
		root: [ super visitRoot: aRoot ] 
]

{ #category : 'templating ping pong' }
MicTextualMicrodownExporter >> visitRoot: aRoot from: templated [
	"Write aRoot for a templated writer that has no template for it: its children go back to the templated writer."

	builder root: [ templated visitChildrenOf: aRoot ]
]

{ #category : 'API' }
MicTextualMicrodownExporter >> visitRow: row in: aTable at: i [

	row do: [ :cell | 
		builder cell: [ cell do: [ :child | child accept: self ] ] ].
	builder raw: '|'.
	^ (aTable hasHeader and: i = 1) ifTrue: [ self buildRowHeader: row ]
]

{ #category : 'visit - format' }
MicTextualMicrodownExporter >> visitStrike: aStrikeFormat [

	builder strike: [ super visitStrike: aStrikeFormat ]
]

{ #category : 'templating ping pong' }
MicTextualMicrodownExporter >> visitStrike: aStrike from: templated [
	"Write aStrike for a templated writer that has no template for it: its children go back to the templated writer."

	builder strike: [ templated visitChildrenOf: aStrike ]
]

{ #category : 'API' }
MicTextualMicrodownExporter >> visitTable: aTable [

	aTable rows doWithIndex: [ :row :i | 
		builder newLine.
		self visitRow: row in: aTable at: i ]
]

{ #category : 'visit - block' }
MicTextualMicrodownExporter >> visitText: aMicTextBlock [

	builder text: (self backSlashString: aMicTextBlock bodyString)
]

{ #category : 'visiting' }
MicTextualMicrodownExporter >> visitTextWithoutBackslash: aMicTextBlock [

	builder text: aMicTextBlock bodyString
]

{ #category : 'visiting - list' }
MicTextualMicrodownExporter >> visitUnorderedList: aUnorderedList [

	self visitUnorderedList: aUnorderedList from: self
]

{ #category : 'templating ping pong' }
MicTextualMicrodownExporter >> visitUnorderedList: aUnorderedList from: aVisitor [
	"Write aUnorderedList; aVisitor (myself or a templated writer without a template for it) writes its items."

	| block |
	block := [ ].
	self inList ifFalse: [
			builder newLine.
			self setTrueInList.
			block := [ self setFalseInList ] ].
	builder unorderedListDuring: [
		aUnorderedList children do: [ :unorderedItem | builder item: [ builder itemBody: [ aVisitor visitEach: unorderedItem ] ] ] ].

	block value
]

{ #category : 'templating ping pong' }
MicTextualMicrodownExporter >> writeTemplatedText: aString [
	"Write aString, the result of a template applied by a templated writer, as is: it must not be escaped."

	builder raw: aString
]
