Class {
	#name : 'MicRawParagraphBlockTest',
	#superclass : 'MicBlockTest',
	#category : 'Microdown-Tests-Parser',
	#package : 'Microdown-Tests',
	#tag : 'Parser'
}

{ #category : 'tests' }
MicRawParagraphBlockTest >> subjectClass [ 
	^ MicRawParagraphBlock 
]

{ #category : 'tests' }
MicRawParagraphBlockTest >> testFirstLineAfterMarkupShouldBeIgnored [
	"contents starts on the following line of the {{{"
	| root |
	root := parser parse: '{{{ blabla
**Hello is ... cut for real

a paragraph on two lines**
}}}'.

	self assert: root children first bodyString equals: '**Hello is ... cut for real

a paragraph on two lines**'.
	
]

{ #category : 'tests' }
MicRawParagraphBlockTest >> testSimpleParagraphWithMarkupShouldBeTakenAsIs [
	"
	{{{
	Hello 
	}}} 
	"

	| root |
	root := parser parse: '{{{ 
**Hello is ... cut for real
a paragraph on two lines**
}}}'.

	self assert: root children size equals: 1.
	self assert: root children first class equals: MicRawParagraphBlock.
	self assert: root children first bodyString equals: '**Hello is ... cut for real
a paragraph on two lines**'.
	
]

{ #category : 'tests' }
MicRawParagraphBlockTest >> testWithEmptyLine [
	"
	{{{
	Hello 
	}}} 
	"

	| root |
	root := parser parse: '{{{ 
**Hello is ... cut for real

a paragraph on two lines**
}}}'.

	self assert: root children size equals: 1.
	self assert: root children first bodyString equals: '**Hello is ... cut for real

a paragraph on two lines**'.
	
]

{ #category : 'tests' }
MicRawParagraphBlockTest >> testWithHTMLTag [

	| root |
	root := parser parse: '{{{ 
**Hello is ... cut for real
<a href="https://pharo.org">https://pharo.org</a>
a paragraph on two lines**
}}}'.

	self assert: root children size equals: 1.
	self assert: root children first bodyString equals: '**Hello is ... cut for real
<a href="https://pharo.org">https://pharo.org</a>
a paragraph on two lines**'
	
]
