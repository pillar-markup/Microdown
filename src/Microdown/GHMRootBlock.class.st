"
I am the root of the github markup tree
"
Class {
	#name : #GHMRootBlock,
	#superclass : #GHMAbstractBlock,
	#category : #'Microdown-Model'
}

{ #category : #testing }
GHMRootBlock >> addLineAndReturnNextNode: line [
	"add line to this node. 
	Notice, the action is allowed to create new nodes in the block tree.
	Returns the node to handle next line - typically self."

	| newBlock |
	newBlock := self newBlockFor: line parent: self.
	^ newBlock 
]

{ #category : #testing }
GHMRootBlock >> canConsumeLine: line [
	"The root block can always consume everything no matter what it is."

	^ true
]

{ #category : #'as yet unclassified' }
GHMRootBlock >> contents [ 
	"not clear what tesxt is."
	^super contents , '[ ', (self showStructure: 0), ' ]'
]

{ #category : #accessing }
GHMRootBlock >> indent [
	^0
]
