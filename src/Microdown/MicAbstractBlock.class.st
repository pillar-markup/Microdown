"
I am the abstract node for parsing full/multi-line aspects of github markdown.

I have a set of children, and an uplink to my parent.

The root of the parsetree is an instance of GHMRootBlock.

See the comment in GHMParser for an overview of the algorithm used in parsing github markdown.
"
Class {
	#name : #MicAbstractBlock,
	#superclass : #Object,
	#instVars : [
		'parent',
		'children',
		'parser'
	],
	#category : #'Microdown-Model'
}

{ #category : #adding }
MicAbstractBlock >> addChild: childBlock [
	children add: childBlock
]

{ #category : #public }
MicAbstractBlock >> addLineAndReturnNextNode: line [
	"add line to this node. 
	Notice, the action is allowed to create new nodes in the block tree.
	Returns the node to handle next line - typically self."

	self subclassResponsibility.
	^ self
]

{ #category : #public }
MicAbstractBlock >> blockExtensionStarterClassFrom: line [
	"return the class of a block which can start with line, or nil if none"

	^ nil
]

{ #category : #public }
MicAbstractBlock >> blockStarterClassFrom: line [
	"return the class of a block which can start with line, or nil if none"

	^ self parser blockStarterClassFrom: line
]

{ #category : #public }
MicAbstractBlock >> canConsumeLine: line [
	"return if this block can consume line"

	^ self subclassResponsibility 
]

{ #category : #adding }
MicAbstractBlock >> children [
	^children 
]

{ #category : #public }
MicAbstractBlock >> closeMe [
	Transcript << 'Closing ' << self class name; cr; endEntry
]

{ #category : #debugging }
MicAbstractBlock >> contents [
	^ ''
]

{ #category : #accessing }
MicAbstractBlock >> indent [
	^ parent indent
]

{ #category : #initialization }
MicAbstractBlock >> initialize [
	super initialize. 
	children := OrderedCollection new.
]

{ #category : #testing }
MicAbstractBlock >> listItemBlockClass [
	^ MicListItemBlock
]

{ #category : #public }
MicAbstractBlock >> newBlockFor: line parent: parentBlock [
	| newBlockClass |
	newBlockClass := self blockStarterClassFrom: line.
	newBlockClass ifNil: [ ^parentBlock ].
	^ newBlockClass new
		setParser: parser;
		parent: parentBlock;
		addLineAndReturnNextNode: line
]

{ #category : #accessing }
MicAbstractBlock >> parent [
	^ parent
]

{ #category : #accessing }
MicAbstractBlock >> parent: aBlock [
	parent := aBlock.
	aBlock addChild: self
]

{ #category : #private }
MicAbstractBlock >> parser [
	^ parser 
]

{ #category : #private }
MicAbstractBlock >> parserClass [ 
	^ MicAbstractParser 
]

{ #category : #private }
MicAbstractBlock >> setParser: aParser [
	parser := aParser 
]

{ #category : #debugging }
MicAbstractBlock >> showStructure: indent [
	"Produce a string representing the structure in terms of block classes of the receiver"
	
	| ind |
	ind := String tab repeat: indent.
	^ ind, self class name, String cr, ((children collect: [:c | c showStructure: indent + 1]) joinUsing: String cr).
]
