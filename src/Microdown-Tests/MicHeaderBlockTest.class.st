"
I'm a test class for testing the behavior of MicHeaderBlock
"
Class {
	#name : #MicHeaderBlockTest,
	#superclass : #MicBlockTest,
	#category : #'Microdown-Tests-Parser'
}

{ #category : #running }
MicHeaderBlockTest >> subjectClass [ 
	^ MicHeaderBlock  
]

{ #category : #tests }
MicHeaderBlockTest >> testCanConsumeLine [

	| root headerString |
	headerString := HeaderMarkup, ' Level1'.
	root := parser parse: headerString.
	self deny: (root children first canConsumeLine: headerString) 
]

{ #category : #tests }
MicHeaderBlockTest >> testHeaderAPIToAccessText [

	| header |
	header := (self parser parse: '# titre1') children first.
	self assert: header class equals: MicHeaderBlock.
	self assert: header children first class equals: MicTextBlock.
	self assert: header children first bodystring equals: 'titre1'
]

{ #category : #tests }
MicHeaderBlockTest >> testHeaderAPIToSetText [

	| header |
	header := (self parser parse: '# titre1') children first.
	self assert: header class equals: MicHeaderBlock.
	self assert: header headerElements first text equals: 'titre1'.
	header headerElements: { (MicTextBlock new substring: 'Blblbl') }.
	self assert: header headerElements first substring equals: 'Blblbl'
]

{ #category : #tests }
MicHeaderBlockTest >> testHeaderCreatesInnerText [

	| header |
	header := (self parser parse: '# titre1') children first.
	self assert: header class equals: MicHeaderBlock.
	self assert: header children first class equals: MicTextBlock.
	self assert: header children first bodystring equals: 'titre1'
]

{ #category : #tests }
MicHeaderBlockTest >> testHeaderLevel1 [
	| root |
	root := parser parse: HeaderMarkup, ' Level1'.
	self assert: root children size equals: 1.
	self assert: root children first header equals: 'Level1'.
	self assert: root children first level equals: 1
]

{ #category : #tests }
MicHeaderBlockTest >> testHeaderLevel1NoSpace [

	| source root |
	source := HeaderMarkup, 'Level1'.
	root := parser parse: source.
	self assert: root children size equals: 1.
	self assert: root children first header equals: 'Level1'.
	self assert: root children first level equals: 1
]

{ #category : #tests }
MicHeaderBlockTest >> testHeaderLevel4 [

	| source root |
	source := (HeaderMarkup repeat: 4), '    Level four'.
	root := parser parse: source.
	self assert: root children size equals: 1.
	self assert: root children first header equals: 'Level four'.
	self assert: root children first level equals: 4
]

{ #category : #tests }
MicHeaderBlockTest >> testHeaderLevel6 [
	| source root |
	source := (HeaderMarkup repeat: 6), '    Level six'.
	root := parser parse: source.
	self assert: root children size equals: 1.
	self assert: root children first header equals: 'Level six'.
	self assert: root children first level equals: 6
]

{ #category : #tests }
MicHeaderBlockTest >> testHeaderLevelOutOfRange [
	| source header |
	source := (HeaderMarkup repeat: 1), '    Level one'.
	header := (parser parse: source) children first.
	header level: 0.
	self assert: header level equals: 1.
	header level: 7.
	self assert: header level equals: 6.
	
]

{ #category : #tests }
MicHeaderBlockTest >> testHeaderLongElements [

	| header |
	header := (self parser parse: '# titre1 Introduction') children
		             first.
	self assert: header children size equals: 1.
	self
		assert: header children first class
		equals: MicTextBlock.
	
]
