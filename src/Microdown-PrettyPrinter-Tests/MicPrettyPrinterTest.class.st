Class {
	#name : #MicPrettyPrinterTest,
	#superclass : #TestCase,
	#instVars : [
		'factory',
		'visitor'
	],
	#category : #'Microdown-PrettyPrinter-Tests'
}

{ #category : #accessing }
MicPrettyPrinterTest >> factory [ 
	^ factory
]

{ #category : #accessing }
MicPrettyPrinterTest >> factory: aFactory [
	factory := aFactory
]

{ #category : #running }
MicPrettyPrinterTest >> setUp [
	super setUp.
	factory := MicMicroDownSnippetFactory new.
	visitor := MicPrettyPrinter new
]

{ #category : #'tests-inline block' }
MicPrettyPrinterTest >> testPrintMicAnchorReferenceBlock [

]

{ #category : #'tests-inline block' }
MicPrettyPrinterTest >> testPrintMicAnnotationBlock [

]

{ #category : #'tests-inline block' }
MicPrettyPrinterTest >> testPrintMicBoldFormatBlock [

]

{ #category : #'tests-inline block' }
MicPrettyPrinterTest >> testPrintMicFigureBlock [

]

{ #category : #'tests-inline block' }
MicPrettyPrinterTest >> testPrintMicItalicFormatBlock [

]

{ #category : #'tests-inline block' }
MicPrettyPrinterTest >> testPrintMicLinkBlock [

]

{ #category : #'tests-inline block' }
MicPrettyPrinterTest >> testPrintMicMathInlineBlock [

]

{ #category : #'tests-inline block' }
MicPrettyPrinterTest >> testPrintMicMonospaceFormatBlock [

]

{ #category : #'tests-inline block' }
MicPrettyPrinterTest >> testPrintMicRawFormatBlock [

]

{ #category : #'tests-inline block' }
MicPrettyPrinterTest >> testPrintMicStrikeFormatBlock [

]

{ #category : #'tests-inline block' }
MicPrettyPrinterTest >> testPrintMicTextBlock [

]
