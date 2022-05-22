Class {
	#name : #MicDocumentWriter,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'canvas',
		'nbListTab',
		'writingRaw'
	],
	#category : #'Microdown-LaTeXExporter'
}

{ #category : #accessing }
MicDocumentWriter >> canvasClass [ 

	^ self subclassResponsibility 
]

{ #category : #writing }
MicDocumentWriter >> contents [

	^ canvas contents
]

{ #category : #initialization }
MicDocumentWriter >> crAsNewLine [

	canvas crAsNewLine
]

{ #category : #initialization }
MicDocumentWriter >> initialize [
	| stream |
	super initialize.
	stream := MicOutputStream new setStream: (WriteStream on: (String new: 1000)).
	canvas := self canvasClass on: stream.
	writingRaw := false.
	nbListTab := -1
]

{ #category : #initialization }
MicDocumentWriter >> lfAsNewLine [

	canvas lfAsNewLine
]

{ #category : #initialization }
MicDocumentWriter >> usedNewLine [
	"Return the encoded new line. Useful for tests."
	
	^ canvas stream usedNewLine
]

{ #category : #writing }
MicDocumentWriter >> visit: aMicElement [

	aMicElement accept: self.
	^ self contents
]

{ #category : #writing }
MicDocumentWriter >> write: aMicElement [
	"for now for integration with Pillar."
	self visit: aMicElement.
	^ self contents
]

{ #category : #writing }
MicDocumentWriter >> writeRawDuring: aBlock [

	[ 
	canvas writingRaw: true.
	aBlock value ]
		ensure: [ canvas writingRaw: false. ]
]
