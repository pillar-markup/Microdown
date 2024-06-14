Class {
	#name : 'MicLevelRomanPrinter',
	#superclass : 'MicTitlePrinterSpecification',
	#category : 'Microdown-RenderingFeatures',
	#package : 'Microdown-RenderingFeatures'
}

{ #category : 'rendering-element' }
MicLevelRomanPrinter >> renderElement: aNumber on: stream [
	stream nextPutAll: aNumber printStringRoman
]
