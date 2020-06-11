"
An IntraBlockSplitterTest is a test class for testing the behavior of IntraBlockSplitter
"
Class {
	#name : #MicIntraBlockSplitterTest,
	#superclass : #TestCase,
	#category : #'Microdown-Kasper'
}

{ #category : #tests }
MicIntraBlockSplitterTest >> splitter [
	^ MicIntraBlockSplitter new
]

{ #category : #tests }
MicIntraBlockSplitterTest >> testExternalLinkAsPillar [
	| res |
	res := self splitter pillarFrom: 'abc[alias](link)cba'.
	self assert: res second children first text equals: 'alias'.
	self assert: res second class equals: PRExternalLink.

]

{ #category : #tests }
MicIntraBlockSplitterTest >> testFigureAsPillar [
	| res |
	res := self splitter pillarFrom: 'abc![alias](link)cba'.
	self assert: res second children first text equals: 'alias'.
	self assert: res second reference equals: 'link'.
	self assert: res second class equals: PRFigure

]

{ #category : #tests }
MicIntraBlockSplitterTest >> testItalicAsPillar [
	| res |
	res := self splitter pillarFrom: 'abc*xyz*cba'.
	self assert: res second children first text equals: 'xyz'.
	self assert: res second class equals: PRItalicFormat.
	
	
]

{ #category : #tests }
MicIntraBlockSplitterTest >> testPlainAsPillar [
	| res |
	res := self splitter pillarFrom: 'abc'.
	self assert: res first text equals: 'abc'.
	self assert: res first class equals: PRText.
	
	
]

{ #category : #tests }
MicIntraBlockSplitterTest >> testSplitBlock2 [
	"Test with multiple annotations"

	| res |
	res := self splitter splitString: 'abc**abc**xyz`xyz`last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[abc]' . 'xyz' . '[xyz]' . 'last'}
]

{ #category : #tests }
MicIntraBlockSplitterTest >> testSplitBlockBold [
	| res |
	res := self splitter splitString: 'abc**bold**def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[bold]' . 'def'}.
	self assert: res second kind equals: #bold.

	res := self splitter splitString: 'abc** b old **def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[ b old ]' . 'def'}.
	self assert: res second kind equals: #bold.

]

{ #category : #tests }
MicIntraBlockSplitterTest >> testSplitBlockCode [
	| res |
	res := self splitter splitString: 'abc`block`def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[block]' . 'def'}.
	self assert: res second kind equals: #block
]

{ #category : #tests }
MicIntraBlockSplitterTest >> testSplitBlockImage [
	"Test the image annotation ![AltText](url)"

	| res |
	res := self splitter splitString: 'abc![AltText](imageAddress)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[AltText]' . 'last'}.
	self assert: res second url equals: 'imageAddress'
]

{ #category : #tests }
MicIntraBlockSplitterTest >> testSplitBlockItalics [
	| res |
	res := self splitter splitString: 'abc*italics*def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[italics]' . 'def'}.
	self assert: res second kind equals: #italics.
	
	res := self splitter splitString: 'abc* ita lics *def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[ ita lics ]' . 'def'}.
	self assert: res second kind equals: #italics.
]

{ #category : #tests }
MicIntraBlockSplitterTest >> testSplitBlockLink [
	"Test the link annotation [LinkText](url)"

	| res |
	res := self splitter splitString: 'abc[LinkText](myURL)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[LinkText]' . 'last'}.
	self assert: res second url equals: 'myURL'
]

{ #category : #tests }
MicIntraBlockSplitterTest >> testSplitBlockLinkIncomplete [
	"Test the annotation [LinkText] -> should return a link with url as linktext"

	| res |
	self skip.
	res := self splitter splitString: 'abc[LinkText]last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[LinkText]' . 'last'}.
	self assert: res second url equals: 'LinkText'
]

{ #category : #tests }
MicIntraBlockSplitterTest >> testSplitBlockLinkInlineImage [
	"Test the link annotation [![alttext](imageurl)](url)"

	| res |
	res := self splitter
		splitString: 'abc[![alttext](imageurl)](url)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[ [alttext]]' . 'last'}.
	self assert: res second children second url equals: 'imageurl'
]

{ #category : #tests }
MicIntraBlockSplitterTest >> testSplitBlockMultipleSequenceAnnotation [
	"Test with multiple annotations"

	| res |
	res := self splitter splitString: 'abc**abc**xyz`xyz`last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[abc]' . 'xyz' . '[xyz]' . 'last'}
]

{ #category : #tests }
MicIntraBlockSplitterTest >> testSplitBlockNested [
	"Test with nested annotations"

	| res |
	res := self splitter splitString: 'abc**bold*italic*bold**xyz'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[bold [italic] bold]' . 'xyz'}
]

{ #category : #tests }
MicIntraBlockSplitterTest >> testSplitBlockNoAnnotation [
	| res |
	res := self splitter splitString: 'abc'.
	self assert: res first printString equals: 'abc'.
	
	res := self splitter splitString: 'abc def gh'.
	self assert: res first printString equals: 'abc def gh'.
]

{ #category : #tests }
MicIntraBlockSplitterTest >> testSplitBlockStrike [
	| res |
	res := self splitter splitString: 'abc~strike~def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[strike]' . 'def'}.
	self assert: res second kind equals: #strike.
	
]

{ #category : #tests }
MicIntraBlockSplitterTest >> testSplitEmpty [
	| res |
	res := self splitter splitString: ''.
	self assert: res first printString equals: ''
]

{ #category : #tests }
MicIntraBlockSplitterTest >> testSplitExclamationMark [
	"Test that 'bla!bla' is ok, and not a failed image, same goes for '![goo]no parenthesis'"

	| res |
	res := self splitter splitString: 'bla!bla'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'bla!bla'}.
	res := self splitter splitString: '![goo]no parenthesis'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'![goo]no parenthesis'}
]

{ #category : #tests }
MicIntraBlockSplitterTest >> testSplitNotClosed [
	| res |
	res := self splitter splitString: 'abc**xyz'.
	self assert: res second printString equals: '[xyz]'.
	res := self splitter splitString: 'abc**xyz*'.
	self assert: res second printString equals: '[xyz*]'
]
