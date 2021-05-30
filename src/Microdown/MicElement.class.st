Class {
	#name : #MicElement,
	#superclass : #Object,
	#category : #'Microdown-Model'
}

{ #category : #public }
MicElement >> inlineParse: aString [

	^ MicInlineParser new parse: aString

]
