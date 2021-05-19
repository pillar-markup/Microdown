Class {
	#name : #MicPrettyPrinterTest,
	#superclass : #TestCase,
	#instVars : [
		'factory'
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
	factory := MicMicroDownSnippetFactory new
]
