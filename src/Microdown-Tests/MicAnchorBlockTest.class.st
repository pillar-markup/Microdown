Class {
	#name : 'MicAnchorBlockTest',
	#superclass : 'MicBlockTest',
	#category : 'Microdown-Tests-Parser',
	#package : 'Microdown-Tests',
	#tag : 'Parser'
}

{ #category : 'tests' }
MicAnchorBlockTest >> subjectClass [ 
	^ MicAnchorBlock 
]

{ #category : 'tests' }
MicAnchorBlockTest >> testAnchorAndText [
	| doc |
	doc := Microdown parse: '@ancre
Ceci est un paragraphe'.
	
	self assert: doc children size equals: 2.
	self assert: doc children first class name equals: #MicAnchorBlock.
	self assert: doc children second class name equals: #MicParagraphBlock

]

{ #category : 'tests' }
MicAnchorBlockTest >> testAnchorName [
	| doc anchor |
	doc := Microdown parse: '@myAnchor'.
	anchor := doc children first.
	
	self assert: anchor class name equals: #MicAnchorBlock.
	self assert: anchor label equals: 'myAnchor'

]

{ #category : 'tests' }
MicAnchorBlockTest >> testAnchorWithDashesAndUnderscores [
	| doc anchor |
	doc := Microdown parse: '@my-anchor_01'.
	anchor := doc children first.
	
	self assert: anchor label equals: 'my-anchor_01'

]

{ #category : 'tests' }
MicAnchorBlockTest >> testInvalidAnchor [
	| doc |
	doc := Microdown parse: '@'.
	self assert: doc children first class name equals: #MicAnchorBlock
]

{ #category : 'tests' }
MicAnchorBlockTest >> testModifyLabel [
	| mic |
	mic := (parser parse: '@label') children first.
	self assert: mic label equals: 'label'.
	mic label: 'label2'.
	self assert: mic label equals: 'label2'.
]

{ #category : 'tests' }
MicAnchorBlockTest >> testMultipleAnchors [
	| doc |
	doc := Microdown parse: '@ancre1
@ancre2'.
	self assert: doc children size equals: 2.
	self assert: doc children first label equals: 'ancre1'.
	self assert: doc children second label equals: 'ancre2'
]
