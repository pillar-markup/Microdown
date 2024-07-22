Class {
	#name : 'MicBookTesterVisitorTest',
	#superclass : 'TestCase',
	#category : 'Microdown-BookTester-Tests',
	#package : 'Microdown-BookTester-Tests'
}

{ #category : 'utilities' }
MicBookTesterVisitorTest >> parseAndTest: docText [
	| doc bTester |
	doc := Microdown parse: docText.
	bTester := MicBookTesterVisitor new.
	bTester start: doc.
	^ bTester
]

{ #category : 'tests - valid book tests' }
MicBookTesterVisitorTest >> testExampleCodeblock [
	| docText bTester |
	docText := '```example=true
3 + 4 
>>> 7
``` '.
	bTester := self parseAndTest: docText.
	self assertEmpty: bTester failedTests.
	self assert: bTester validTests size equals: 1
]

{ #category : 'tests - failing book tests' }
MicBookTesterVisitorTest >> testExampleCodeblockWithFailingTest [
	| docText bTester |
	docText := '```example=true
3 + ''12''
>>> 8		
```
'.
	bTester := self parseAndTest: docText.
	self assertEmpty: bTester validTests.
	self assert: bTester failedTests size equals: 1
]

{ #category : 'tests - failing book tests' }
MicBookTesterVisitorTest >> testExampleCodeblockWithFalseTest [

	| docText bTester |
	docText := '```example=true
3 + 4 
>>> 8		
```
'.
	bTester := self parseAndTest: docText.
	self assertEmpty: bTester validTests.
	self assert: bTester failedTests size equals: 1
]

{ #category : 'tests - failing book tests' }
MicBookTesterVisitorTest >> testExampleCodeblockWithNoBrakets [

	| docText bTester |
	docText := '```example=true
3 + 12	
```
'.
	bTester := self parseAndTest: docText.
	self assertEmpty: bTester validTests.
	self assert: bTester failedTests size equals: 1.
	self flag: #todo.
	self assert: bTester failedTests first message equals: 'Instance of SmallInteger did not understand #key'
]

{ #category : 'tests - strange codeblock' }
MicBookTesterVisitorTest >> testExampleCodeblockWithTwoBrackets [
	">> instead of > > > should not work so there is one failed test"
	
	| docText bTester |
	docText := '```example=true
3 + 12
>> 15
```
'.
	bTester := self parseAndTest: docText.
	self assertEmpty: bTester validTests.
	self assert: bTester failedTests size equals: 1.
]

{ #category : 'tests - strange codeblock' }
MicBookTesterVisitorTest >> testExampleEmptyCodeblockWithTwoBrackets [
	
	| docText bTester |
	docText := '```example=true
```
'.
	bTester := self parseAndTest: docText.
	self assertEmpty: bTester validTests.
	self assert: bTester failedTests size equals: 1.
	self flag: #todo.
	"the explanation should be better"
	
	self assert: bTester failedTests first message equals: '#key was sent to nil'
]

{ #category : 'tests - valid book tests' }
MicBookTesterVisitorTest >> testExpectedFailureForAFailure [
	| docText bTester |
	docText := '```example=true&expectedFailure=true
3 + 4 
>>> 12		
```
'.
	bTester := self parseAndTest: docText.
	self assertEmpty: bTester failedTests.
	self assert: bTester validTests size equals: 1
]

{ #category : 'tests - valid book tests' }
MicBookTesterVisitorTest >> testExpectedFailureForARaisedException [
	| docText bTester |
	docText := '```example=true&expectedFailure=true
3 + ''a'' 
>>> 12		
```
'.
	bTester := self parseAndTest: docText.
	self assertEmpty: bTester failedTests.
	self assert: bTester validTests size equals: 1
]

{ #category : 'tests - valid book tests' }
MicBookTesterVisitorTest >> testExplanationIsExceptionCatchedInFailingTest [
	| docText bTester |
	docText := '```example=true
3 + ''12''
>>> 8		
```
'.

	bTester := self parseAndTest: docText.
	self assertEmpty: bTester validTests.
	self assert: bTester failedTests size equals: 1.
	self assert: bTester failedTests first message equals: 'Instance of Character did not understand #adaptToNumber:andSend:'
]

{ #category : 'tests - valid book tests' }
MicBookTesterVisitorTest >> testExplanationIsTestFailedWithoutException [
	
	| docText bTester |
	docText := '```example=true
3 + 13
>>> 15		
```
'.
	bTester := self parseAndTest: docText.
	self assertEmpty: bTester validTests.
	self assert: bTester failedTests size equals: 1.
	self assert: bTester failedTests first message equals: 'Test failed without raising an exception'
]

{ #category : 'tests - valid book tests' }
MicBookTesterVisitorTest >> testExplanationIsTestPassed [

	| docText bTester |
	docText := '```example=true
3 + 12
>>> 15		
```
'.
	bTester := self parseAndTest: docText.
	self assert: bTester validTests size equals: 1.
	self assertEmpty: bTester failedTests.
	self assert: bTester validTests first message equals: 'Test passed'
]

{ #category : 'tests - no example' }
MicBookTesterVisitorTest >> testNoExampleCodeblock [
	| docText bTester |
	docText := '```
3 + 4 
>>> 7		
```
'.
	bTester := self parseAndTest: docText.
	self assertEmpty: bTester failedTests.
	self assertEmpty: bTester validTests
]

{ #category : 'tests - no example' }
MicBookTesterVisitorTest >> testThreeCodeBlocksWithTwoExamples [

	| docText bTester |
	docText := 
'```example=true
3 + 4 
>>> 7		
```

```example=true
3 + 4 
>>> 8
```

```
3 + ''4'' 
>>> 7		
```
'.
	bTester := self parseAndTest: docText.
	self assert: bTester failedTests size equals: 1.
	self assert: bTester validTests size equals: 1.
]
