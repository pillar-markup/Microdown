Class {
	#name : 'MicCodeBlockValitorTest',
	#superclass : 'TestCase',
	#category : 'Microdown-BookTester-Tests',
	#package : 'Microdown-BookTester-Tests'
}

{ #category : 'utilities' }
MicCodeBlockValitorTest >> parseAndTest: docText [
	| doc bTester |
	doc := Microdown parse: docText.
	bTester := MicCodeBlockValidator new.
	bTester start: doc.
	^ bTester
]

{ #category : 'tests - valid book tests' }
MicCodeBlockValitorTest >> testExampleCodeblock [
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
MicCodeBlockValitorTest >> testExampleCodeblockWithFailingTest [
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
MicCodeBlockValitorTest >> testExampleCodeblockWithFalseTest [

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
MicCodeBlockValitorTest >> testExampleCodeblockWithNoBrakets [

	| docText bTester |
	docText := '```example=true
3 + 12	
```
'.
	bTester := self parseAndTest: docText.
	self assertEmpty: bTester validTests.
	self assert: bTester failedTests size equals: 1.
	self assert: bTester failedTests first message equals: 'Instance of SmallInteger did not understand #key'
]

{ #category : 'tests - strange codeblock' }
MicCodeBlockValitorTest >> testExampleCodeblockWithTwoBrackets [
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
MicCodeBlockValitorTest >> testExampleEmptyCodeblockWithTwoBrackets [
	
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
MicCodeBlockValitorTest >> testExpectedFailureForAFailure [
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
MicCodeBlockValitorTest >> testExpectedFailureForARaisedException [
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
MicCodeBlockValitorTest >> testExplanationIsExceptionCatchedInFailingTest [
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
MicCodeBlockValitorTest >> testExplanationIsTestFailedWithoutException [
	
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
MicCodeBlockValitorTest >> testExplanationIsTestPassed [

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
MicCodeBlockValitorTest >> testNoExampleCodeblock [
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
MicCodeBlockValitorTest >> testThreeCodeBlocksWithTwoExamples [

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
