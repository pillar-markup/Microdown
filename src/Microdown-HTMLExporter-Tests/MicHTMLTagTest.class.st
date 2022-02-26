"
A MicHTMLTagTest is a test class for testing the behavior of MicHTMLTag
"
Class {
	#name : #MicHTMLTagTest,
	#superclass : #TestCase,
	#instVars : [
		'tag'
	],
	#category : #'Microdown-HTMLExporter-Tests'
}

{ #category : #test }
MicHTMLTagTest >> sampleMicFigureBlock [

	^ MicFigureBlock new 
		argumentAt: 'label' put: 'sampleClass';
		argumentAt: 'size' put: '30';
		yourself.
]

{ #category : #test }
MicHTMLTagTest >> setUp [

	super setUp.
	tag := MicHTMLTag new
		setStream: (MicOutputStream new setStream: (WriteStream on: (String new: 1000)));
		yourself.
]

{ #category : #accessing }
MicHTMLTagTest >> tag [

	^ tag
]

{ #category : #test }
MicHTMLTagTest >> testAddArguments [

	self tag addArguments: self sampleMicFigureBlock.
	self 
		assertCollection: ((self tag contents findTokens: '=') collect: #trimBoth)
		hasSameElements: #('class' '"sampleClass" width' '"30"').

]
