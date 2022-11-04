Class {
	#name : #MicInlineBlockTest,
	#superclass : #TestCase,
	#pools : [
		'MicMicrodownSharedPool'
	],
	#category : #'Microdown-Tests-InlineParser'
}

{ #category : #tests }
MicInlineBlockTest >> testAllTerminalNodesImplementsAccept [
	(MicInlineBlock allSubclasses select: [ :cl | cl allSubclasses isEmpty ])
		do: [ :class |  self assert: (class includesSelector: #accept:) ]
	
]

{ #category : #tests }
MicInlineBlockTest >> testBlockName [
	self assert: MicFigureBlock blockName equals: 'Figure'.
	self assert: MicBoldFormatBlock blockName equals: 'BoldFormat'
	
]
