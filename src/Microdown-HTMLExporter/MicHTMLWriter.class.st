Class {
	#name : #MicHTMLWriter,
	#superclass : #MicrodownVisitor,
	#instVars : [
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
	^ canvas contents
]

{ #category : #initialization }
MicHTMLWriter >> exportImgFor: aFigure [

	| img |
	img := canvas emptyTag
		       name: 'img';
		       parameterAt: 'src' put: aFigure localFileOrExternalReference;
		       yourself.
	aFigure arguments
		at: 'width'
		ifPresent: [ :width | 
		img parameterAt: 'width' put: width asString , '%' ].
	img closeTag
]

{ #category : #initialization }
MicHTMLWriter >> initialize [ 
	| stream |
	super initialize.
	stream := MicOutputStream new setStream: (WriteStream on: (String new: 1000)).
	canvas := self canvasClass on: stream.
	
]

{ #category : #initialization }
MicHTMLWriter >> usedNewLine [
	"Return the encoded new line. Useful for tests."
	
	^ canvas stream usedNewLine
]

{ #category : #'visiting - formats' }
MicHTMLWriter >> visitBold: aBoldText [

	canvas tag
		name: 'strong';
		with: [ super visitBold: aBoldText ]
]

{ #category : #visiting }
MicHTMLWriter >> visitComment: aComment [
	canvas tag
		name: '!';
		with: [ 
					super visitComment: aComment ]
]

{ #category : #visiting }
MicHTMLWriter >> visitFigure: aFigure [

	self exportImgFor: aFigure.
]

{ #category : #visiting }
MicHTMLWriter >> visitHeader: aHeader [

	canvas newLine.	
	canvas tag 
		name: 'h',  aHeader level asString;
		with: aHeader header
	
]

{ #category : #'visiting - formats' }
MicHTMLWriter >> visitItalic: aBoldText [

	canvas tag
		name: 'em';
		with: [ super visitItalic: aBoldText ]
]

{ #category : #visiting }
MicHTMLWriter >> visitLink: aLink [
	canvas tag
		name: 'a';
		parameterAt: 'href' put: aLink localFileOrExternalReference
]

{ #category : #'visiting - list' }
MicHTMLWriter >> visitListItem: aList [

	canvas newLine.
	canvas tag
		name: 'li';
		with: [ super visitListItem: aList ].
	canvas newLine
]

{ #category : #'visiting - formats' }
MicHTMLWriter >> visitMonospace: aMonospace [

	canvas tag
		name: 'code';
		with: [ super visitMonospace: aMonospace ]
]

{ #category : #'visiting - list' }
MicHTMLWriter >> visitOrderedList: aList [

	canvas newLine.
	canvas newLine.
	canvas tag
		name: 'ol';
		with: [ super visitOrderedList: aList ]
]

{ #category : #visiting }
MicHTMLWriter >> visitParagraph: aParagraph [

	canvas newLine.
	canvas tag
				name: 'p';
				with: [ super visitParagraph: aParagraph ]
]

{ #category : #'visiting - list' }
MicHTMLWriter >> visitStrike: aStrike [

	canvas tag
		name: 'strike';
		with: [ super visitStrike: aStrike ]
]

{ #category : #visiting }
MicHTMLWriter >> visitTable: aTable [

	canvas newLine.
	canvas tag
		name: 'table';
		with: [ super visitTable: aTable ]
]

{ #category : #'visiting - formats' }
MicHTMLWriter >> visitText: aText [

	canvas nextPutAll: aText text
]

{ #category : #'visiting - list' }
MicHTMLWriter >> visitUnorderedList: anUnorderedList [

	canvas newLine.
	canvas tag
		name: 'ul';
		with: [ 
			super visitUnorderedList: anUnorderedList ]
]
