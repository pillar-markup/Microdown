Class {
	#name : #MicPrettyPrinter,
	#superclass : #MicrodownVisitor,
	#category : #'Microdown-PrettyPrinter'
}

{ #category : #'inline block' }
MicPrettyPrinter >> visitBold: aMicBold [
	| text |
	text := aMicBold class asString.
	text := text, ' "' , aMicBold substring , '"'.
	^ text

]

{ #category : #'inline block' }
MicPrettyPrinter >> visitItalic: aMicItalic [
	| text |
	text := aMicItalic class asString.
	text := text, ' "' , aMicItalic substring , '"'.
	^ text

]

{ #category : #'inline block' }
MicPrettyPrinter >> visitText: aMicText [
	| text |
	text := aMicText class asString.
	text := text, ' "' , aMicText substring , '"'.
	^ text

]
