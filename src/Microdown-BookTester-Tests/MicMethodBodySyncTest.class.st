Class {
	#name : 'MicMethodBodySyncTest',
	#superclass : 'TestCase',
	#category : 'Microdown-BookTester-Tests',
	#package : 'Microdown-BookTester-Tests'
}

{ #category : 'data' }
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

{ #category : 'tests - broken input' }
MicMethodBodySyncTest >> testBrokenOriginSpecification [

	| docText bTester |
	docText := '```sync=&origin=MicMethodBodySyncTest>>#simpleCode
simpleCode
	"The comment of simpleCode"
	
	^ 100 slowFactorial
``` '.

	bTester := self parseAndTest: docText.
	self assert: bTester results isEmpty
	
]

{ #category : 'tests' }
MicMethodBodySyncTest >> testCodeblockIsNotInSync [

	| bTester brokenCodeResult headerString methodDef |
	headerString := '```sync=true&origin=MicMethodBodySyncTest>>#simpleCode'.
	methodDef := 
'simpleCode
	"This is not the definition of simpleCode"
	
	^ 100 slowFactorial + 100'.

	bTester := self parseAndTest: headerString, Character cr asString , methodDef, Character cr asString, '```'.
	brokenCodeResult := bTester results first.
	
	self 
		assert: brokenCodeResult originString 
		equals: 'MicMethodBodySyncTest>>#simpleCode'.
]

{ #category : 'tests' }
MicMethodBodySyncTest >> testCodeblockIsNotInSyncButShouldNotBeReported [

	| bTester headerString methodDef |
	headerString := '```sync=false&origin=MicMethodBodySyncTest>>#simpleCode'.
	methodDef := 
'simpleCode
	"This is not the definition of simpleCode"
	
	^ 100 slowFactorial + 100'.

	bTester := self parseAndTest: headerString, Character cr asString , methodDef, Character cr asString, '```'.
	self assert: bTester results isEmpty.
	
]

{ #category : 'tests' }
MicMethodBodySyncTest >> testCodeblockIsNotInSyncCheckingResultAttributes [

	| bTester brokenCodeResult headerString methodDef |
	headerString := '```sync=true&origin=MicMethodBodySyncTest>>#simpleCode'.
	methodDef := 
'simpleCode
	"This is not the definition of simpleCode"
	
	^ 100 slowFactorial + 100'.

	bTester := self parseAndTest: headerString, Character cr asString , methodDef, Character cr asString, '```'.
	brokenCodeResult := bTester results first.
	
	self 
		assert: brokenCodeResult originString 
		equals: 'MicMethodBodySyncTest>>#simpleCode'.
	self 
		assert: brokenCodeResult bookContents 
		equals: methodDef. 
	self 
		assert: brokenCodeResult imageContents 
		equals: (self class >> #simpleCode) sourceCode
]

{ #category : 'tests' }
MicMethodBodySyncTest >> testCodeblockShouldBeInSync [

	| docText bTester |
	docText := '```sync=true&origin=MicMethodBodySyncTest>>#simpleCode
simpleCode
	"The comment of simpleCode"
	
	^ 100 slowFactorial
``` '.

	bTester := self parseAndTest: docText.
	self assert: bTester results isEmpty
	
]
