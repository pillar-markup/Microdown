Class {
	#name : #MicDumper,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'stream'
	],
	#category : #'Microdown-PrettyPrinter'
}

{ #category : #build }
MicDumper >> blockPrint: aMicText [

	| text |
	text := self classPrint: aMicText.
	text := text , ' "' , aMicText substring , '"'.
	^ text
]

{ #category : #build }
MicDumper >> classPrint: aMicFigure [

	^ aMicFigure class asString
]

{ #category : #initialization }
MicDumper >> initialize [ 
	super initialize.
	stream := (String new: 10000) writeStream
]

{ #category : #build }
MicDumper >> parametersPrint: aDictionnary [

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

{ #category : #'visit-block' }
MicDumper >> visitAnchor: aAnchor [

	| text |
	text := self classPrint: aAnchor.
	text := text , ' "' , aAnchor label , '"'.
	^ text
]

{ #category : #'visit-inline block' }
MicDumper >> visitAnchorReference: aMicAnchorReference [

	^ self blockPrint: aMicAnchorReference
]

{ #category : #'visit-block' }
MicDumper >> visitAnnotated: aAnnotated [

	^ self classPrint: aAnnotated
]

{ #category : #'visit-inline block' }
MicDumper >> visitAnnotation: aMicAnnotation [
	"arguments with parameters is nil like the name"
	"| text |
	text := aMicAnnotation class asString , String space.
	text := text , (self parametersPrint: aMicAnnotation parameters asDictionary).
	text := text , ' ""' , aMicAnnotation name , '""'."
	^ self blockPrint: aMicAnnotation
	
]

{ #category : #'visit-inline block' }
MicDumper >> visitBold: aMicBold [

	^ self blockPrint: aMicBold
]

{ #category : #'visit-block' }
MicDumper >> visitCode: aCode [

	| text |
	text := self classPrint: aCode.
	text := text , ' parameters:' , aCode firstLine.
	text := text , ' "' , aCode body , '"'.
	^ text
]

{ #category : #'visit-block' }
MicDumper >> visitComment: aComment [

	| text |
	text := self classPrint: aComment.
	text := text , ' "' , aComment text , '"'.
	^ text
]

{ #category : #'visit-block' }
MicDumper >> visitEnvironment: aEnvironment [

	| text |
	text := (self classPrint: aEnvironment) , String space.
	text := text , (self parametersPrint: aEnvironment arguments asDictionary).
	text := text , ' "' , aEnvironment name , '"'.
	^ text
]

{ #category : #'visit-inline block' }
MicDumper >> visitFigure: aMicFigure [

	| text |
	text := (self classPrint: aMicFigure) , String space.
	text := text
	        , (self parametersPrint: aMicFigure parameters asDictionary).
	text := text , ' url:' , aMicFigure url asString.
	text := text , ' "' , aMicFigure substring , '"'.
	^ text
]

{ #category : #'visit-block' }
MicDumper >> visitHeader: aHeader [

	| text |
	text := self classPrint: aHeader.
	text := text , ' level:' , aHeader level asString.
	text := text , ' "' , aHeader header , '"'.
	^ text
]

{ #category : #'visit-block' }
MicDumper >> visitHorizontalLine: aHorizontalLine [

	^ self classPrint: aHorizontalLine
]

{ #category : #'visit-inline block' }
MicDumper >> visitItalic: aMicItalic [

	^ self blockPrint: aMicItalic
]

{ #category : #'visit-inline block' }
MicDumper >> visitLink: aMicLink [

	| text |
	text := self classPrint: aMicLink.
	text := text , ' url:' , aMicLink url asString , ' "'
	        , aMicLink substring , '"'.
	^ text
]

{ #category : #'visit-block' }
MicDumper >> visitListItem: aListItem [

	| text |
	text := self classPrint: aListItem.
	text := text , ' "' , aListItem text , '"'.
	^ text
]

{ #category : #'visit-block' }
MicDumper >> visitMath: aMath [

	| text |
	text := (self classPrint: aMath) , String space.
	text := text , (self parametersPrint: aMath arguments asDictionary).
	text := text , ' "' , aMath body , '"'.
	^ text
]

{ #category : #'visit-inline block' }
MicDumper >> visitMathInline: aMicMathInline [

	^ self blockPrint: aMicMathInline
]

{ #category : #'visit-block' }
MicDumper >> visitMetaData: aMetaData [

	| text |
	text := self classPrint: aMetaData.
	text := text , ' parameters:' , aMetaData firstLine.
	text := text , ' "' , aMetaData body , '"'.
	^ text
]

{ #category : #'visit-inline block' }
MicDumper >> visitMonospace: aMicMonospace [

	^ self blockPrint: aMicMonospace
]

{ #category : #'visit-block' }
MicDumper >> visitOrderedList: aOrderedList [

	^ self classPrint: aOrderedList
]

{ #category : #'visit-block' }
MicDumper >> visitParagraph: aParagraph [

	^ self classPrint: aParagraph
]

{ #category : #'visit-block' }
MicDumper >> visitQuote: aQuote [

	| text |
	text := self classPrint: aQuote.
	text := text , ' "' , aQuote text , '"'.
	^ text
]

{ #category : #'visit-inline block' }
MicDumper >> visitRaw: aMicRaw [

	^ self blockPrint: aMicRaw
]

{ #category : #'visit-block' }
MicDumper >> visitRoot: aRoot [

	^ self classPrint: aRoot
]

{ #category : #'visit-inline block' }
MicDumper >> visitStrike: aMicStrike [

	^ self blockPrint: aMicStrike
]

{ #category : #'visit-block' }
MicDumper >> visitTable: aTable [

	^ self classPrint: aTable
]

{ #category : #'visit-inline block' }
MicDumper >> visitText: aMicText [

	^ self blockPrint: aMicText
]

{ #category : #'visit-block' }
MicDumper >> visitUnorderedList: aUnorderedList [

	^ self classPrint: aUnorderedList
]
