Class {
	#name : 'MicFormatBlockTest',
	#superclass : 'MicBlockTest',
	#category : 'Microdown-Tests-Parser',
	#package : 'Microdown-Tests',
	#tag : 'Parser'
}

{ #category : 'tests' }
MicFormatBlockTest >> subjectClass [ 
	^ MicBoldFormatBlock 
]

{ #category : 'tests - bold' }
MicFormatBlockTest >> testBoldAPIToAccessText [

	| bold |
	bold := (self parser parse: '**a b**') children first children first.
	self assert: bold class equals: MicBoldFormatBlock.
	self assert: bold children first class equals: MicTextBlock.
	self assert: bold children first bodyString equals: 'a b'
]

{ #category : 'tests - bold' }
MicFormatBlockTest >> testBoldAPIToSetText [

	| bold |
	bold := (self parser parse: '**a b**') children first children first.
	self assert: bold class equals: MicBoldFormatBlock.
	bold children: { (MicTextBlock new bodyString: 'Blblbl') }.
	self assert: bold children first bodyString equals: 'Blblbl'
]

{ #category : 'tests - bold' }
MicFormatBlockTest >> testBoldCreatesInnerText [

	| bold |
	bold := (self parser parse: '**a b**') children first children first.
	self assert: bold class equals: MicBoldFormatBlock.
	self assert: bold children first class equals: MicTextBlock.
	self assert: bold children first bodyString equals: 'a b'
]

{ #category : 'tests - bold' }
MicFormatBlockTest >> testBoldItalicAPIToAccessText [

	| italic |
	italic := (self parser parse: '**_a b_**') children first children
		          first.
	self assert: italic class equals: MicBoldFormatBlock.
	self assert: italic children first class equals: MicItalicFormatBlock.
	self
		assert: italic children first children first class
		equals: MicTextBlock.
	self
		assert: italic children first children first bodyString
		equals: 'a b'
]

{ #category : 'tests' }
MicFormatBlockTest >> testBoldWrappedElements [

	| paragraph |
	paragraph := (self parserClass parse: '**aa bb** c') children first.
	self assert: paragraph children size equals: 2.
	self assert: paragraph children first children size equals: 1.
	self
		assert: paragraph children first class
		equals: MicBoldFormatBlock.
	self
		assert: paragraph children first children first class
		equals: MicTextBlock
]

{ #category : 'tests - bold' }
MicFormatBlockTest >> testBoldWrappedWithAccessAPIElements [

	| paragraph |
	paragraph := (self parser parse: '**aa bb** c') children first.
	self assert: paragraph children size equals: 2.
	self
		assert: paragraph children first children first bodyString
		equals: 'aa bb'.
	self assert: paragraph children second class equals: MicTextBlock.
	self assert: paragraph children second bodyString equals: ' c'
]

{ #category : 'tests' }
MicFormatBlockTest >> testHasProperty [

	self assert: (self subject propertyAt: #foo ifAbsent: [ true ]) .
	self subject propertyAt: #foo put: 'bar'.
	self assert: (self subject hasProperty: #foo).
	self deny: (self subject hasProperty: #bar)
]

{ #category : 'tests - italic' }
MicFormatBlockTest >> testItalicAPIToAccessText [

	| italic |
	italic := (self parser parse: '_a b_') children first children first.
	self assert: italic class equals: MicItalicFormatBlock.
	self assert: italic children first class equals: MicTextBlock.
	self assert: italic children first bodyString equals: 'a b'
]

{ #category : 'tests - italic' }
MicFormatBlockTest >> testItalicAPIToSetText [

	| italic |
	italic := (self parser parse: '_a b_') children first children first.
	self assert: italic class equals: MicItalicFormatBlock.
	italic children: { (MicTextBlock new bodyString: 'Blblbl') }.
	self assert: italic children first bodyString equals: 'Blblbl'
]

{ #category : 'tests - italic' }
MicFormatBlockTest >> testItalicCreatesInnerText [

	| italic |
	italic := (self parser parse: '_a b_') children first children first.
	self assert: italic class equals: MicItalicFormatBlock.
	self assert: italic children first class equals: MicTextBlock.
	self assert: italic children first bodyString equals: 'a b'
]

{ #category : 'tests - italic' }
MicFormatBlockTest >> testItalicWrappedElements [

	| paragraph |
	paragraph := (self parser parse: '_aa bb_ c') children first.
	self assert: paragraph children size equals: 2.
	self assert: paragraph children first children size equals: 1.
	self
		assert: paragraph children first class
		equals: MicItalicFormatBlock.
	self
		assert: paragraph children first children first class
		equals: MicTextBlock
]

{ #category : 'tests - italic' }
MicFormatBlockTest >> testItalicWrappedWithAccessAPIElements [

	| paragraph |
	paragraph := (self parser parse: '_aa bb_ c') children first.
	self assert: paragraph children size equals: 2.
	self
		assert: paragraph children first children first bodyString
		equals: 'aa bb'.
	self assert: paragraph children second class equals: MicTextBlock.
	self assert: paragraph children second bodyString equals: ' c'
]

{ #category : 'tests - monospace' }
MicFormatBlockTest >> testMonospaceCreatesInnerText [

	| mono |
	mono := (self parser parse: '`a b`') children first children first.
	self assert: mono class equals: MicMonospaceFormatBlock.
	self assert: mono children first class equals: MicTextBlock.
	self assert: mono children first bodyString equals: 'a b'
]

{ #category : 'tests - monospace' }
MicFormatBlockTest >> testMonospaceTextCreatesInnerText [

	| mono |
	mono := (self parser parse: '`a b`') children first children first.
	self assert: mono class equals: MicMonospaceFormatBlock.
	self assert: mono bodyString equals: 'a b'
]

{ #category : 'tests - monospace' }
MicFormatBlockTest >> testMonospaceWrappedElements [

	| mono |
	mono := (self parser parse: '`a b`') children first children first.
	self assert: mono class equals: MicMonospaceFormatBlock.
	self assert: mono bodyString equals: 'a b'
]

{ #category : 'tests - bold' }
MicFormatBlockTest >> testPrintingBold [

	| bold |
	bold := (self parser parse: '**a b**') children first children first.
	self assert: bold printString equals: 'BoldFormat{ Text(a b) }'
	
]

{ #category : 'tests - monospace' }
MicFormatBlockTest >> testPrintingBold2 [

	| bold |
	bold := (self parser parse: '`_a b_`') children first children first.
	self assert: bold printString equals: 'Monospace(_a b_)'
]

{ #category : 'tests - italic' }
MicFormatBlockTest >> testPrintingItalic [

	| bold |
	bold := (self parser parse: '_a b_') children first children first.
	self assert: bold printString equals: 'ItalicFormat{ Text(a b) }'
]
