Class {
	#name : #MicDullDumper,
	#superclass : #MicrodownVisitor,
	#category : #'Microdown-PrettyPrinter'
}

{ #category : #build }
MicDullDumper >> blockPrint: aMicText [

	| text |
	text := self classPrint: aMicText.
	text := text , ' "' , aMicText substring , '"'.
	^ text
]

{ #category : #build }
MicDullDumper >> classPrint: aMicFigure [

	^ aMicFigure class asString
]

{ #category : #initialization }
MicDullDumper >> initialize [ 
	super initialize
]

{ #category : #build }
MicDullDumper >> parametersPrint: aDictionnary [

	| text lastKey |
	lastKey := aDictionnary keys.
	text := 'parameters:'.
	aDictionnary keysAndValuesDo: [ :k :v |
		text := text , k ,'=', v.
		k = lastKey 
			ifFalse: [ 
				text := text , '&' ]].
	^ text
]

{ #category : #'visit-block' }
MicDullDumper >> visitAnchor: aAnchor [

	| text |
	text := self classPrint: aAnchor.
	text := text , ' "' , aAnchor label , '"'.
	^ text
]

{ #category : #'visit-inline block' }
MicDullDumper >> visitAnchorReference: aMicAnchorReference [

	^ self blockPrint: aMicAnchorReference
]

{ #category : #'visit-block' }
MicDullDumper >> visitAnnotated: aAnnotated [

	^ self classPrint: aAnnotated
]

{ #category : #'visit-inline block' }
MicDullDumper >> visitAnnotation: aMicAnnotation [
	"arguments with parameters is nil like the name"
	"| text |
	text := aMicAnnotation class asString , String space.
	text := text , (self parametersPrint: aMicAnnotation parameters asDictionary).
	text := text , ' ""' , aMicAnnotation name , '""'."
	^ self blockPrint: aMicAnnotation
	
]

{ #category : #'visit-inline block' }
MicDullDumper >> visitBold: aMicBold [

	^ self blockPrint: aMicBold
]

{ #category : #'visit-block' }
MicDullDumper >> visitCode: aCode [

	| text |
	text := self classPrint: aCode.
	text := text , ' parameters:' , aCode firstLine.
	text := text , ' "' , aCode body , '"'.
	^ text
]

{ #category : #'visit-block' }
MicDullDumper >> visitComment: aComment [

	| text |
	text := self classPrint: aComment.
	text := text , ' "' , aComment text , '"'.
	^ text
]

{ #category : #'visit-block' }
MicDullDumper >> visitEnvironment: aEnvironment [

	| text |
	text := (self classPrint: aEnvironment) , String space.
	text := text , (self parametersPrint: aEnvironment arguments asDictionary).
	text := text , ' "' , aEnvironment name , '"'.
	^ text
]

{ #category : #'visit-inline block' }
MicDullDumper >> visitFigure: aMicFigure [

	| text |
	text := (self classPrint: aMicFigure) , String space.
	text := text
	        , (self parametersPrint: aMicFigure arguments asDictionary).
	text := text , ' url:' , aMicFigure url asString.
	text := text , ' "' , aMicFigure substring , '"'.
	^ text
]

{ #category : #'visit-block' }
MicDullDumper >> visitHeader: aHeader [

	| text |
	text := self classPrint: aHeader.
	text := text , ' level:' , aHeader level asString.
	text := text , ' "' , aHeader header , '"'.
	^ text
]

{ #category : #'visit-block' }
MicDullDumper >> visitHorizontalLine: aHorizontalLine [

	^ self classPrint: aHorizontalLine
]

{ #category : #'visit-inline block' }
MicDullDumper >> visitItalic: aMicItalic [

	^ self blockPrint: aMicItalic
]

{ #category : #'visit-inline block' }
MicDullDumper >> visitLink: aMicLink [

	| text |
	text := self classPrint: aMicLink.
	text := text , ' url:' , aMicLink url asString , ' "'
	        , aMicLink substring , '"'.
	^ text
]

{ #category : #'visit-block' }
MicDullDumper >> visitListItem: aListItem [

	| text |
	text := self classPrint: aListItem.
	text := text , ' "' , aListItem text , '"'.
	^ text
]

{ #category : #'visit-block' }
MicDullDumper >> visitMath: aMath [

	| text |
	text := (self classPrint: aMath) , String space.
	text := text , (self parametersPrint: aMath arguments asDictionary).
	text := text , ' "' , aMath body , '"'.
	^ text
]

{ #category : #'visit-inline block' }
MicDullDumper >> visitMathInline: aMicMathInline [

	^ self blockPrint: aMicMathInline
]

{ #category : #'visit-block' }
MicDullDumper >> visitMetaData: aMetaData [

	| text |
	text := self classPrint: aMetaData.
	text := text , ' parameters:' , aMetaData firstLine.
	text := text , ' "' , aMetaData body , '"'.
	^ text
]

{ #category : #'visit-inline block' }
MicDullDumper >> visitMonospace: aMicMonospace [

	^ self blockPrint: aMicMonospace
]

{ #category : #'visit-block' }
MicDullDumper >> visitOrderedList: aOrderedList [

	^ self classPrint: aOrderedList
]

{ #category : #'visit-block' }
MicDullDumper >> visitParagraph: aParagraph [

	^ self classPrint: aParagraph
]

{ #category : #'visit-block' }
MicDullDumper >> visitQuote: aQuote [

	| text |
	text := self classPrint: aQuote.
	text := text , ' "' , aQuote text , '"'.
	^ text
]

{ #category : #'visit-inline block' }
MicDullDumper >> visitRaw: aMicRaw [

	^ self blockPrint: aMicRaw
]

{ #category : #'visit-block' }
MicDullDumper >> visitRoot: aRoot [

	^ self classPrint: aRoot
]

{ #category : #'visit-inline block' }
MicDullDumper >> visitStrike: aMicStrike [

	^ self blockPrint: aMicStrike
]

{ #category : #'visit-block' }
MicDullDumper >> visitTable: aTable [

	^ self classPrint: aTable
]

{ #category : #'visit-inline block' }
MicDullDumper >> visitText: aMicText [

	^ self blockPrint: aMicText
]

{ #category : #'visit-block' }
MicDullDumper >> visitUnorderedList: aUnorderedList [

	^ self classPrint: aUnorderedList
]
