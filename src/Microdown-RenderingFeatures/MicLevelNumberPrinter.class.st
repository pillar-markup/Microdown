Class {
	#name : #MicLevelNumberPrinter,
	#superclass : #MicTitlePrinterSpecification,
	#category : #'Microdown-RenderingFeatures'
}

{ #category : #'rendering-element' }
MicLevelNumberPrinter >> renderElement: aNumber on: stream [
	aNumber printOn: stream
]
