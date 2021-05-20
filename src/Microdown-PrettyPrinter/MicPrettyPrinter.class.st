Class {
	#name : #MicPrettyPrinter,
	#superclass : #MicrodownVisitor,
	#category : #'Microdown-PrettyPrinter'
}

{ #category : #build }
MicPrettyPrinter >> blockPrint: aMicText [

	| text |
	text := aMicText class asString.
	text := text , ' "' , aMicText substring , '"'.
	^ text
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
	text := aAnchor class asString.
	text := text , ' "' , aAnchor label , '"'.
	^ text
]

{ #category : #'visit-inline block' }
MicPrettyPrinter >> visitAnchorReference: aMicAnchorReference [

	^ self blockPrint: aMicAnchorReference
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
	text := aCode class asString.
	text := text , ' parameters:' , aCode firstLine. 
	text := text , ' "' , aCode body , '"'.
	^ text
]

{ #category : #'visit-block' }
MicPrettyPrinter >> visitComment: aComment [
	| text |
	text := aComment class asString.
	text := text , ' "' , aComment text , '"'.
	^ text
]

{ #category : #'visit-inline block' }
MicPrettyPrinter >> visitFigure: aMicFigure [
	| text |
	text := aMicFigure class asString , String space.
	text := text , (self parametersPrint: aMicFigure parameters asDictionary).
	text := text , ' url:' , aMicFigure url asString.
	text := text , ' "' , aMicFigure substring , '"'.
	^ text 
	
]

{ #category : #'visit-block' }
MicPrettyPrinter >> visitHeader: aHeader [
	| text |
	text := aHeader class asString.
	text := text , ' level:' , (aHeader level asString).
	text := text , ' "' , aHeader header , '"'.
	^ text
]

{ #category : #'visit-block' }
MicPrettyPrinter >> visitHorizontalLine: aHorizontalLine [
	^ aHorizontalLine class asString
]

{ #category : #'visit-inline block' }
MicPrettyPrinter >> visitItalic: aMicItalic [

	^ self blockPrint: aMicItalic
]

{ #category : #'visit-inline block' }
MicPrettyPrinter >> visitLink: aMicLink [
	| text |
	text := aMicLink class asString.
	text := text, ' url:' , aMicLink url asString , ' "' , aMicLink substring , '"'.
	^ text
]

{ #category : #'visit-block' }
MicPrettyPrinter >> visitListItem: aListItem [
	| text |
	text := aListItem class asString.
	text := text , ' "' , aListItem text , '"'.
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
	^ aOrderedList class asString
]

{ #category : #'visit-block' }
MicPrettyPrinter >> visitParagraph: aParagraph [
	^ aParagraph class asString
]

{ #category : #'visit-block' }
MicPrettyPrinter >> visitQuote: aQuote [
	| text |
	text := aQuote class asString.
	text := text , ' "' , aQuote text , '"'.
	^ text
]

{ #category : #'visit-inline block' }
MicPrettyPrinter >> visitRaw: aMicRaw [

	^ self blockPrint: aMicRaw
]

{ #category : #'visit-block' }
MicPrettyPrinter >> visitRoot: aRoot [
	^ aRoot class asString
]

{ #category : #'visit-inline block' }
MicPrettyPrinter >> visitStrike: aMicStrike [

	^ self blockPrint: aMicStrike
]

{ #category : #'visit-block' }
MicPrettyPrinter >> visitTable: aTable [
	^ aTable class asString
]

{ #category : #'visit-inline block' }
MicPrettyPrinter >> visitText: aMicText [

	^ self blockPrint: aMicText
]

{ #category : #'visit-block' }
MicPrettyPrinter >> visitUnorderedList: aUnorderedList [
	^ aUnorderedList class asString
]
