Class {
	#name : #MicTextualMicrodownExporter,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'stream',
		'builder',
		'inList'
	],
	#category : #'Microdown-PrettyPrinter'
}

{ #category : #build }
MicTextualMicrodownExporter >> blockPrint: aMicText [

	| text |
	text := self classPrint: aMicText.
	text := text , ' "' , aMicText substring , '"'.
	^ text
]

{ #category : #build }
MicTextualMicrodownExporter >> classPrint: aMicFigure [

	^ aMicFigure class asString
]

{ #category : #accessing }
MicTextualMicrodownExporter >> contents [ 
	^ stream contents
]

{ #category : #accessing }
MicTextualMicrodownExporter >> inList [
	^ inList

]

{ #category : #initialization }
MicTextualMicrodownExporter >> initialize [ 
	super initialize.
	stream := (String new: 10000) writeStream.
	builder := MicroDownParser builder.
	builder setStream: stream.
	builder setLine: String cr.
	inList := false
]

{ #category : #build }
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

{ #category : #setting }
MicTextualMicrodownExporter >> setFalseInList [
	inList := false

]

{ #category : #setting }
MicTextualMicrodownExporter >> setTrueInList [
	inList := true

]

{ #category : #API }
MicTextualMicrodownExporter >> visit: aMicElement [

	aMicElement accept: self.
	^ stream contents
]

{ #category : #'visit - block' }
MicTextualMicrodownExporter >> visitAnchor: anAnchor [
	
	builder anchor: anAnchor label
]

{ #category : #'visit - format' }
MicTextualMicrodownExporter >> visitAnchorReference: anAnchorReference [

	builder anchorReference: anAnchorReference substring
]

{ #category : #'visit - block' }
MicTextualMicrodownExporter >> visitAnnotated: anAnnotated [

	builder 
		annotated: anAnnotated label 
		paragraph:  [ super visitAnnotated: anAnnotated  ] 
]

{ #category : #'visit - format' }
MicTextualMicrodownExporter >> visitAnnotation: anAnnotation [

	builder annotation: anAnnotation name arguments: anAnnotation arguments
]

{ #category : #'visit - format' }
MicTextualMicrodownExporter >> visitBold: aBoldFormat [

	builder bold: [ super visitBold: aBoldFormat ]
]

{ #category : #'visit - block' }
MicTextualMicrodownExporter >> visitCode: aMicCodeBlock [ 

	builder newLine.
	 builder
		  codeblock: aMicCodeBlock body
		  firstLineAssociations: aMicCodeBlock argumentAssociations
		  withCaption: [ super visitCode: aMicCodeBlock ]

]

{ #category : #'visit - block' }
MicTextualMicrodownExporter >> visitComment: aComment [

	builder comment: aComment text
]

{ #category : #'visit - block' }
MicTextualMicrodownExporter >> visitEnvironment: anEnvironment [

	builder 
		environment: anEnvironment name 
		body: [ :b | super visitEnvironment: anEnvironment ] 
		arguments: anEnvironment arguments
]

{ #category : #'visit - format' }
MicTextualMicrodownExporter >> visitFigure: aFigure [
	
	builder newLine.
	builder
		figureURL: aFigure url
		withCaption: [ super visitFigure: aFigure ]
		
]

{ #category : #'visit - block' }
MicTextualMicrodownExporter >> visitHeader: aHeader [
	
	builder newLine.
	builder 
		header: [:b | aHeader headerElements do: [ :each | each accept: self ] ] 
		withLevel: aHeader level
]

{ #category : #'visit - block' }
MicTextualMicrodownExporter >> visitHorizontalLine: aHorizontalLine [

	builder horizontalLine
]

{ #category : #'visit - format' }
MicTextualMicrodownExporter >> visitItalic: anItalicFormatBlock [

	builder italic: [ super visitItalic: anItalicFormatBlock ]
]

{ #category : #'visit - format' }
MicTextualMicrodownExporter >> visitLink: aLink [

	builder 
		externalLink: aLink url 
		withDescription: [ super visitLink: aLink ]
]

{ #category : #'visit - block' }
MicTextualMicrodownExporter >> visitListItem: anItem [

	builder item: [ super visitListItem: anItem ]
]

{ #category : #'visit - block' }
MicTextualMicrodownExporter >> visitMath: aMicMath [

	 builder
		  mathblock: aMicMath body
		  firstLineAssociations: aMicMath argumentAssociations
		  withCaption: [ super visitMath: aMicMath ]

]

{ #category : #'visit - format' }
MicTextualMicrodownExporter >> visitMathInline: aMicMathInline [

	builder mathInline: aMicMathInline substring
]

{ #category : #'visit - block' }
MicTextualMicrodownExporter >> visitMetaData: aMetaData [

	builder metaDataFromAssociations: aMetaData body
]

{ #category : #'visit - format' }
MicTextualMicrodownExporter >> visitMonospace: aMonospaceFormat [

	builder monospace: [ super visitMonospace: aMonospaceFormat ]
]

{ #category : #'visit - block' }
MicTextualMicrodownExporter >> visitOrderedList: anOrderedList [

	| block |
	block := [  ].
	self inList ifFalse: 
		[ builder newLine.
		 self setTrueInList.
		 block := [ self setFalseInList ] ].
	builder unorderedListDuring: [ super visitOrderedList: anOrderedList ].
	block value
]

{ #category : #'visit - block' }
MicTextualMicrodownExporter >> visitOrderedListItem: anItem [

	builder orderedItem: [ super visitListItem: anItem ]
]

{ #category : #'visit - block' }
MicTextualMicrodownExporter >> visitParagraph: aParagraph [

	builder newLine.
	builder 
		paragraph: [ super visitParagraph: aParagraph ]
]

{ #category : #'visit - format' }
MicTextualMicrodownExporter >> visitQuote: aQuote [

	builder quoteBlock: aQuote text
]

{ #category : #'visit - format' }
MicTextualMicrodownExporter >> visitRaw: aRawFormat [

	builder rawFormat: aRawFormat substring
]

{ #category : #'visit - block' }
MicTextualMicrodownExporter >> visitRoot: aRoot [

	builder 
		root: [ super visitRoot: aRoot ] 
]

{ #category : #'visit - format' }
MicTextualMicrodownExporter >> visitStrike: aStrikeFormat [

	builder strike: [ super visitStrike: aStrikeFormat ]
]

{ #category : #'visit - block' }
MicTextualMicrodownExporter >> visitText: aMicTextBlock [

	builder text: aMicTextBlock substring
]

{ #category : #'visit - block' }
MicTextualMicrodownExporter >> visitUnorderedList: aUnorderedList [
	
	| block |
	block := [  ].
	self inList ifFalse: 
		[ builder newLine.
		 self setTrueInList.
		 block := [ self setFalseInList ] ].
	builder unorderedListDuring: [ super visitUnorderedList: aUnorderedList ].
	block value
]
