Class {
	#name : #MicLevelRomanPrinter,
	#superclass : #MicTitlePrinterSpecification,
	#category : #'Microdown - NewVisitor'
}

{ #category : #'rendering-element' }
MicLevelRomanPrinter >> renderElement: aNumber on: stream [
	stream nextPutAll: aNumber printStringRoman
]
