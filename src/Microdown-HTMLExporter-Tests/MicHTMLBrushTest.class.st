"
A MicHTMLBrushTest is a test class for testing the behavior of MicHTMLBrush
"
Class {
	#name : 'MicHTMLBrushTest',
	#superclass : 'TestCase',
	#instVars : [
		'tag'
	],
	#category : 'Microdown-HTMLExporter-Tests-HTML',
	#package : 'Microdown-HTMLExporter-Tests',
	#tag : 'HTML'
}

{ #category : 'running' }
MicHTMLBrushTest >> setUp [

	super setUp.
	tag := MicHTMLTag new
		setStream: (MicOutputStream new setStream: (WriteStream on: (String new: 1000)));
		yourself.
]

{ #category : 'accessing' }
MicHTMLBrushTest >> tag [

	^ tag
]

{ #category : 'tests' }
MicHTMLBrushTest >> testName [

	tag name: 'prueba'.
	self assert: tag name equals: 'prueba'
]
