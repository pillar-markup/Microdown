"
A MicTocEntryTest is a test class for testing the behavior of MicTocEntry
"
Class {
	#name : 'MicTocEntryTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'tests' }
MicTocEntryTest >> testWithChildrenIsNotLeaf [

	| entry |
	entry := MicTocEntry new.
	entry addChild: MicTocEntry new.

	self deny: entry isLeaf
]

{ #category : 'tests' }
MicTocEntryTest >> testWithoutChildrenIsLeaf [

	| entry |
	entry := MicTocEntry new.

	self assert: entry isLeaf
]
