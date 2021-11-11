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

{ #category : #visiting }
MicHTMLWriter >> visitBold: aBoldText [

	canvas tag
		name: 'strong';
		with: [ super visitBold: aBoldText ]
]

{ #category : #visiting }
MicHTMLWriter >> visitHeader: aHeader [

	canvas newLine.	
	canvas tag 
		name: 'h',  aHeader level asString;
		with: aHeader header
	
]

{ #category : #visiting }
MicHTMLWriter >> visitItalic: aBoldText [

	canvas tag
		name: 'em';
		with: [ super visitItalic: aBoldText ]
]

{ #category : #visiting }
MicHTMLWriter >> visitMonospace: aMonospace [

	canvas tag
		name: 'code';
		with: [ super visitMonospace: aMonospace ]
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

	| restRows |
	canvas newLine.
	canvas tag
		name: 'table';
		with: [ 
			canvas newLine.
			aTable hasHeader
				ifTrue: [ 
					self writeTableHeaders: aTable rows first. 
					restRows := aTable rows allButFirst  ] 
				ifFalse: [ restRows := aTable rows ].
			self writeTableRows: restRows.
			 ]
]

{ #category : #visiting }
MicHTMLWriter >> visitText: aText [

	canvas nextPutAll: aText text
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

{ #category : #writing }
MicHTMLWriter >> writeTableHeaders: headers [
	canvas tag
		name: 'tr';
		with: [ headers do: [ :cell | canvas tag name: 'th'; with: [self visitAll: cell]] ].
	canvas newLine
		
]

{ #category : #writing }
MicHTMLWriter >> writeTableRows: rows [
	rows do: [ :row |
		canvas tag
			name: 'tr';
			with: [ row do: [ :cell | canvas tag name: 'td'; with: [self visitAll: cell]] ].
		canvas newLine]
		
]
