"
This class contains tests about the new approach to identify inline elements inside blocks.
"
Class {
	#name : #MicInlineSplitterTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests'
}

{ #category : #tests }
MicInlineSplitterTest >> splitter [
	^ MicInlineSplitter new
]

{ #category : #tests }
MicInlineSplitterTest >> testEscapeCharacter [
	"Test the escape \ in simple case (here, bold one)"

	| res |
	res := self splitter start: 'abc\**test**last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc**test**last'}.
]

{ #category : #tests }
MicInlineSplitterTest >> testEscapeCharacterAtBeginning [
	"Test the escape \ in simple case (here, bold one)"

	| res |
	res := self splitter start: '\**test**'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'**test**'}.
]

{ #category : #tests }
MicInlineSplitterTest >> testEscapeCharacterInLinkName [
	"Test the escape \ in link description"

	| res |
	res := self splitter start: 'abc[\**test**](myURL)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[**test**](linkName)' . 'last'}.
	self assert: res second url equals: 'myURL'
]

{ #category : #tests }
MicInlineSplitterTest >> testEscapeCharacterInNestedLinkName [
	"Test the escape \ in case of nested linknames"

	| res |
	res := self splitter start: 'abc[\[nested\]](myURL)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[[nested]](linkName)' . 'last'}.
	self assert: res second url equals: 'myURL'
]

{ #category : #tests }
MicInlineSplitterTest >> testSplitBlock2 [
	"Test with multiple annotations"

	| res |
	res := self splitter start: 'abc**abc**xyz`xyz`last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[abc](bold)' . 'xyz' . '[xyz](monospace)' . 'last'}
]

{ #category : #tests }
MicInlineSplitterTest >> testSplitBlockBold [
	| res |
	res := self splitter start: 'abc**bold**def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[bold](bold)' . 'def'}.
	self assert: res second kind equals: #bold.

	res := self splitter start: 'abc** b old **def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[ b old ](bold)' . 'def'}.
	self assert: res second kind equals: #bold.

]

{ #category : #tests }
MicInlineSplitterTest >> testSplitBlockCode [
	| res |
	res := self splitter start: 'abc`block`def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[block](monospace)' . 'def'}.
]

{ #category : #tests }
MicInlineSplitterTest >> testSplitBlockImage [
	"Test the image annotation ![AltText](url)"

	| res |
	res := self splitter start: 'abc![AltText](imageAddress)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[AltText](figure)' . 'last'}.
	self assert: res second url equals: 'imageAddress'
]

{ #category : #tests }
MicInlineSplitterTest >> testSplitBlockItalics [
	| res |
	res := self splitter start: 'abc_italics_def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[italics](italic)' . 'def'}.
	
	res := self splitter start: 'abc_ ita lics _def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[ ita lics ](italic)' . 'def'}.
]

{ #category : #tests }
MicInlineSplitterTest >> testSplitBlockLink [
	"Test the link annotation [LinkText](url)"

	| res |
	res := self splitter start: 'abc[LinkText](myURL)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[LinkText](linkName)' . 'last'}.
	self assert: res second url equals: 'myURL'
]

{ #category : #tests }
MicInlineSplitterTest >> testSplitBlockLinkIncomplete [
	"Test the annotation [LinkText] -> should return a link with url as linktext"

	| res |
	self skip.
	res := self splitter start: 'abc[LinkText]last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[LinkText](linkName)' . 'last'}.
	self assert: res second url equals: 'LinkText'
]

{ #category : #tests }
MicInlineSplitterTest >> testSplitBlockLinkInlineImage [
	"Test the link annotation [![alttext](imageurl)](url)"

	| res |
	self skip.
	res := self splitter
		start: 'abc[![alttext](imageurl)](url)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[[alttext](figure)](linkName)' . 'last'}.
	self assert: res second children second url equals: 'imageurl'
]

{ #category : #tests }
MicInlineSplitterTest >> testSplitBlockMultipleSequenceAnnotation [
	"Test with multiple annotations"

	| res |
	res := self splitter start: 'abc**abc**xyz`xyz`last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[abc](bold)' . 'xyz' . '[xyz](monospace)' . 'last'}
]

{ #category : #tests }
MicInlineSplitterTest >> testSplitBlockNested [
	"Test with nested annotations"
	| res |
	res := self splitter start: 'abc**bold_italic_bold**xyz'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[bold [italic](italic) bold](bold)' . 'xyz'}
]

{ #category : #tests }
MicInlineSplitterTest >> testSplitBlockNoAnnotation [
	| res |
	res := self splitter start: 'abc'.
	self assert: res first printString equals: 'abc'.
	
	res := self splitter start: 'abc def gh'.
	self assert: res first printString equals: 'abc def gh'.
]

{ #category : #tests }
MicInlineSplitterTest >> testSplitBlockStrike [
	| res |
	res := self splitter start: 'abc~strike~def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[strike](strike)' . 'def'}.
]

{ #category : #tests }
MicInlineSplitterTest >> testSplitEmpty [
	| res |
	res := self splitter start: ''.
	self assert: res isEmpty
]

{ #category : #tests }
MicInlineSplitterTest >> testSplitExclamationMark [
	"Test that 'bla!bla' is ok, and not a failed image, same goes for '![goo]no parenthesis'"

	| res |
	res := self splitter start: 'bla!bla'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'bla!bla'}.
	res := self splitter start: '![goo]no parenthesis'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'![goo]no parenthesis'}
]

{ #category : #tests }
MicInlineSplitterTest >> testSplitMathCode [
	| res |
	res := self splitter start: 'abc$math env$def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[math env](math)' . 'def'}.
]

{ #category : #tests }
MicInlineSplitterTest >> testSplitMathRaw [
	| res |
	res := self splitter start: 'abc{{someRaw}}def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[someRaw](raw)' . 'def'}.
]

{ #category : #tests }
MicInlineSplitterTest >> testSplitNotClosed [
	| res |
	res := self splitter start: 'abc**xyz'.
	self assert: res first printString equals: 'abc**xyz'.
]
