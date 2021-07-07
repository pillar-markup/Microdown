Class {
	#name : #MicLevelNumberPrinter,
	#superclass : #MicTitlePrinterSpecification,
	#category : #'Microdown - HeadReunbering'
}

{ #category : #'rendering-element' }
MicLevelNumberPrinter >> renderElement: aNumber on: stream [
	aNumber printOn: stream
]
