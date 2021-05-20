Class {
	#name : #MicPrettyPrinter,
	#superclass : #MicrodownVisitor,
	#category : #'Microdown-PrettyPrinter'
}

{ #category : #build }
MicPrettyPrinter >> blockPrint: aMicText [

	| text |
	text := self classPrint: aMicText.
	text := text , ' "' , aMicText substring , '"'.
	^ text
]

{ #category : #build }
MicPrettyPrinter >> classPrint: aMicFigure [

	^ aMicFigure class asString
]

{ #category : #build }
MicPrettyPrinter >> parametersPrint: aDictionnary [

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
MicPrettyPrinter >> visitAnchor: aAnchor [

	| text |
	text := self classPrint: aAnchor.
	text := text , ' "' , aAnchor label , '"'.
	^ text
]

{ #category : #'visit-inline block' }
MicPrettyPrinter >> visitAnchorReference: aMicAnchorReference [

	^ self blockPrint: aMicAnchorReference
]

{ #category : #'visit-block' }
MicPrettyPrinter >> visitAnnotated: aAnnotated [

	^ self classPrint: aAnnotated
]

{ #category : #'visit-inline block' }
MicPrettyPrinter >> visitAnnotation: aMicAnnotation [
	"arguments with parameters is nil like the name"
	"| text |
	text := aMicAnnotation class asString , String space.
	text := text , (self parametersPrint: aMicAnnotation parameters asDictionary).
	text := text , ' ""' , aMicAnnotation name , '""'."
	^ self blockPrint: aMicAnnotation
	
]

{ #category : #'visit-inline block' }
MicPrettyPrinter >> visitBold: aMicBold [

	^ self blockPrint: aMicBold
]

{ #category : #'visit-block' }
MicPrettyPrinter >> visitCode: aCode [

	| text |
	text := self classPrint: aCode.
	text := text , ' parameters:' , aCode firstLine.
	text := text , ' "' , aCode body , '"'.
	^ text
]

{ #category : #'visit-block' }
MicPrettyPrinter >> visitComment: aComment [

	| text |
	text := self classPrint: aComment.
	text := text , ' "' , aComment text , '"'.
	^ text
]

{ #category : #'visit-block' }
MicPrettyPrinter >> visitEnvironment: aEnvironment [

	| text |
	text := (self classPrint: aEnvironment) , String space.
	text := text , (self parametersPrint: aEnvironment arguments asDictionary).
	text := text , ' "' , aEnvironment name , '"'.
	^ text
]

{ #category : #'visit-inline block' }
MicPrettyPrinter >> visitFigure: aMicFigure [

	| text |
	text := (self classPrint: aMicFigure) , String space.
	text := text
	        , (self parametersPrint: aMicFigure parameters asDictionary).
	text := text , ' url:' , aMicFigure url asString.
	text := text , ' "' , aMicFigure substring , '"'.
	^ text
]

{ #category : #'visit-block' }
MicPrettyPrinter >> visitHeader: aHeader [

	| text |
	text := self classPrint: aHeader.
	text := text , ' level:' , aHeader level asString.
	text := text , ' "' , aHeader header , '"'.
	^ text
]

{ #category : #'visit-block' }
MicPrettyPrinter >> visitHorizontalLine: aHorizontalLine [

	^ self classPrint: aHorizontalLine
]

{ #category : #'visit-inline block' }
MicPrettyPrinter >> visitItalic: aMicItalic [

	^ self blockPrint: aMicItalic
]

{ #category : #'visit-inline block' }
MicPrettyPrinter >> visitLink: aMicLink [

	| text |
	text := self classPrint: aMicLink.
	text := text , ' url:' , aMicLink url asString , ' "'
	        , aMicLink substring , '"'.
	^ text
]

{ #category : #'visit-block' }
MicPrettyPrinter >> visitListItem: aListItem [

	| text |
	text := self classPrint: aListItem.
	text := text , ' "' , aListItem text , '"'.
	^ text
]

{ #category : #'visit-block' }
MicPrettyPrinter >> visitMath: aMath [

	| text |
	text := (self classPrint: aMath) , String space.
	text := text , (self parametersPrint: aMath arguments asDictionary).
	text := text , ' "' , aMath body , '"'.
	^ text
]

{ #category : #'visit-inline block' }
MicPrettyPrinter >> visitMathInline: aMicMathInline [

	^ self blockPrint: aMicMathInline
]

{ #category : #'visit-inline block' }
MicPrettyPrinter >> visitMonospace: aMicMonospace [

	^ self blockPrint: aMicMonospace
]

{ #category : #'visit-block' }
MicPrettyPrinter >> visitOrderedList: aOrderedList [

	^ self classPrint: aOrderedList
]

{ #category : #'visit-block' }
MicPrettyPrinter >> visitParagraph: aParagraph [

	^ self classPrint: aParagraph
]

{ #category : #'visit-block' }
MicPrettyPrinter >> visitQuote: aQuote [

	| text |
	text := self classPrint: aQuote.
	text := text , ' "' , aQuote text , '"'.
	^ text
]

{ #category : #'visit-inline block' }
MicPrettyPrinter >> visitRaw: aMicRaw [

	^ self blockPrint: aMicRaw
]

{ #category : #'visit-block' }
MicPrettyPrinter >> visitRoot: aRoot [

	^ self classPrint: aRoot
]

{ #category : #'visit-inline block' }
MicPrettyPrinter >> visitStrike: aMicStrike [

	^ self blockPrint: aMicStrike
]

{ #category : #'visit-block' }
MicPrettyPrinter >> visitTable: aTable [

	^ self classPrint: aTable
]

{ #category : #'visit-inline block' }
MicPrettyPrinter >> visitText: aMicText [

	^ self blockPrint: aMicText
]

{ #category : #'visit-block' }
MicPrettyPrinter >> visitUnorderedList: aUnorderedList [

	^ self classPrint: aUnorderedList
]
