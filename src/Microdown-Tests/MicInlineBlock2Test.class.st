Class {
	#name : #MicInlineBlock2Test,
	#superclass : #TestCase,
	#pools : [
		'MicMicrodownSharedPool'
	],
	#category : #'Microdown-Tests-InlineParser'
}

{ #category : #tests }
MicInlineBlock2Test >> testAllTerminalNodesImplementsAccept [
	(MicInlineBlock2 allSubclasses select: [ :cl | cl allSubclasses isEmpty ])
		do: [ :class |  self assert: (class includesSelector: #accept:) ]
	
]

{ #category : #tests }
MicInlineBlock2Test >> testBlockName [
	self assert: MicFigureBlock2 blockName equals: 'Figure'.
	self assert: MicBoldFormatBlock2 blockName equals: 'Bold'
	
]
