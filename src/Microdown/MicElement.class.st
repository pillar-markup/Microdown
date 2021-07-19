Class {
	#name : #MicElement,
	#superclass : #Object,
	#category : #'Microdown-Model'
}

{ #category : #public }
MicElement >> inlineParse: aString [
	| inlineParser |
	inlineParser := MicInlineParser new.
	inlineParser currentSystem: self parser currentSystem.
	^  inlineParser parse: aString

]
