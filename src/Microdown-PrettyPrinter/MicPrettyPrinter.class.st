Class {
	#name : #MicPrettyPrinter,
	#superclass : #MicrodownVisitor,
	#category : #'Microdown-PrettyPrinter'
}

{ #category : #'inline block' }
MicPrettyPrinter >> blockPrint: aMicText [

	| text |
	text := aMicText class asString.
	text := text , ' "' , aMicText substring , '"'.
	^ text
]

{ #category : #'inline block' }
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

{ #category : #'inline block' }
MicPrettyPrinter >> visitAnchorReference: aMicAnchorReference [

	^ self blockPrint: aMicAnchorReference
]

{ #category : #'inline block' }
MicPrettyPrinter >> visitAnnotation: aMicAnnotation [
	| text |
	text := aMicAnnotation class asString , String space.
	text := text , self parametersPrint: aMicAnnotation parameters asDictionary.
	text := text , ' "' , aMicAnnotation name , '"'.
	^ text 
	
]

{ #category : #'inline block' }
MicPrettyPrinter >> visitBold: aMicBold [

	^ self blockPrint: aMicBold
]

{ #category : #'inline block' }
MicPrettyPrinter >> visitFigure: aMicFigure [
	| text |
	text := aMicFigure class asString , String space.
	text := text , (self parametersPrint: aMicFigure parameters asDictionary).
	text := text , ' url:' , aMicFigure url asString.
	text := text , ' "' , aMicFigure substring , '"'.
	^ text 
	
]

{ #category : #'inline block' }
MicPrettyPrinter >> visitItalic: aMicItalic [

	^ self blockPrint: aMicItalic
]

{ #category : #'inline block' }
MicPrettyPrinter >> visitLink: aMicLink [
	| text |
	text := aMicLink class asString.
	text := text, ' url:' , aMicLink url asString , ' "' , aMicLink substring , '"'.
	^ text
]

{ #category : #'inline block' }
MicPrettyPrinter >> visitMonospace: aMicMonospace [

	^ self blockPrint: aMicMonospace
]

{ #category : #'inline block' }
MicPrettyPrinter >> visitRaw: aMicRaw [

	^ self blockPrint: aMicRaw
]

{ #category : #'inline block' }
MicPrettyPrinter >> visitStrike: aMicStrike [

	^ self blockPrint: aMicStrike
]

{ #category : #'inline block' }
MicPrettyPrinter >> visitText: aMicText [

	^ self blockPrint: aMicText
]
