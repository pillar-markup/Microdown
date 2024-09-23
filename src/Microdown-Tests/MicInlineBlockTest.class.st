Class {
	#name : 'MicInlineBlockTest',
	#superclass : 'TestCase',
	#pools : [
		'MicSharedPool'
	],
	#category : 'Microdown-Tests-InlineParser',
	#package : 'Microdown-Tests',
	#tag : 'InlineParser'
}

{ #category : 'tests' }
MicInlineBlockTest >> testAllTerminalNodesImplementsAccept [
	(MicInlineElement allSubclasses select: [ :cl | cl allSubclasses isEmpty ])
		do: [ :class |  self assert: (class includesSelector: #accept:) ]
	
]

{ #category : 'tests' }
MicInlineBlockTest >> testBlockName [
	self assert: MicFigureBlock blockName equals: 'Figure'.
	self assert: MicBoldFormatBlock blockName equals: 'BoldFormat'
	
]
