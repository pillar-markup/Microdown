Class {
	#name : 'MicBookTesterVisitorTest',
	#superclass : 'TestCase',
	#category : 'Microdown-BookTester-Tests',
	#package : 'Microdown-BookTester-Tests'
}

{ #category : 'tests' }
MicBookTesterVisitorTest >> parseAndTest: docText [
	| doc bTester |
	doc := Microdown parse: docText.
	bTester := MicBookTesterVisitor new.
	bTester start: doc.
	^ bTester
]

{ #category : 'tests' }
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

{ #category : 'tests' }
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

{ #category : 'tests' }
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

{ #category : 'tests' }
MicBookTesterVisitorTest >> testExampleCodeblockWithNoBrakets [
	| docText bTester |
	docText := '```example=true
3 + 12	
```
'.
	bTester := self parseAndTest: docText.
	self assertEmpty: bTester validTests.
	self assert: bTester failedTests size equals: 1
]

{ #category : 'tests' }
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
	self assert: bTester failedTests size equals: 1
]

{ #category : 'tests' }
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

{ #category : 'tests' }
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

{ #category : 'tests' }
MicBookTesterVisitorTest >> testExplanationIsExceptionCatchedInFailingTest [
	| docText doc bTester |
	docText := '```example=true
3 + ''12''
>>> 8		
```
'.
	doc := Microdown parse: docText.
	bTester := MicBookTesterVisitor new.
	bTester start: doc.
	self assertEmpty: bTester validTests.
	self assert: bTester failedTests size equals: 1.
	self assert: bTester failedTests first explanation equals: 'Instance of Character did not understand #adaptToNumber:andSend:'
]

{ #category : 'tests' }
MicBookTesterVisitorTest >> testExplanationIsTestFailedWithoutException [
	| docText doc bTester |
	docText := '```example=true
3 + 13
>>> 15		
```
'.
	doc := Microdown parse: docText.
	bTester := MicBookTesterVisitor new.
	bTester start: doc.
	self assertEmpty: bTester validTests.
	self assert: bTester failedTests size equals: 1.
	self assert: bTester failedTests first explanation equals: 'Test failed without raising an exception'
]

{ #category : 'tests' }
MicBookTesterVisitorTest >> testExplanationIsTestPassed [
	| docText doc bTester |
	docText := '```example=true
3 + 12
>>> 15		
```
'.
		doc := Microdown parse: docText.
	bTester := MicBookTesterVisitor new.
	bTester start: doc.
	self assert: bTester validTests size equals: 1.
	self assertEmpty: bTester failedTests.
	self assert: bTester validTests first explanation equals: 'Test passed'
]

{ #category : 'tests' }
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

{ #category : 'tests' }
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
