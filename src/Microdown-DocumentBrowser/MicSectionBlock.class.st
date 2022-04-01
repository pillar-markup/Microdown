"
A section at level N, is made up of:
- a `header` at level N
- a `preamble` containing all blocks uptil the the next header
- `subsections` containing all sections of level N+1 uptil the next section at level N or less.
"
Class {
	#name : #MicSectionBlock,
	#superclass : #MicAbstractBlock,
	#instVars : [
		'header',
		'preamble',
		'subsections',
		'documentUrl'
	],
	#category : #'Microdown-DocumentBrowser-Model'
}

{ #category : #'instance creation' }
MicSectionBlock class >> fromRoot: document [
	^ self fromRoot: document header: 'Document root header'
]

{ #category : #'instance creation' }
MicSectionBlock class >> fromRoot: document header: header [
	| newSection |
	newSection := self new
		header: ((Microdown parse: '# ', header) children first level: 0);
		from: document children readStream.
	"If the document used header level 1 as title (ie it was the only level 1 header), 
	do not introduce an intermediate level"
	^ newSection preamble children isEmpty & (newSection subsections children size = 1)
		ifTrue: [ newSection subsections children first ]
		ifFalse: [ newSection ]
]

{ #category : #visiting }
MicSectionBlock >> accept: aVisitor [
	self children do: [ :node | node accept: aVisitor  ]
]

{ #category : #public }
MicSectionBlock >> addLineAndReturnNextNode: line [
	"I am not supposed to be generated during parsing, and this method should not be called on me"
	self shouldNotImplement
]

{ #category : #public }
MicSectionBlock >> canConsumeLine: line [
	"I am not supposed to be generated during parsing, and this method should not be called on me"
	self shouldNotImplement
]

{ #category : #accessing }
MicSectionBlock >> children [
	^ { self header. self preamble. self subsections  }
]

{ #category : #displaying }
MicSectionBlock >> displayString [
		^ (Microdown asRichText: self header) asString trim
]

{ #category : #accessing }
MicSectionBlock >> documentUrl [

	^ documentUrl
]

{ #category : #accessing }
MicSectionBlock >> documentUrl: anObject [

	documentUrl := anObject
]

{ #category : #'instance creation' }
MicSectionBlock >> from: nodeStream [
	"collect preamble"
	[ nodeStream atEnd not and:[ nodeStream peek isHeader not ]]
		whileTrue: [ nodeStream next parent: self preamble  ].
	"collect subsections"
	[ nodeStream atEnd not and:[ nodeStream peek isHeader  ]]
		whileTrue: [ 
			(nodeStream peek level > self header level)
				ifTrue: [
					(self class new 
							header: nodeStream next;
							from: nodeStream) 
						parent: self subsections  ]
				ifFalse: [ ^ self ]
		].
	^self
		
		 
]

{ #category : #accessing }
MicSectionBlock >> header [
	header ifNil: [ header := Microdown parse: '# Document root header' ].
	^ header
]

{ #category : #accessing }
MicSectionBlock >> header: headerBlock [
	header := headerBlock.
	header parent: self
]

{ #category : #accessing }
MicSectionBlock >> icon [
	^ self subLevels 
		ifEmpty: [ (self iconNamed: #smallBarcode ) flipHorizontally rotateBy: 90  ]
		ifNotEmpty: [ self iconNamed: #page ]
]

{ #category : #initialization }
MicSectionBlock >> initialize [
	super initialize.
	preamble := MicIntermediateBlock new parent: self; yourself.
	subsections := MicIntermediateBlock new parent: self; yourself.
]

{ #category : #displaying }
MicSectionBlock >> inspectionSection [

	<inspectorPresentationOrder: 830 title: 'Sections'>
	^ SpTreePresenter new
		  roots: { self };
		  children: [ :aNode | aNode subsections children];
		  display: [ :aNode | aNode displayString ];
		  yourself
]

{ #category : #displaying }
MicSectionBlock >> inspectionSectionRendered [

	<inspectorPresentationOrder: 850 title: 'Rendered'>
	^ MicrodownPresenter new document: self;yourself
]

{ #category : #accessing }
MicSectionBlock >> isRootSection [ 
	^ self parent isKindOf: MicDocumentCollection
]

{ #category : #accessing }
MicSectionBlock >> preamble [
	^ preamble
]

{ #category : #accessing }
MicSectionBlock >> preamble: anObject [

	preamble := anObject
]

{ #category : #accessing }
MicSectionBlock >> provider [
	^ self rootSection parent provider
]

{ #category : #accessing }
MicSectionBlock >> rootSection [
	|sec|
	sec := self.
	[sec isRootSection] 
		whileFalse: [ sec := sec parent ].
	^sec
]

{ #category : #testing }
MicSectionBlock >> save [
	self provider saveSection: self.
]

{ #category : #displaying }
MicSectionBlock >> subLevels [
	^ self subsections children 
]

{ #category : #accessing }
MicSectionBlock >> subsections [
	^ subsections
]

{ #category : #accessing }
MicSectionBlock >> subsections: anObject [

	subsections := anObject
]

{ #category : #displaying }
MicSectionBlock >> title [
	^ self displayString 
]
