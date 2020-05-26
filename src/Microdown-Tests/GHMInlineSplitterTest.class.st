"
This class contains tests about the new approach to identify inline elements inside blocks.
"
Class {
	#name : #GHMInlineSplitterTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests'
}

{ #category : #tests }
GHMInlineSplitterTest >> splitter [
	^ GHMInlineSplitter new
]

{ #category : #tests }
GHMInlineSplitterTest >> testSplitBlock2 [
	"Test with multiple annotations"

	| res |
	res := self splitter start: 'abc**abc**xyz`xyz`last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[abc](bold)' . 'xyz' . '[xyz](monospace)' . 'last'}
]

{ #category : #tests }
GHMInlineSplitterTest >> testSplitBlockBold [
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
GHMInlineSplitterTest >> testSplitBlockCode [
	| res |
	res := self splitter start: 'abc`block`def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[block](monospace)' . 'def'}.
]

{ #category : #tests }
GHMInlineSplitterTest >> testSplitBlockItalics [
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
GHMInlineSplitterTest >> testSplitBlockMultipleSequenceAnnotation [
	"Test with multiple annotations"

	| res |
	res := self splitter start: 'abc**abc**xyz`xyz`last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[abc](bold)' . 'xyz' . '[xyz](monospace)' . 'last'}
]

{ #category : #tests }
GHMInlineSplitterTest >> testSplitBlockNested [
	"Test with nested annotations"
	| res |
	res := self splitter start: 'abc**bold_italic_bold**xyz'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[bold [italic](italic) bold](bold)' . 'xyz'}
]

{ #category : #tests }
GHMInlineSplitterTest >> testSplitBlockNoAnnotation [
	| res |
	res := self splitter start: 'abc'.
	self assert: res first printString equals: 'abc'.
	
	res := self splitter start: 'abc def gh'.
	self assert: res first printString equals: 'abc def gh'.
]

{ #category : #tests }
GHMInlineSplitterTest >> testSplitBlockStrike [
	| res |
	res := self splitter start: 'abc~strike~def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[strike](strike)' . 'def'}.
]

{ #category : #tests }
GHMInlineSplitterTest >> testSplitEmpty [
	| res |
	res := self splitter start: ''.
	self assert: res isEmpty
]

{ #category : #tests }
GHMInlineSplitterTest >> testSplitNotClosed [
	| res |
	res := self splitter start: 'abc**xyz'.
	self assert: res first printString equals: 'abc**xyz'.
]
