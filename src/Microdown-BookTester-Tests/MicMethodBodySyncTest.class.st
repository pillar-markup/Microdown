Class {
	#name : 'MicMethodBodySyncTest',
	#superclass : 'TestCase',
	#category : 'Microdown-BookTester-Tests',
	#package : 'Microdown-BookTester-Tests'
}

{ #category : 'tests' }
MicMethodBodySyncTest >> parseAndTest: docText [

	| doc bTester |
	doc := Microdown parse: docText.
	bTester := MicBookTesterVisitor new.
	bTester start: doc.
	^ bTester
]

{ #category : 'data' }
MicMethodBodySyncTest >> simpleCode [
	"The comment of simpleCode"
	
	^ 100 slowFactorial
]

{ #category : 'tests' }
MicMethodBodySyncTest >> testCodeblockShouldBeInSync [

	| docText bTester |
	docText := '```sync=MicMethodBodySyncTest>>#simpleCode
simpleCode
	"The comment of simpleCode"
	
	^ 100 slowFactorial
``` '.

	bTester := self parseAndTest: docText.
	self halt.
	
]
