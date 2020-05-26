"
I am the abstract node for parsing full/multi-line aspects of github markdown.

I have a set of children, and an uplink to my parent.

The root of the parsetree is an instance of GHMRootBlock.

See the comment in GHMParser for an overview of the algorithm used in parsing github markdown.
"
Class {
	#name : #GHMAbstractBlock,
	#superclass : #Object,
	#instVars : [
		'parent',
		'children',
		'parser'
	],
	#category : #'Microdown-Model'
}

{ #category : #adding }
GHMAbstractBlock >> addChild: childBlock [
	children add: childBlock
]

{ #category : #public }
GHMAbstractBlock >> addLineAndReturnNextNode: line [
	"add line to this node. 
	Notice, the action is allowed to create new nodes in the block tree.
	Returns the node to handle next line - typically self."

	self subclassResponsibility.
	^ self
]

{ #category : #public }
GHMAbstractBlock >> blockExtensionStarterClassFrom: line [
	"return the class of a block which can start with line, or nil if none"

	^ nil
]

{ #category : #public }
GHMAbstractBlock >> blockStarterClassFrom: line [
	"return the class of a block which can start with line, or nil if none"

	^ self parser blockStarterClassFrom: line
]

{ #category : #public }
GHMAbstractBlock >> canConsumeLine: line [
	"return if this block can consume line"

	^ self subclassResponsibility 
]

{ #category : #adding }
GHMAbstractBlock >> children [
	^children 
]

{ #category : #public }
GHMAbstractBlock >> closeMe [
	Transcript << 'Closing ' << self class name; cr; endEntry
]

{ #category : #debugging }
GHMAbstractBlock >> contents [
	^ ''
]

{ #category : #accessing }
GHMAbstractBlock >> indent [
	^ parent indent
]

{ #category : #initialization }
GHMAbstractBlock >> initialize [
	super initialize. 
	children := OrderedCollection new.
]

{ #category : #testing }
GHMAbstractBlock >> listItemBlockClass [
	^ GHMListItemBlock
]

{ #category : #public }
GHMAbstractBlock >> newBlockFor: line parent: parentBlock [
	| newBlockClass |
	newBlockClass := self blockStarterClassFrom: line.
	newBlockClass ifNil: [ ^parentBlock ].
	^ newBlockClass new
		setParser: parser;
		parent: parentBlock;
		addLineAndReturnNextNode: line
]

{ #category : #accessing }
GHMAbstractBlock >> parent [
	^ parent
]

{ #category : #accessing }
GHMAbstractBlock >> parent: aBlock [
	parent := aBlock.
	aBlock addChild: self
]

{ #category : #private }
GHMAbstractBlock >> parser [
	^ parser 
]

{ #category : #private }
GHMAbstractBlock >> parserClass [ 
	^ GHMParser 
]

{ #category : #private }
GHMAbstractBlock >> setParser: aParser [
	parser := aParser 
]

{ #category : #debugging }
GHMAbstractBlock >> showStructure: indent [
	"Produce a string representing the structure in terms of block classes of the receiver"
	
	| ind |
	ind := String tab repeat: indent.
	^ ind, self class name, String cr, ((children collect: [:c | c showStructure: indent + 1]) joinUsing: String cr).
]
