Class {
	#name : 'MicBookTesterVisitorTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Tests-BookTester',
	#package : 'Microdown-Tests-BookTester'
}

{ #category : 'tests' }
MicBookTesterVisitorTest >> parseAndTest: docText [
	| doc bTester |
	doc := Microdown parse: docText.
	bTester := MicrodownBookTesterVisitor new.
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
MicBookTesterVisitorTest >> testMultipleCodeAllCorrectBlock [ 
|content doc visitor|

content := ' 
```langage=pharo
4+4
>>>
8
```
```langage=pharo
4+2
>>>
6
```
```langage=pharo
4+0
>>>
4
``` ' .
	doc := Microdown parse: content . 
	visitor := MicrodownBookTesterVisitor new .
	doc accept: visitor .
	self assert: visitor isOk . 
]

{ #category : 'tests' }
MicBookTesterVisitorTest >> testMultipleCodeIncorrectBlock [ 
|content doc visitor|

content := ' 
```langage=pharo
4+4
>>>
8
```
```langage=pharo
4+2
>>>
8
```
```langage=pharo
4+0
>>>
9
``` ' .
	doc := Microdown parse: content . 
	visitor := MicrodownBookTesterVisitor new .
	doc accept: visitor .
	self deny: visitor isOk . 
]

{ #category : 'tests' }
MicBookTesterVisitorTest >> testOneCorrectCodeBlock [ 
|content doc visitor|
	content := ' 
 ```langage=pharo
 4+4
 >>>
 8
 ``` ' . 
	doc := Microdown parse: content . 
	visitor := MicrodownBookTesterVisitor new .
	doc accept: visitor .
	self assert: visitor isOk . 
]

{ #category : 'tests' }
MicBookTesterVisitorTest >> testOneIncorrectcCodeBlock [ 
|content doc visitor|

content := ' 
```langage=pharo
4+4
>>>
9
```
 ' .
	doc := Microdown parse: content . 
	visitor := MicrodownBookTesterVisitor new .
	doc accept: visitor .
	self deny: visitor isOk . 
]
