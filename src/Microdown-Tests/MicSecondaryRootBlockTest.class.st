Class {
	#name : 'MicSecondaryRootBlockTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Tests-Model',
	#package : 'Microdown-Tests',
	#tag : 'Model'
}

{ #category : 'tests' }
MicSecondaryRootBlockTest >> testAcceptDoubleDispatch [

	| block visitor |
	block := MicSecondaryRootBlock new.
	visitor := MicrodownVisitor new.
	self shouldnt: [ block accept: visitor ] raise: Error
]

{ #category : 'tests' }
MicSecondaryRootBlockTest >> testCanHoldChildren [

	| root child |
	root := MicSecondaryRootBlock new.
	child := MicParagraphBlock new.
	
	root addChild: child.
	
	self assert: root children size equals: 1.
	self assert: root children first equals: child
]

{ #category : 'tests' }
MicSecondaryRootBlockTest >> testIsSecondaryRoot [

	self assert: MicSecondaryRootBlock new isSecondaryRoot.
	self deny: MicRootBlock new isSecondaryRoot
]
