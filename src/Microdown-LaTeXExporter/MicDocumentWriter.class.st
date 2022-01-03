Class {
	#name : #MicDocumentWriter,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'canvas',
		'stream',
		'nbListTab',
		'writingRaw'
	],
	#category : #'Microdown-LaTeXExporter'
}

{ #category : #accessing }
MicDocumentWriter >> canvasClass [ 

	^ self subclassResponsibility 
]

{ #category : #initialization }
MicDocumentWriter >> initialize [ 
	super initialize.
	stream := MicOutputStream new setStream: (WriteStream on: (String new: 1000)).
	canvas := self canvasClass on: stream.
	writingRaw := false.
	nbListTab := -1
]

{ #category : #initialization }
MicDocumentWriter >> usedNewLine [
	"Return the encoded new line. Useful for tests."
	
	^ stream usedNewLine
]
