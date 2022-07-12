Class {
	#name : #MicFormatBlockTest,
	#superclass : #MicBlockTest,
	#category : #'Microdown-Tests-Parser'
}

{ #category : #tests }
MicFormatBlockTest >> subjectClass [ 
	^ MicBoldFormatBlock 
]

{ #category : #'tests - bold' }
MicFormatBlockTest >> testBoldAPIToAccessText [

	| bold |
	bold := (self parser parse: '**a b**') children first children first.
	self assert: bold class equals: MicBoldFormatBlock.
	self assert: bold textElement class equals: MicTextBlock.
	self assert: bold textElement substring equals: 'a b'
]

{ #category : #'tests - bold' }
MicFormatBlockTest >> testBoldAPIToSetText [

	| bold |
	bold := (self parser parse: '**a b**') children first children first.
	self assert: bold class equals: MicBoldFormatBlock.
	bold textElement: (MicTextBlock new substring: 'Blblbl').
	self assert: bold textElement substring equals: 'Blblbl'
]

{ #category : #'tests - bold' }
MicFormatBlockTest >> testBoldCreatesInnerText [

	| bold |
	bold := (self parser parse: '**a b**') children first children first.
	self assert: bold class equals: MicBoldFormatBlock.
	self assert: bold children first class equals: MicTextBlock.
	self assert: bold children first substring equals: 'a b'
]

{ #category : #'tests - bold' }
MicFormatBlockTest >> testBoldItalicAPIToAccessText [

	| italic |
	italic := (self parser parse: '**_a b_**') children first children first.
	self assert: italic class equals: MicBoldFormatBlock.
	self assert: italic textElement class equals: MicItalicFormatBlock.
	self
		assert: italic textElement children first class
		equals: MicTextBlock.
	self assert: italic textElement substring equals: 'a b'
]

{ #category : #tests }
MicFormatBlockTest >> testBoldWrappedElements [
	
	| paragraph |
	paragraph := (self parserClass parse: '**aa bb** c') children first.
	self assert: paragraph children size equals: 2.
	self assert: paragraph children first wrappedElements size equals: 1. 
	self assert: paragraph children first class equals: MicBoldFormatBlock.
	self assert: paragraph children first wrappedElements first class equals: MicTextBlock.
	
]

{ #category : #'tests - bold' }
MicFormatBlockTest >> testBoldWrappedWithAccessAPIElements [

	| paragraph |
	paragraph := (self parser parse: '**aa bb** c') children first.
	self assert: paragraph children size equals: 2.
	self
		assert: paragraph children first textElement substring
		equals: 'aa bb'.
	self assert: paragraph children second class equals: MicTextBlock.
	self assert: paragraph children second substring equals: ' c'
]

{ #category : #tests }
MicFormatBlockTest >> testHasProperty [

	self assert: (self subject propertyAt: #foo ifAbsent: [ true ]) .
	self subject propertyAt: #foo put: 'bar'.
	self assert: (self subject hasProperty: #foo).
	self deny: (self subject hasProperty: #bar)
]

{ #category : #'tests - italic' }
MicFormatBlockTest >> testItalicAPIToAccessText [

	| italic |
	italic := (self parser parse: '_a b_') children first children first.
	self assert: italic class equals: MicItalicFormatBlock.
	self assert: italic textElement class equals: MicTextBlock.
	self assert: italic textElement substring equals: 'a b'
]

{ #category : #'tests - italic' }
MicFormatBlockTest >> testItalicAPIToSetText [

	| italic |
	italic := (self parser parse: '_a b_') children first children first.
	self assert: italic class equals: MicItalicFormatBlock.
	italic textElement: (MicTextBlock new substring: 'Blblbl').
	self assert: italic textElement substring equals: 'Blblbl'
]

{ #category : #'tests - italic' }
MicFormatBlockTest >> testItalicCreatesInnerText [

	| italic |
	italic := (self parser parse: '_a b_') children first children first.
	self assert: italic class equals: MicItalicFormatBlock.
	self assert: italic children first class equals: MicTextBlock.
	self assert: italic children first substring equals: 'a b'
]

{ #category : #'tests - italic' }
MicFormatBlockTest >> testItalicWrappedElements [

	| paragraph |
	paragraph := (self parser parse: '_aa bb_ c') children first.
	self assert: paragraph children size equals: 2.
	self assert: paragraph children first wrappedElements size equals: 1.
	self
		assert: paragraph children first class
		equals: MicItalicFormatBlock.
	self
		assert: paragraph children first wrappedElements first class
		equals: MicTextBlock
]

{ #category : #'tests - italic' }
MicFormatBlockTest >> testItalicWrappedWithAccessAPIElements [

	| paragraph |
	paragraph := (self parser parse: '_aa bb_ c') children first.
	self assert: paragraph children size equals: 2.
	self
		assert: paragraph children first textElement substring
		equals: 'aa bb'.
	self assert: paragraph children second class equals: MicTextBlock.
	self assert: paragraph children second substring equals: ' c'
]

{ #category : #'tests - monospace' }
MicFormatBlockTest >> testMonospaceCreatesInnerText [

	| mono |
	mono := (self parser parse: '`a b`') children first children first.
	self assert: mono class equals: MicMonospaceFormatBlock.
	self assert: mono children first class equals: MicTextBlock.
	self assert: mono children first substring equals: 'a b'
]

{ #category : #'tests - monospace' }
MicFormatBlockTest >> testMonospaceTextCreatesInnerText [

	| mono |
	mono := (self parser parse: '`a b`') children first children first.
	self assert: mono class equals: MicMonospaceFormatBlock.
	self assert: mono text equals: 'a b'.
	self assert: mono textElement class equals: MicTextBlock.
	self assert: mono textElement substring equals: 'a b'
]

{ #category : #'tests - monospace' }
MicFormatBlockTest >> testMonospaceWrappedElements [

	| mono |
	mono := (self parser parse: '`a b`') children first children first.
	self assert: mono wrappedElements first class equals: MicTextBlock.
	self assert: mono wrappedElements first substring equals: 'a b'
]

{ #category : #'tests - bold' }
MicFormatBlockTest >> testPrintingBold [

	| bold |
	bold := (self parser parse: '**a b**') children first children first.
	self assert: bold printString equals: 'BoldFormat(Text(a b))'
	
]

{ #category : #'tests - monospace' }
MicFormatBlockTest >> testPrintingBold2 [

	| bold |
	bold := (self parser parse: '`_a b_`') children first children first.
	self assert: bold printString equals: 'MonospaceFormat(Text(_a b_))'
]

{ #category : #'tests - italic' }
MicFormatBlockTest >> testPrintingItalic [

	| bold |
	bold := (self parser parse: '_a b_') children first children first.
	self assert: bold printString equals: 'ItalicFormat(Text(a b))'
]

{ #category : #tests }
MicFormatBlockTest >> testProperties [

	self assert: self subject properties isNotNil.
	self subject instVarNamed: 'properties' put: nil.

	self subject propertyAt: #foo put: #bar.
	self subject instVarNamed: 'properties' put: nil.

	self subject propertyAt: #foo ifAbsent: [ nil ].
	self subject instVarNamed: 'properties' put: nil.

	self subject propertyAt: #foo ifAbsentPut: [ #bar ].
	self subject instVarNamed: 'properties' put: nil.

	self subject hasProperty: #foo.
	self subject instVarNamed: 'properties' put: nil
]
