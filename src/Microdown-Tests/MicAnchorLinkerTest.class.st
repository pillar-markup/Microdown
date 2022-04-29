Class {
	#name : #MicAnchorLinkerTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests-Parser'
}

{ #category : #tests }
MicAnchorLinkerTest >> testAnchorIsAttachedToItsTarget [
	| linker doc |
	linker := MicAnchorLinker new.
	doc := MicrodownParser parse: '
this is a sentence

#Header1
@sec1'.
	linker visit: doc.
	self assert: doc children second class equals: MicHeaderBlock.
	self assert: doc children third class equals: MicAnchorBlock.
	self assert: doc children third target class equals: MicHeaderBlock
	
]

{ #category : #tests }
MicAnchorLinkerTest >> testAnchorIsAttachedToItsTarget2 [
	| linker doc |
	linker := MicAnchorLinker new.
	doc := MicrodownParser parse: '
this is a sentence

#Header1
@sec1
@sec2'.
	linker visit: doc.
	self assert: doc children second class equals: MicHeaderBlock.
	self assert: doc children third class equals: MicAnchorBlock.
	self assert: doc children third target class equals: MicHeaderBlock.
	self assert: doc children fourth target isNil
	
]

{ #category : #tests }
MicAnchorLinkerTest >> testHeaderLast [
	| linker doc |
	linker := MicAnchorLinker new.
	doc := MicrodownParser parse: '
this is a sentence

#Header1'.
	linker visit: doc.
	self assert: doc children second class equals: MicHeaderBlock.
	
]
