Class {
	#name : 'MicInlineSpaceBlockTest',
	#superclass : 'MicBlockTest',
	#category : 'Microdown-Tests-Parser',
	#package : 'Microdown-Tests',
	#tag : 'Parser'
}

{ #category : 'tests' }
MicInlineSpaceBlockTest >> subjectClass [
	^ MicInlineSpaceBlock 
]

{ #category : 'tests' }
MicInlineSpaceBlockTest >> testParagraphWithInlineSpace [

	| root |
	root := self parser parse: 'a paragraph with an inline space here <br> it continues after here.'.
	self assert: root children size equals: 1.
	self assert: root children first children size equals: 3.
	self assert: root children first children second class equals: MicInlineSpaceBlock 
]

{ #category : 'tests' }
MicInlineSpaceBlockTest >> testParagraphWithInlineSpaceAndOthers [

	| root |
	root := self parser parse: '_a paragraph_ with an *inline* space here <br> it continues after here.'.
	self assert: root children size equals: 1.
	self assert: root children first children size equals: 6
]
