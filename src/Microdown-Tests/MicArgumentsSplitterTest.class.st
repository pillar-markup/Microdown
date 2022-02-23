"
A MicArgumentsSplitterTest is a test class for testing the behavior of MicArgumentsSplitter
"
Class {
	#name : #MicArgumentsSplitterTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests-Parser'
}

{ #category : #helpers }
MicArgumentsSplitterTest >> splitter [
	^ MicArgumentsSplitter
]

{ #category : #helpers }
MicArgumentsSplitterTest >> subjectUnderTestWith: aString [
	^ MicArgumentsSplitter withString: aString 
]

{ #category : #tests }
MicArgumentsSplitterTest >> testArguments [
	| subject |
	subject := self subjectUnderTestWith: 'foo=bar'.
	self assert: (subject arguments at: #foo) equals: 'bar'
]

{ #category : #tests }
MicArgumentsSplitterTest >> testCanInstantiate [
	| subject |
	subject := self subjectUnderTestWith: 'bla'.
	self assert: (subject isNotNil)
]

{ #category : #tests }
MicArgumentsSplitterTest >> testDefaultWithEmptyInput [
	| subject |
	subject := self splitter split: '' defaultArg: #language defaultValue: 'smalltalk'.
	self assert: (subject arguments) size equals: 1.
	self assert: subject arguments keys first equals: #language.
	self assert: (subject arguments at: #language) equals: 'smalltalk'
]

{ #category : #tests }
MicArgumentsSplitterTest >> testDefaultWithNoValue [
	| subject |
	subject := self splitter split: 'pharo' defaultArg: #language.
	self assert: (subject arguments) size equals: 1.
	self assert: subject arguments keys first equals: #language.
	self assert: (subject arguments at: #language) equals: 'pharo'
]

{ #category : #tests }
MicArgumentsSplitterTest >> testDefaultWithValue [
	| subject |
	subject := self splitter split: 'pharo' defaultArg: #language defaultValue: #smalltalk.
	self assert: (subject arguments) size equals: 1.
	self assert: subject arguments keys first equals: #language.
	self assert: (subject arguments at: #language) equals: 'pharo'
]

{ #category : #tests }
MicArgumentsSplitterTest >> testEmpty [
	| subject |
	subject := self subjectUnderTestWith: ''.
	self assert: (subject arguments) size equals: 1.
	self assert: subject arguments keys first equals: #defaultArg.
	self assert: (subject arguments at: #defaultArg) equals: ''
]

{ #category : #tests }
MicArgumentsSplitterTest >> testFirstTag [
	| subject |
	subject := self subjectUnderTestWith: 'bla'.
	self assert: (subject defaultValue) equals: 'bla'
]

{ #category : #tests }
MicArgumentsSplitterTest >> testFirstTagWithDelimiter [
	| subject |
	subject := self subjectUnderTestWith: 'foo|bar=99'.
	self assert: (subject defaultValue) equals: 'foo'
]

{ #category : #tests }
MicArgumentsSplitterTest >> testNameAndArguments [
	| subject |
	subject := self subjectUnderTestWith: 'aName|foo=bar'.
	self assert: (subject arguments includesKey: #foo).
	self assert: subject defaultValue equals: 'aName'.
]

{ #category : #tests }
MicArgumentsSplitterTest >> testNameWithDelimiter [
	| subject |
	subject := self subjectUnderTestWith: 'fooName|bar=foe'.
	self assert: (subject defaultValue) equals: 'fooName'
]

{ #category : #tests }
MicArgumentsSplitterTest >> testSeveralArguments [
	| subject |
	subject := self subjectUnderTestWith: 'foo=bar&caption=this is lovely&aaa=99'.
	self assert: (subject arguments) size equals: 4.
	self assert: (subject arguments at: #defaultArg) equals: ''.
	self assert: (subject arguments at: #foo) equals: 'bar'.
	self assert: (subject arguments at: #caption) equals: 'this is lovely'.
	self assert: (subject arguments values last) equals: '99'
]
