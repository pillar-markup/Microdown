Class {
	#name : #MicFormatBlockTest,
	#superclass : #MicBlockTest,
	#category : #'Microdown-Tests-Parser'
}

{ #category : #tests }
MicFormatBlockTest >> testBoldAPIToAccessText [

	| bold |
	bold := (MicroDownParser new parse: '**a b**') children first children first.
	self assert: bold class equals: MicBoldFormatBlock.
	self assert: bold textElement class equals: MicTextBlock.
	self assert: bold textElement substring equals: 'a b'
]

{ #category : #tests }
MicFormatBlockTest >> testBoldAPIToSetText [

	| bold |
	bold := (MicroDownParser new parse: '**a b**') children first children first.
	self assert: bold class equals: MicBoldFormatBlock.
	bold textElement: (MicTextBlock new substring: 'Blblbl').
	self assert: bold textElement substring equals: 'Blblbl'.
]

{ #category : #tests }
MicFormatBlockTest >> testBoldCreatesInnerText [

	| bold |
	bold := (MicroDownParser new parse: '**a b**') children first children first.
	self assert: bold class equals: MicBoldFormatBlock.
	self assert: bold children first class equals: MicTextBlock.
	self assert: bold children first substring equals: 'a b'
]

{ #category : #tests }
MicFormatBlockTest >> testBoldWrappedElements [
	
	| paragraph |
	paragraph := (MicroDownParser new parse: '**aa bb** c') children first.
	self assert: paragraph children size equals: 2.
	self assert: paragraph children first wrappedElements size equals: 1. 
	self assert: paragraph children first class equals: MicBoldFormatBlock.
	self assert: paragraph children first wrappedElements first class equals: MicTextBlock.
	
]

{ #category : #tests }
MicFormatBlockTest >> testBoldWrappedWithAccessAPIElements [
	
	| paragraph |
	paragraph := (MicroDownParser new parse: '**aa bb** c') children first.
	self assert: paragraph children size equals: 2.
	self assert: paragraph children first textElement substring equals: 'aa bb'.
	self assert: paragraph children second class equals: MicTextBlock.
	self assert: paragraph children second substring equals: ' c'.
	
]

{ #category : #tests }
MicFormatBlockTest >> testMonospaceCreatesInnerText [
	
	| mono |
	mono := (MicroDownParser new parse: '`a b`') children first children first.
	self assert: mono class equals: MicMonospaceFormatBlock.
	self assert: mono children first class equals: MicTextBlock.
	self assert: mono children first substring equals: 'a b'
]

{ #category : #tests }
MicFormatBlockTest >> testMonospaceTextCreatesInnerText [

	| mono |
	mono := (MicroDownParser new parse: '`a b`') children first children first.
	self assert: mono class equals: MicMonospaceFormatBlock.
	mono text: ' 0 **a b** z'.
	self assert: mono children first class equals: MicTextBlock.
	self assert: mono children first substring equals: ' 0 **a b** z'
]

{ #category : #tests }
MicFormatBlockTest >> testMonospaceWrappedElements [
	
	| mono |
	mono := (MicroDownParser new parse: '`a b`') children first children first.
	self assert: mono wrappedElements first class equals: MicTextBlock.
	self assert: mono wrappedElements first substring equals: 'a b'
]
