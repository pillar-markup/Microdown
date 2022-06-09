"
A MicHTMLCanvasTest is a test class for testing the behavior of MicHTMLCanvas
"
Class {
	#name : #MicHTMLCanvasTest,
	#superclass : #TestCase,
	#instVars : [
		'canvas'
	],
	#category : #'Microdown-HTMLExporter-Tests'
}

{ #category : #running }
MicHTMLCanvasTest >> setUp [

	super setUp.
	canvas := MicHTMLCanvas on: (MicOutputStream new setStream: (WriteStream on: (String new: 1000))).

]

{ #category : #tests }
MicHTMLCanvasTest >> testTag [
	
	self assert: (canvas tag isKindOf: MicHTMLTag)
]
