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

{ #category : #'visiting main API' }
MicrodownVisitor >> visit: aMicElement [

	^ aMicElement accept: self
]

{ #category : #'visiting main API' }
MicrodownVisitor >> visitAll: aCollection [

	^ aCollection collect: [ :each | each accept: self ]
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

	^ self visitChildrenOf: aFormat.

]

{ #category : #'visiting - inline elements' }
MicrodownVisitor >> visitChildrenOf: anElement [

	^ anElement children collect: [ :each | each accept: self ]
]

{ #category : #'visiting - extensions' }
MicrodownVisitor >> visitCitation: aVisitor [
]

{ #category : #visiting }
MicrodownVisitor >> visitCode: aCodeBlock [ 
	 
	^ aCodeBlock captionElements collect: [ :each |each accept: self ]

]

{ #category : #visiting }
MicrodownVisitor >> visitColumn: aColumn [
	^ self visitEnvironment: aColumn
]

{ #category : #visiting }
MicrodownVisitor >> visitColumns: aColumns [
	^ self visitEnvironment: aColumns
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
MicrodownVisitor >> visitFootnote: aFootnote [
	"subclassResponsibility"
]

{ #category : #visiting }
MicrodownVisitor >> visitHeader: aHeader [

	^  aHeader headerElements do: [ :each | each accept: self ]
]

{ #category : #visiting }
MicrodownVisitor >> visitHorizontalLine: anHorizontalLineBlock [
]

{ #category : #visiting }
MicrodownVisitor >> visitInputFile: anInputfile [
	"subclassResponsibility"
]

{ #category : #'visiting - inline elements' }
MicrodownVisitor >> visitItalic: aFormat [

	^ self visitChildrenOf: aFormat.

]

{ #category : #'visiting - inline elements' }
MicrodownVisitor >> visitLink: aLink [

	^ aLink captionElements do: [:each | each accept: self ].

]

{ #category : #'visiting - list' }
MicrodownVisitor >> visitListItem: anItem [

	^ self visitChildrenOf: anItem
]

{ #category : #visiting }
MicrodownVisitor >> visitMath: aMicMath [

	^ aMicMath captionElements collect: [ :each | each accept: self ]

]

{ #category : #'visiting - inline elements' }
MicrodownVisitor >> visitMathInline: aMicMathInline [
]

{ #category : #visiting }
MicrodownVisitor >> visitMetaData: aMetaData [
]

{ #category : #'visiting - inline elements' }
MicrodownVisitor >> visitMonospace: aFormat [

	^ self visitChildrenOf: aFormat.

]

{ #category : #'visiting - list' }
MicrodownVisitor >> visitOrderedList: anOrderedList [

	^ anOrderedList children collect: [ :each | self visitOrderedListItem: each ]
]

{ #category : #'visiting - list' }
MicrodownVisitor >> visitOrderedListItem: anItem [

	^ self visitListItem: anItem
]

{ #category : #visiting }
MicrodownVisitor >> visitParagraph: aParagraph [
	
	^ self visitChildrenOf: aParagraph
]

{ #category : #visiting }
MicrodownVisitor >> visitQuote: aQuote [
	^ self visitChildrenOf: aQuote
]

{ #category : #'visiting - inline elements' }
MicrodownVisitor >> visitRaw: aRawFormat [

	
]

{ #category : #visiting }
MicrodownVisitor >> visitRoot: aRoot [

	^ self visitChildrenOf: aRoot
]

{ #category : #'visiting - extensions' }
MicrodownVisitor >> visitScript: aSlide [

	^ aSlide children collect: [ :each | self visit: each ]
]

{ #category : #'visiting - extensions' }
MicrodownVisitor >> visitSlide: aSlide [

	^ aSlide children collect: [ :each | self visit: each ]
]

{ #category : #'visiting - inline elements' }
MicrodownVisitor >> visitStrike: aFormat [

	^ self visitChildrenOf: aFormat.

]

{ #category : #visiting }
MicrodownVisitor >> visitTable: aTable [
	"subclassResponsibility"
]

{ #category : #'visiting - inline elements' }
MicrodownVisitor >> visitText: aMicTextBlock [

	"do nothing"
]

{ #category : #'visiting - list' }
MicrodownVisitor >> visitUnorderedList: anUnorderedList [

	^ anUnorderedList children collect: [ :each | self visitUnorderedListItem: each ]
]

{ #category : #'visiting - list' }
MicrodownVisitor >> visitUnorderedListItem: anUnorderedList [

	^ self visitListItem: anUnorderedList
	
]
