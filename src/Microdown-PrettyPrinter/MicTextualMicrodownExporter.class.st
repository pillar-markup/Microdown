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

{ #category : #'visit-inline block' }
MicTextualMicrodownExporter >> visitAnchorReference: aMicAnchorReference [

	^ self blockPrint: aMicAnchorReference
]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitAnnotated: aAnnotated [

	^ self classPrint: aAnnotated
]

{ #category : #'visit-inline block' }
MicTextualMicrodownExporter >> visitAnnotation: aMicAnnotation [
	"arguments with parameters is nil like the name"
	"| text |
	text := aMicAnnotation class asString , String space.
	text := text , (self parametersPrint: aMicAnnotation parameters asDictionary).
	text := text , ' ""' , aMicAnnotation name , '""'."
	^ self blockPrint: aMicAnnotation
	
]

{ #category : #'visit-inline block' }
MicTextualMicrodownExporter >> visitBold: aMicBold [

	^ self blockPrint: aMicBold
]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitCode: aCode [

	| text |
	text := self classPrint: aCode.
	text := text , ' parameters:' , aCode firstLine.
	text := text , ' "' , aCode body , '"'.
	^ text
]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitComment: aComment [

	| text |
	text := self classPrint: aComment.
	text := text , ' "' , aComment text , '"'.
	^ text
]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitEnvironment: aEnvironment [

	| text |
	text := (self classPrint: aEnvironment) , String space.
	text := text , (self parametersPrint: aEnvironment arguments asDictionary).
	text := text , ' "' , aEnvironment name , '"'.
	^ text
]

{ #category : #'visit-inline block' }
MicTextualMicrodownExporter >> visitFigure: aMicFigure [

	| text |
	text := (self classPrint: aMicFigure) , String space.
	text := text
	        , (self parametersPrint: aMicFigure parameters asDictionary).
	text := text , ' url:' , aMicFigure url asString.
	text := text , ' "' , aMicFigure substring , '"'.
	^ text
]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitHeader: aHeader [

	| text |
	text := self classPrint: aHeader.
	text := text , ' level:' , aHeader level asString.
	text := text , ' "' , aHeader header , '"'.
	^ text
]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitHorizontalLine: aHorizontalLine [

	^ self classPrint: aHorizontalLine
]

{ #category : #'visit-inline block' }
MicTextualMicrodownExporter >> visitItalic: aMicItalic [

	^ self blockPrint: aMicItalic
]

{ #category : #'visit-inline block' }
MicTextualMicrodownExporter >> visitLink: aMicLink [

	| text |
	text := self classPrint: aMicLink.
	text := text , ' url:' , aMicLink url asString , ' "'
	        , aMicLink substring , '"'.
	^ text
]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitListItem: aListItem [

	| text |
	text := self classPrint: aListItem.
	text := text , ' "' , aListItem text , '"'.
	^ text
]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitMath: aMath [

	| text |
	text := (self classPrint: aMath) , String space.
	text := text , (self parametersPrint: aMath arguments asDictionary).
	text := text , ' "' , aMath body , '"'.
	^ text
]

{ #category : #'visit-inline block' }
MicTextualMicrodownExporter >> visitMathInline: aMicMathInline [

	^ self blockPrint: aMicMathInline
]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitMetaData: aMetaData [

	| text |
	text := self classPrint: aMetaData.
	text := text , ' parameters:' , aMetaData firstLine.
	text := text , ' "' , aMetaData body , '"'.
	^ text
]

{ #category : #'visit-inline block' }
MicTextualMicrodownExporter >> visitMonospace: aMicMonospace [

	^ self blockPrint: aMicMonospace
]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitOrderedList: aOrderedList [

	^ self classPrint: aOrderedList
]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitParagraph: aParagraph [

	^ self classPrint: aParagraph
]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitQuote: aQuote [

	| text |
	text := self classPrint: aQuote.
	text := text , ' "' , aQuote text , '"'.
	^ text
]

{ #category : #'visit-inline block' }
MicTextualMicrodownExporter >> visitRaw: aMicRaw [

	^ self blockPrint: aMicRaw
]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitRoot: aRoot [

	aRoot children do: [ :each | each accept: self ]
	
]

{ #category : #'visit-inline block' }
MicTextualMicrodownExporter >> visitStrike: aMicStrike [

	^ self blockPrint: aMicStrike
]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitTable: aTable [

	^ self classPrint: aTable
]

{ #category : #'visit-inline block' }
MicTextualMicrodownExporter >> visitText: aMicText [

	^ self blockPrint: aMicText
]

{ #category : #'visit-block' }
MicTextualMicrodownExporter >> visitUnorderedList: aUnorderedList [

	^ self classPrint: aUnorderedList
]
