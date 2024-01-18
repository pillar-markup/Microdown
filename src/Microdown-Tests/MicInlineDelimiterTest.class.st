Class {
	#name : 'MicInlineDelimiterTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Tests-InlineParser',
	#package : 'Microdown-Tests',
	#tag : 'InlineParser'
}

{ #category : 'tests' }
MicInlineDelimiterTest >> testAddMe [
	"The delimiter dictionary should not be empty"
	self assert: MicInlineDelimiter all notEmpty.
	"all should be rightly placed"
	MicInlineDelimiter all do: [ :del |
		self assert: (MicInlineDelimiter at: del markup) equals: del
		 ].
	"All instances should have registred"
	Smalltalk garbageCollect.
	MicInlineDelimiter allInstances do: [ :del | 
		self assert: (MicInlineDelimiter at: del markup) equals: del
		 ].
]

{ #category : 'tests' }
MicInlineDelimiterTest >> testMarkupAsRegex [
	"this test is only for evaluated delimiters"
	(MicInlineDelimiter all select: #isEvaluated) do: [ :del | |regex|
		regex := del markupAsRegex asRegex.
		self assert: (regex matches: del markup  ).
		self assert: (regex search: ('aaa', del markup) ).
		self assert: (regex search: (del markup, 'aaa') ).
		 ]
]

{ #category : 'tests' }
MicInlineDelimiterTest >> testRawEvaluatedConsistency [
	"this test is only for evaluated delimiters"
	(MicInlineDelimiter all select: #isOpener) do: [ :del |
		self assert: (del isEvaluated ~= del isRawkind )
		 ]
]

{ #category : 'tests' }
MicInlineDelimiterTest >> testRegexNot [
	|not|
	not := (MicInlineDelimiter regexNot: 'ab').
	"string should not contain any occourance of ab"
	self assert: ('xxx' matchesRegex: not ). 
	self assert: ('xax' matchesRegex: not ). 
	self assert: ('xbx' matchesRegex: not ). 
	self assert: ('axb' matchesRegex: not ). 
	self deny: ('xab' matchesRegex: not ).
	self deny: ('abx' matchesRegex: not ).
	self deny: ('ab' matchesRegex: not ). 
]
