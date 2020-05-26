"
An IntraBlockSplitterTest is a test class for testing the behavior of IntraBlockSplitter
"
Class {
	#name : #IntraBlockSplitterTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests'
}

{ #category : #tests }
IntraBlockSplitterTest >> splitter [
	^ GHMIntraBlockSplitter new
]

{ #category : #tests }
IntraBlockSplitterTest >> testSplitBlock2 [
	"Test with multiple annotations"

	| res |
	res := self splitter splitString: 'abc**abc**xyz`xyz`last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[abc]' . 'xyz' . '[xyz]' . 'last'}
]

{ #category : #tests }
IntraBlockSplitterTest >> testSplitBlockBold [
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
IntraBlockSplitterTest >> testSplitBlockCode [
	| res |
	res := self splitter splitString: 'abc`block`def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[block]' . 'def'}.
	self assert: res second kind equals: #block
]

{ #category : #tests }
IntraBlockSplitterTest >> testSplitBlockImage [
	"Test the image annotation ![AltText](url)"

	| res |
	res := self splitter splitString: 'abc![AltText](imageAddress)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[AltText]' . 'last'}.
	self assert: res second url equals: 'imageAddress'
]

{ #category : #tests }
IntraBlockSplitterTest >> testSplitBlockItalics [
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
IntraBlockSplitterTest >> testSplitBlockLink [
	"Test the link annotation [LinkText](url)"

	| res |
	res := self splitter splitString: 'abc[LinkText](myURL)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[LinkText]' . 'last'}.
	self assert: res second url equals: 'myURL'
]

{ #category : #tests }
IntraBlockSplitterTest >> testSplitBlockLinkIncomplete [
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
IntraBlockSplitterTest >> testSplitBlockLinkInlineImage [
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
IntraBlockSplitterTest >> testSplitBlockMultipleSequenceAnnotation [
	"Test with multiple annotations"

	| res |
	res := self splitter splitString: 'abc**abc**xyz`xyz`last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[abc]' . 'xyz' . '[xyz]' . 'last'}
]

{ #category : #tests }
IntraBlockSplitterTest >> testSplitBlockNested [
	"Test with nested annotations"

	| res |
	res := self splitter splitString: 'abc**bold*italic*bold**xyz'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[bold [italic] bold]' . 'xyz'}
]

{ #category : #tests }
IntraBlockSplitterTest >> testSplitBlockNoAnnotation [
	| res |
	res := self splitter splitString: 'abc'.
	self assert: res first printString equals: 'abc'.
	
	res := self splitter splitString: 'abc def gh'.
	self assert: res first printString equals: 'abc def gh'.
]

{ #category : #tests }
IntraBlockSplitterTest >> testSplitBlockStrike [
	| res |
	res := self splitter splitString: 'abc~strike~def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[strike]' . 'def'}.
	self assert: res second kind equals: #strike.
	
]

{ #category : #tests }
IntraBlockSplitterTest >> testSplitEmpty [
	| res |
	res := self splitter splitString: ''.
	self assert: res first printString equals: ''
]

{ #category : #tests }
IntraBlockSplitterTest >> testSplitExclamationMark [
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
IntraBlockSplitterTest >> testSplitNotClosed [
	| res |
	res := self splitter splitString: 'abc**xyz'.
	self assert: res second printString equals: '[xyz]'.
	res := self splitter splitString: 'abc**xyz*'.
	self assert: res second printString equals: '[xyz*]'
]
