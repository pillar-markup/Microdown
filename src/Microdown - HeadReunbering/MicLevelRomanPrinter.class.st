Class {
	#name : #MicLevelRomanPrinter,
	#superclass : #MicTitlePrinterSpecification,
	#category : #'Microdown - HeadReunbering'
}

{ #category : #'rendering-element' }
MicLevelRomanPrinter >> renderElement: aNumber on: stream [
	stream nextPutAll: aNumber printStringRoman
]
