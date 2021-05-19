Class {
	#name : #MicPrettyPrinter,
	#superclass : #MicrodownVisitor,
	#category : #'Microdown-PrettyPrinter'
}

{ #category : #'inline block' }
MicPrettyPrinter >> visitText: aMicText [
	| text |
	text := aMicText class asString.
	text := text, ' "' , aMicText substring , '"'.
	^ text

]
