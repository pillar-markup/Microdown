"
A MicArgumentsSplitterTest is a test class for testing the behavior of MicArgumentsSplitter
"
Class {
	#name : #MicArgumentsSplitterTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests-Parser'
}

{ #category : #helpers }
MicArgumentsSplitterTest >> subjectUnderTestWith: aString [
	^ MicArgumentsSplitter withString: aString 
]

{ #category : #tests }
MicArgumentsSplitterTest >> testArguments [
	| subject |
	subject := self subjectUnderTestWith: 'foo=bar'.
	self assert: (subject arguments) size equals: 1.
	self assert: (subject arguments at: #foo) equals: 'bar'
]

{ #category : #tests }
MicArgumentsSplitterTest >> testCanInstantiate [
	| subject |
	subject := self subjectUnderTestWith: 'bla'.
	self assert: (subject isNotNil)
]

{ #category : #tests }
MicArgumentsSplitterTest >> testFirstTag [
	| subject |
	subject := self subjectUnderTestWith: 'bla'.
	self assert: (subject firstTag) equals: 'bla'
]

{ #category : #tests }
MicArgumentsSplitterTest >> testFirstTagWithAssignment [
	| subject |
	subject := self subjectUnderTestWith: 'foo=bar'.
	self assert: (subject firstTag) equals: 'foo'
]

{ #category : #tests }
MicArgumentsSplitterTest >> testFirstTagWithDelimiter [
	| subject |
	subject := self subjectUnderTestWith: 'foo|bar=99'.
	self assert: (subject firstTag) equals: 'foo'
]

{ #category : #tests }
MicArgumentsSplitterTest >> testName [
	| subject |
	subject := self subjectUnderTestWith: 'fooName'.
	self assert: (subject name) equals: 'fooName'
]

{ #category : #tests }
MicArgumentsSplitterTest >> testNameAndArguments [
	| subject |
	subject := self subjectUnderTestWith: 'aName|foo=bar'.
	self assert: (subject arguments) size equals: 1.
	self assert: (subject arguments includesKey: #foo).
	self assert: subject name equals: 'aName'.
]

{ #category : #tests }
MicArgumentsSplitterTest >> testNameWithAssignment [
	| subject |
	subject := self subjectUnderTestWith: 'fooName=bar&other=88'.
	self assert: (subject name) equals: nil
]

{ #category : #tests }
MicArgumentsSplitterTest >> testNameWithDelimiter [
	| subject |
	subject := self subjectUnderTestWith: 'fooName|bar=foe'.
	self assert: (subject name) equals: 'fooName'
]

{ #category : #tests }
MicArgumentsSplitterTest >> testSeveralArguments [
	| subject |
	subject := self subjectUnderTestWith: 'foo=bar&caption=this is lovely&aaa=99'.
	self assert: (subject arguments) size equals: 3.
	self assert: (subject arguments at: #foo) equals: 'bar'.
	self assert: (subject arguments at: #caption) equals: 'this is lovely'.
	self assert: (subject arguments values last) equals: '99'
]
