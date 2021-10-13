Class {
	#name : #MicHTMLWriter,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'stream',
		'canvas'
	],
	#category : #'Microdown-HTMLExporter'
}

{ #category : #initialization }
MicHTMLWriter >> canvasClass [

	^ MicHTMLCanvas
]

{ #category : #accessing }
MicHTMLWriter >> contents [ 
	^ stream contents
]

{ #category : #initialization }
MicHTMLWriter >> initialize [ 
	super initialize.
	stream := MicOutputStream new setStream: (WriteStream on: (String new: 1000)).
	canvas := self canvasClass on: stream.
	
]

{ #category : #initialization }
MicHTMLWriter >> usedNewLine [
	"Return the encoded new line. Useful for tests."
	
	^ stream usedNewLine
]

{ #category : #visiting }
MicHTMLWriter >> visitHeader: aHeader [

	canvas newLine.	
	canvas tag 
		name: 'h',  aHeader level asString;
		with: aHeader header
	
]

{ #category : #visiting }
MicHTMLWriter >> visitParagraph: aParagraph [

	canvas newLine.
	canvas tag
				name: 'p';
				with: [ super visitParagraph: aParagraph ]
]

{ #category : #visiting }
MicHTMLWriter >> visitText: aText [

	stream nextPutAll: aText text
]

{ #category : #visiting }
MicHTMLWriter >> visitUnorderedList: anUnorderedList [

	canvas newLine.
	canvas tag
		name: 'ul';
		with: [ canvas newLine. super visitUnorderedList: anUnorderedList  ]
]

{ #category : #visiting }
MicHTMLWriter >> visitUnorderedListItem: anUnorderedListItem [
	"will not work with we have text decorators such as bold, italic, monospace"
	
	canvas tag
		name: 'li';
		with: anUnorderedListItem text.
	canvas newLine
]
