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

{ #category : 'tests - parent/children' }
MicrodownTest >> testMathCaptionIsReified [
	"And as such their parent is the math block"
	
	| root math |
	root := Microdown parse: '
$$ % key=cite&label=42&caption=Ze **great** formula
V_i = C_0 - C_3 
$$'.
	math := root children first.
	self
		assert: math captionElements second class equals: MicBoldFormatBlock.
	self assert: math captionElements first parent equals: math
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

{ #category : 'tests - replace' }
MicrodownTest >> testParentLinkIsKeptOnReplaceBy [

	| h original new |
	h := MicHeaderBlock new.
	original := MicTextBlock new.
	original bodyString: 'Original'.
	original parent: h.
	self assert: original parent equals: h.
	self assert: h children first equals: original.
	new := MicTextBlock new.
	new bodyString: 'New'.
	
	self halt.
	original replaceBy: new.
	self assert: h children size equals: 1.
	self assert: h children first equals: new.
	self assert: new parent equals: h.
	
]
