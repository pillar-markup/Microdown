"
A MicrodownTest is a test class for testing the behavior of Microdown
"
Class {
	#name : 'MicrodownTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Tests-Core',
	#package : 'Microdown-Tests',
	#tag : 'Core'
}

{ #category : 'tests - parent/children' }
MicrodownTest >> testAddedAsChildWhenUsingParent [

	| h t|
	h := MicHeaderBlock new.
	t := MicTextBlock new.
	t bodyString: 'Blblbl'.
	t parent: h.
	self assert: h children size equals: 1.
	self assert: h children first equals: t.
	self assert: t parent equals: h
]

{ #category : 'tests - parent/children' }
MicrodownTest >> testExtensionArgumentsAreNotReified [

	| doc slide |
	doc := MicrodownParser parse: '<!slide|title=A title!>'.
	slide := doc children first. 
	self assert: slide class  equals: MicSlideBlock.
	self assert: slide title equals: 'A title'.

]

{ #category : 'tests - parent/children' }
MicrodownTest >> testFigureLabelAreNotReified [
	"but they should"

	| doc fig |
	doc := MicrodownParser new  parse: '![A caption.](figures/f.png width=120&label=fig)'.
	fig := doc children first children first. 
	self assert: fig class  equals: MicFigureBlock.
	self assert: fig anchor equals: 'fig'.

]

{ #category : 'tests' }
MicrodownTest >> testMicrodownSpelledCorrect [
	self assert: (Object allSubclasses select: [ :c | c name beginsWith: 'MicroDown' ]) isEmpty
]

{ #category : 'tests - parent/children' }
MicrodownTest >> testParentBackLinkIsSet [

	| h t|
	h := MicHeaderBlock new.
	t := MicTextBlock new.
	t bodyString: 'Blblbl'.
	h addChild: t.
	self assert: h children size equals: 1.
	self assert: h children first equals: t.
	self assert: t parent equals: h
]
