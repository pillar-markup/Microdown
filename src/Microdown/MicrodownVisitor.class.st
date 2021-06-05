"
I'm an abstract visitor for Microdown document three. 
By default I visit only the nodes of the domain: it means that I will not visit the label of an annotated paragraph 
or the parameters of an annotation or the URL of a figure because such elements are not represented by subclasses 
of MicElement.

"
Class {
	#name : #MicrodownVisitor,
	#superclass : #Object,
	#category : #'Microdown-Visitor'
}

{ #category : #'visiting - inline elements' }
MicrodownVisitor >> fixBlockWithoutMicText: anInlineBlock [
	"I'm a hack because formatBloc so far do not wrap a MicTextBlock but a plain string"
	
	^ self subclassResponsibility
]

{ #category : #'visiting main API' }
MicrodownVisitor >> visit: aMicElement [

	^ aMicElement accept: self
]

{ #category : #visiting }
MicrodownVisitor >> visitAnchor: anAnchor [
]

{ #category : #'visiting - inline elements' }
MicrodownVisitor >> visitAnchorReference: anAnchorReference [
]

{ #category : #visiting }
MicrodownVisitor >> visitAnnotated: anAnnotated [

	^ anAnnotated body do: [ :each | each accept: self ]
]

{ #category : #'visiting - inline elements' }
MicrodownVisitor >> visitAnnotation: anAnnotation [
]

{ #category : #'visiting - inline elements' }
MicrodownVisitor >> visitBold: aFormat [

	aFormat children do: [ :each | each accept: self ].
	self fixBlockWithoutMicText: aFormat
]

{ #category : #visiting }
MicrodownVisitor >> visitCode: aCodeBlock [ 
	 
	^ aCodeBlock captionElements do: [ :each |each accept: self ]

]

{ #category : #visiting }
MicrodownVisitor >> visitComment: aComment [
]

{ #category : #visiting }
MicrodownVisitor >> visitEnvironment: anEnvironment [

	^ anEnvironment bodyElements do: [ :each | each accept: self ]
]

{ #category : #'visiting - inline elements' }
MicrodownVisitor >> visitFigure: aFigure [
	
	^ aFigure captionElements do: [:each | each accept: self ]
		
]

{ #category : #visiting }
MicrodownVisitor >> visitHeader: aHeader [

	^  aHeader headerElements do: [ :each | each accept: self ]
]

{ #category : #visiting }
MicrodownVisitor >> visitHorizontalLine: anHorizontalLineBlock [
]

{ #category : #'visiting - inline elements' }
MicrodownVisitor >> visitItalic: aFormat [

	aFormat children do: [ :each | each accept: self ].
	self fixBlockWithoutMicText: aFormat
]

{ #category : #'visiting - inline elements' }
MicrodownVisitor >> visitLink: aLink [

	aLink children do: [ :each | each accept: self ].
	self fixBlockWithoutMicText: aLink
]

{ #category : #visiting }
MicrodownVisitor >> visitListItem: anItem [

	^ anItem textElements do: [ :each |each accept: self ]
]

{ #category : #visiting }
MicrodownVisitor >> visitMath: aMicMath [

	aMicMath captionElements do: [ :each |each accept: self ]

]

{ #category : #'visiting - inline elements' }
MicrodownVisitor >> visitMathInline: aMicMathInline [
]

{ #category : #visiting }
MicrodownVisitor >> visitMetaData: aMetaData [
]

{ #category : #'visiting - inline elements' }
MicrodownVisitor >> visitMonospace: aFormat [

	aFormat children do: [ :each | each accept: self ].
	self fixBlockWithoutMicText: aFormat
]

{ #category : #visiting }
MicrodownVisitor >> visitOrderedList: anOrderedList [

	^ anOrderedList children do: [ :each | self visitOrderedListItem: each ]
]

{ #category : #visiting }
MicrodownVisitor >> visitOrderedListItem: anItem [

	^ anItem textElements do: [ :each | each accept: self ] 
]

{ #category : #visiting }
MicrodownVisitor >> visitParagraph: aParagraph [
	^ aParagraph children do: [:each | each accept: self ]
]

{ #category : #visiting }
MicrodownVisitor >> visitQuote: aQuote [

]

{ #category : #'visiting - inline elements' }
MicrodownVisitor >> visitRaw: aRawFormat [

	
]

{ #category : #visiting }
MicrodownVisitor >> visitRoot: aRoot [

	^ aRoot children do: [ :each | each accept: self ]
]

{ #category : #'visiting - inline elements' }
MicrodownVisitor >> visitStrike: aFormat [

	aFormat children do: [ :each | each accept: self ].
	self fixBlockWithoutMicText: aFormat
]

{ #category : #'visiting - inline elements' }
MicrodownVisitor >> visitText: aMicTextBlock [
]

{ #category : #'visiting - inline elements' }
MicrodownVisitor >> visitUnorderedList: aUnorderedList [

	^ aUnorderedList children do: [ :each | each accept: self ]
]
