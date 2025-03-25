Class {
	#name : 'MicNestedMarkupBlock',
	#superclass : 'MicStartStopMarkupBlock',
	#instVars : [
		'arguments'
	],
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'handle' }
MicNestedMarkupBlock >> addLineAndReturnNextNode: line [
	"add line to this node. 
	Notice, the action is allowed to create new nodes in the block tree.
	Returns the node to handle next line - typically self."
	
	
	| withoutPreTabs |
	isClosed
		ifTrue: [ ^ self ].
	withoutPreTabs := line withoutPreTabs.
	"Here the withoutPreTabs is probably not necessary because handlingPrefixTabOfLine: should do its job."
	firstLine
		ifNil:
			[ firstLine := self extractFirstLineFrom: withoutPreTabs.
			^ self ].
	(self doesLineStartWithStopMarkup: withoutPreTabs)
		ifTrue: [ ^ self ].
	 ^ self bodyFromLine: withoutPreTabs
]

{ #category : 'accessing' }
MicNestedMarkupBlock >> arguments [
	
	^ arguments
]

{ #category : 'accessing' }
MicNestedMarkupBlock >> body [

	^ String streamContents: [:s |  self bodyElements do: [ :each | s nextPutAll: each substring ] ]
]

{ #category : 'accessing' }
MicNestedMarkupBlock >> bodyElements [

	^ children
]

{ #category : 'accessing' }
MicNestedMarkupBlock >> bodyFromLine: line [
	
	| newBlock |
	newBlock := (self newBlockFor: line parent: self).
	self parser setCurrent: newBlock.
	^ newBlock
]

{ #category : 'accessing' }
MicNestedMarkupBlock >> environmentName [
	^ arguments at: #environmentName
]

{ #category : 'parse support' }
MicNestedMarkupBlock >> initialize [

	super initialize.
	
	"Pay attention closeMe is invoked during parse time and some conversions are creating environment without going over the parser
	For example the # Header to Slide is a typically case. Therefore the following initialization is needed even if 
	on parse time the arguments will get reset with another one."
	
	arguments := MicArgumentList new
]

{ #category : 'markups' }
MicNestedMarkupBlock >> lineStartMarkup [

	^ EnvironmentOpeningBlockMarkup 
]

{ #category : 'markups' }
MicNestedMarkupBlock >> lineStopMarkup [
	
	^ EnvironmentClosingBlockMarkup 
]

{ #category : 'handle' }
MicNestedMarkupBlock >> massageLine: aLine [

	^ aLine withoutPreTabs
]
