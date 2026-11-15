Class {
	#name : 'MicSecondaryRootBlockTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Tests-Model',
	#package : 'Microdown-Tests',
	#tag : 'Model'
}

{ #category : 'tests' }
MicSecondaryRootBlockTest >> testAcceptDoubleDispatch [
	"A visitor visits a secondary root like a root: its children are visited."

	| block |
	block := MicSecondaryRootBlock new.
	(Microdown parse: 'hello **world**') children do: [ :each | block addChild: each ].
	self
		assert: (MicTextualMicrodownExporter new
				 visit: block;
				 contents) trimBoth
		equals: 'hello **world**'
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
MicSecondaryRootBlockTest >> testFileProperty [
	| root fileRef |
	root := MicSecondaryRootBlock new.
	fileRef := 'fichierInclus.md' asFileReference.
	
	root fromFile: fileRef.
	
	self assert: root fromFile equals: fileRef
]

{ #category : 'tests' }
MicSecondaryRootBlockTest >> testIsSecondaryRoot [
	| mainRoot secondaryRoot |
	mainRoot := MicRootBlock new.
	secondaryRoot := MicSecondaryRootBlock new.
	
	self deny: mainRoot isSecondaryRoot.
	self assert: secondaryRoot isSecondaryRoot
]
