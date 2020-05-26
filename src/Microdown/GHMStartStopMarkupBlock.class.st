"
May be in the future we will be able to say that SameMarkup is the same as a StartStop with the same delimiter but for now we do not know. 
"
Class {
	#name : #GHMStartStopMarkupBlock,
	#superclass : #GHMAbstractBlock,
	#instVars : [
		'isClosed',
		'body',
		'firstLine'
	],
	#category : #'Microdown-Model'
}

{ #category : #testing }
GHMStartStopMarkupBlock class >> isAbstract [

	^ self == GHMStartStopMarkupBlock
]

{ #category : #handle }
GHMStartStopMarkupBlock >> addLineAndReturnNextNode: line [
	"add line to this node. 
	Notice, the action is allowed to create new nodes in the block tree.
	Returns the node to handle next line - typically self."

	isClosed
		ifTrue: [ ^ self ].
	firstLine
		ifNil:
			[ firstLine := self extractFirstLineFrom: line ]
		ifNotNil: [ self bodyFromLine: line ].
	^ self
]

{ #category : #accessing }
GHMStartStopMarkupBlock >> body [
	^ body
]

{ #category : #accessing }
GHMStartStopMarkupBlock >> body: anObject [
	^ body := anObject
]

{ #category : #handle }
GHMStartStopMarkupBlock >> bodyFromLine: line [
	
	body := body ifNil: [ line ] ifNotNil: [ body , String cr , line ]
]

{ #category : #testing }
GHMStartStopMarkupBlock >> canConsumeLine: line [
	"As soon as a line closes a code block, it does not accept anymore any line.
	Indeed imagine 
	
	<
	a line 
	>
	The first line was accepted by its parent (a root block and the code block got created.
	then a line was accepting since done was false...
	then the closing line was reached and the code block got closed.)
	
	"

	isClosed
		ifTrue: [ ^ false ].
	isClosed := self doesLineStartWithStopMarkup: line.
	^ true
]

{ #category : #testing }
GHMStartStopMarkupBlock >> doesLineStartWithMarkup: line [
	"return if the line starts with a markup"

	^ line beginsWith: self lineStartMarkup
	
]

{ #category : #testing }
GHMStartStopMarkupBlock >> doesLineStartWithStopMarkup: line [
	"return if the line starts with a stop markup"

	^ line beginsWith: self lineStopMarkup
	
]

{ #category : #handle }
GHMStartStopMarkupBlock >> extractFirstLineFrom: line [
	^ line copyFrom: self lineStartMarkup size + 1 to: line size
]

{ #category : #accessing }
GHMStartStopMarkupBlock >> firstLine [
	^ firstLine
]

{ #category : #accessing }
GHMStartStopMarkupBlock >> firstLine: anObject [
	firstLine := anObject
]

{ #category : #initialization }
GHMStartStopMarkupBlock >> initialize [
	super initialize. 
	isClosed := false
]

{ #category : #testing }
GHMStartStopMarkupBlock >> isClosed [
	^ isClosed		
]

{ #category : #markups }
GHMStartStopMarkupBlock >> lineStartMarkup [

	^ self subclassResponsibility 
]

{ #category : #markups }
GHMStartStopMarkupBlock >> lineStopMarkup [

	^ self subclassResponsibility 
]
