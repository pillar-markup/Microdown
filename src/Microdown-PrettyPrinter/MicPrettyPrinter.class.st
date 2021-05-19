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
MicPrettyPrinter >> visitBold: aMicBold [

	^ self blockPrint: aMicBold
]

{ #category : #'inline block' }
MicPrettyPrinter >> visitItalic: aMicItalic [

	^ self blockPrint: aMicItalic
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
