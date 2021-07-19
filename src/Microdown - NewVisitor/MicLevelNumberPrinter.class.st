Class {
	#name : #MicLevelNumberPrinter,
	#superclass : #MicTitlePrinterSpecification,
	#category : #'Microdown - NewVisitor'
}

{ #category : #'rendering-element' }
MicLevelNumberPrinter >> renderElement: aNumber on: stream [
	aNumber printOn: stream
]
