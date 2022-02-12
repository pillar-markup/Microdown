Class {
	#name : #MicTextualMicrodownExporter,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'stream',
		'builder',
		'inList'
	],
	#pools : [
		'MicroSharedPool'
	],
	#category : #'Microdown-PrettyPrinter'
}

{ #category : #helpers }
MicTextualMicrodownExporter >> backSlashString: aString [

	^ String streamContents: [ :st | 
		aString doWithIndex: [ :each :i | 
			((Delimiters includes: each asString) or:
				 (Delimiters includes:
					  each asString , (aString at: (i + 1 min: aString size)) asString)) 
			ifTrue: [ st nextPutAll: '\' ].
		st nextPutAll: each asString ]]
]

{ #category : #build }
MicTextualMicrodownExporter >> blockPrint: aMicText [

	| text |
	text := self classPrint: aMicText.
	text := text , ' "' , aMicText substring , '"'.
	^ text
]

{ #category : #API }
MicTextualMicrodownExporter >> buildRowHeader: row [

	builder newLine.
	row do: [ :cell | builder headCell ].
	^ builder raw: '|'
]

{ #category : #build }
MicTextualMicrodownExporter >> classPrint: aMicFigure [

	^ aMicFigure class asString
]

{ #category : #accessing }
MicTextualMicrodownExporter >> contents [ 
	^ stream contents
]

{ #category : #io }
MicTextualMicrodownExporter >> folderName [
	^ 'mic'
]

{ #category : #accessing }
MicTextualMicrodownExporter >> inList [
	^ inList

]

{ #category : #initialization }
MicTextualMicrodownExporter >> initialize [ 
	super initialize.
	stream := (String new: 10000) writeStream.
	builder := Microdown builder.
	builder setStream: stream.
	builder setNewLineCharacterString: String cr.
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
MicTextualMicrodownExporter >> visitChildrenWithoutBackslash: aChildren [
	aChildren do: [ :each | self visitTextWithoutBackslash: each ]
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
	builder newLine.
	builder
		environment: anEnvironment name
		body: [ super visitEnvironment: anEnvironment ]
		arguments: anEnvironment arguments.
	
]

{ #category : #'visit - format' }
MicTextualMicrodownExporter >> visitFigure: aFigure [
	
	builder newLine.
	builder
		figureURL: aFigure originUrl
		withCaption: [ super visitFigure: aFigure ]
		
]

{ #category : #'visit - block' }
MicTextualMicrodownExporter >> visitHeader: aHeader [
	
	builder newLine.
	builder 
		header: [ aHeader headerElements do: [ :each | each accept: self ] ] 
		withLevel: aHeader level
]

{ #category : #'visit - block' }
MicTextualMicrodownExporter >> visitHorizontalLine: aHorizontalLine [

	builder horizontalLine
]

{ #category : #'visit - format' }
MicTextualMicrodownExporter >> visitInputFile: anInputfile [

	 builder inputFile: anInputfile path originalString
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

	builder 
		writeDuring: [ self visitChildrenWithoutBackslash: aMonospaceFormat children ] 
		surroundBy: aMonospaceFormat openingDelimiter and: aMonospaceFormat closingDelimiter

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

{ #category : #API }
MicTextualMicrodownExporter >> visitRow: row in: aTable at: i [

	row do: [ :cell | 
		builder cell: [ cell do: [ :child | child accept: self ] ] ].
	builder raw: '|'.
	^ (aTable hasHeader and: i = 1) ifTrue: [ self buildRowHeader: row ]
]

{ #category : #'visit - format' }
MicTextualMicrodownExporter >> visitStrike: aStrikeFormat [

	builder strike: [ super visitStrike: aStrikeFormat ]
]

{ #category : #API }
MicTextualMicrodownExporter >> visitTable: aTable [

	aTable rows doWithIndex: [ :row :i | 
		builder newLine.
		self visitRow: row in: aTable at: i ]
]

{ #category : #'visit - block' }
MicTextualMicrodownExporter >> visitText: aMicTextBlock [
	
	builder text:  (self backSlashString: aMicTextBlock substring)
]

{ #category : #visiting }
MicTextualMicrodownExporter >> visitTextWithoutBackslash: aMicTextBlock [
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
