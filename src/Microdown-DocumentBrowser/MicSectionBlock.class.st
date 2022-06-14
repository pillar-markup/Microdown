"
A section at level N, is made up of:
- a `header` at level N
- a `body` containing all blocks uptil the the next header
- `subsections` containing all sections of level N+1 uptil the next section at level N or less.

I am made from a rootblock.
In the general case, the top section has no header and is considered level 0. All the level one headers (with only one `#`) will then be in the `subsections` of this top section.

If the document has a single level 1 header as the first element in the rootblock, then that header become the header of the top section, and no level 0 section is created.

"
Class {
	#name : #MicSectionBlock,
	#superclass : #MicAbstractBlock,
	#instVars : [
		'header',
		'subsections',
		'body'
	],
	#category : #'Microdown-DocumentBrowser-BlockModel'
}

{ #category : #'instance creation' }
MicSectionBlock class >> fromRoot: document [
	^ self fromRoot: document header: 'Document root header'
]

{ #category : #'instance creation' }
MicSectionBlock class >> fromRoot: document header: header [
	| newSection |
	newSection := self new
		from: document children readStream.
	"If the document used header level 1 as title (ie it was the only level 1 header), 
	do not introduce an intermediate level"
	^ newSection body children isEmpty & (newSection subsections children size = 1)
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

{ #category : #accessing }
MicSectionBlock >> body [
	^ body
]

{ #category : #accessing }
MicSectionBlock >> body: anObject [

	body := anObject
]

{ #category : #public }
MicSectionBlock >> canConsumeLine: line [
	"I am not supposed to be generated during parsing, and this method should not be called on me"
	self shouldNotImplement
]

{ #category : #accessing }
MicSectionBlock >> children [
	^ { self header. self body. self subsections  }
]

{ #category : #displaying }
MicSectionBlock >> displayString [
	header ifNil: [ ^'Root section' ].
	^ (Microdown asRichText: self header) asString trim
]

{ #category : #'instance creation' }
MicSectionBlock >> from: nodeStream [
	"collect preamble"
	[ nodeStream atEnd not and:[ nodeStream peek isHeader not ]]
		whileTrue: [ nodeStream next parent: self body  ].
	"collect subsections"
	[ nodeStream atEnd not and:[ nodeStream peek isHeader  ]]
		whileTrue: [ 
			(nodeStream peek level > self level)
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
	^ header
]

{ #category : #accessing }
MicSectionBlock >> header: headerBlock [
	header := headerBlock.
	header parent: self
]

{ #category : #initialization }
MicSectionBlock >> initialize [
	super initialize.
	body := MicIntermediateBlock new parent: self; yourself.
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
MicSectionBlock >> level [
	header ifNil: [ ^0 ].
	^ header level
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
