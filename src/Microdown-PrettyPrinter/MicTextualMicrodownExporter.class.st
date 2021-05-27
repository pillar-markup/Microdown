Class {
	#name : #MicTextualMicrodownExporter,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'stream',
		'builder'
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

{ #category : #initialization }
MicTextualMicrodownExporter >> initialize [ 
	super initialize.
	stream := (String new: 10000) writeStream.
	builder := MicroDownParser builder.
	builder setStream: stream.
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

{ #category : #API }
MicTextualMicrodownExporter >> visit: aMicElement [

	aMicElement accept: self.
	^ stream contents
]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitAnchor: anAnchor [
	
	builder anchor: anAnchor label
]

{ #category : #'visit - format' }
MicTextualMicrodownExporter >> visitAnchorReference: anAnchorReference [

	builder anchorReference: anAnchorReference substring
]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitAnnotated: anAnnotated [

	builder 
		annotated: anAnnotated label paragraph:  [:b | anAnnotated body do: [ :each | each accept: self ] ] 
]

{ #category : #'visit - format' }
MicTextualMicrodownExporter >> visitBold: aBoldFormat [

	builder bold: aBoldFormat substring
]

{ #category : #visiting }
MicTextualMicrodownExporter >> visitCode: aMicCodeBlock [ 
	
	 builder
		  codeblock: aMicCodeBlock body
		  firstLineAssociations: aMicCodeBlock argumentAssociations

]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitComment: aComment [

	builder comment: aComment text
]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitEnvironment: anEnvironment [

	builder environment: anEnvironment name body: [ :b | anEnvironment bodyElements do: [ :each | each accept: self ] ] arguments: anEnvironment arguments
]

{ #category : #'visit - format' }
MicTextualMicrodownExporter >> visitFigure: aFigure [

	builder figure: aFigure url path withDescription: [:b | b raw: aFigure substring] withParameters: aFigure parameters . 
]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitHeader: aHeader [

	builder 
		header: [:b | aHeader headerElements do: [ :each | each accept: self ] ] 
		withLevel: aHeader level
]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitHorizontalLine: aHorizontalLine [

	builder horizontalLine
]

{ #category : #'visit - format' }
MicTextualMicrodownExporter >> visitItalic: aMicItalicFormatBlock [
	
	builder italic: aMicItalicFormatBlock substring
]

{ #category : #'visit - format' }
MicTextualMicrodownExporter >> visitLink: aLink [

	builder externalLink: aLink url path  withDescription: aLink substring 
]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitListItem: anItem [

	builder item: [ :b | anItem textElements do: [ :each |each accept: self ] ]
]

{ #category : #visiting }
MicTextualMicrodownExporter >> visitMath: aMicMath [
	 builder
		  mathblock: aMicMath body
		  firstLineAssociations: aMicMath argumentAssociations

]

{ #category : #'visit - format' }
MicTextualMicrodownExporter >> visitMathInline: aMicMathInline [

	builder mathInline: aMicMathInline substring
]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitMetaData: aMetaData [
	builder metaDataFromAssociations: aMetaData body
]

{ #category : #'visit - format' }
MicTextualMicrodownExporter >> visitMonospace: aMonospaceFormat [

	builder monospace: aMonospaceFormat substring
]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitOrderedList: anOrderedList [

	builder unorderedListDuring: [ :b | anOrderedList children do: [ :each |self visitOrderedListItem: each ] ]
]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitOrderedListItem: anItem [

	builder orderedItem: [ :b | anItem textElements do: [ :each |each accept: self ] ]
]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitParagraph: aParagraph [
	builder 
		paragraph: [ :b | aParagraph children do: [:each |each accept: self]]
]

{ #category : #'visit - format' }
MicTextualMicrodownExporter >> visitQuote: aQuote [

	builder quoteBlock: aQuote text
]

{ #category : #'visit - format' }
MicTextualMicrodownExporter >> visitRaw: aRawFormat [

	builder rawFormat: aRawFormat substring
]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitRoot: aRoot [

	builder 
		root: [:b | aRoot children do: [ :each | each accept: self ] ] 
]

{ #category : #'visit - format' }
MicTextualMicrodownExporter >> visitStrike: aStrikeFormat [

	builder strike: aStrikeFormat substring
]

{ #category : #'visit - format' }
MicTextualMicrodownExporter >> visitText: aMicTextBlock [

	builder text: aMicTextBlock substring
]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitUnorderedList: aUnorderedList [

	builder unorderedListDuring: [ :b | aUnorderedList children do: [ :each |each accept: self ] ]
]
