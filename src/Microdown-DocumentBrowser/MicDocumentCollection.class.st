"
I store a collection of normalized (sectioned) microdown documents as children.
I implement the accept: method to be able to host microdown visitors. 
"
Class {
	#name : #MicDocumentCollection,
	#superclass : #Object,
	#instVars : [
		'parent',
		'pathSegment',
		'children',
		'title'
	],
	#category : #'Microdown-DocumentBrowser-Model'
}

{ #category : #visiting }
MicDocumentCollection >> accept: aVisitor [
	"Just call the visitor on each of my children - in their collection order"
	"children ifNotNil: [ children do: [ :c | c accept: aVisitor  ] ]"
]

{ #category : #accessing }
MicDocumentCollection >> addChild: child [
	self children addLast: child
]

{ #category : #accessing }
MicDocumentCollection >> children [

	^ children ifNil: [ children := OrderedCollection new ]
]

{ #category : #accessing }
MicDocumentCollection >> children: aChildCollection [
	aChildCollection do: [ :child | child parent: self ].
]

{ #category : #printing }
MicDocumentCollection >> displayString [
	^ self title ifNil: 'I have no title...'
]

{ #category : #accessing }
MicDocumentCollection >> icon [
	^ self iconNamed: #book
]

{ #category : #printing }
MicDocumentCollection >> inspectionDocumentCollections [

	<inspectorPresentationOrder: 830 title: 'DocCollection'>
	^ SpTreePresenter new
		  roots: { self };
		  children: [ :docCol | docCol subLevels];
		  display: [ :docCol | docCol displayString ];
		  yourself
]

{ #category : #accessing }
MicDocumentCollection >> parent [

	^ parent
]

{ #category : #accessing }
MicDocumentCollection >> parent: col [
	parent := col.
	col addChild: self
]

{ #category : #accessing }
MicDocumentCollection >> pathSegment [

	^ pathSegment
]

{ #category : #accessing }
MicDocumentCollection >> pathSegment: anObject [

	pathSegment := anObject
]

{ #category : #accessing }
MicDocumentCollection >> provider [
	|col|
	col := self.
	[col parent isNil] whileFalse: [ col := col parent ].
	^col
]

{ #category : #displaying }
MicDocumentCollection >> subLevels [
	^ self children
]

{ #category : #accessing }
MicDocumentCollection >> title [
	^ title
]

{ #category : #accessing }
MicDocumentCollection >> title: anObject [

	title := anObject
]
