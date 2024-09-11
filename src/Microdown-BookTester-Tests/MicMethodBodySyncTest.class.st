Class {
	#name : 'MicMethodBodySyncTest',
	#superclass : 'TestCase',
	#category : 'Microdown-BookTester-Tests',
	#package : 'Microdown-BookTester-Tests'
}

{ #category : 'data' }
MicMethodBodySyncTest class >> simpleCode [
	"The comment of simpleCode"
	
	^ 100 slowFactorial
]

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

{ #category : 'tests - not reported' }
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

{ #category : 'tests - broken input' }
MicMethodBodySyncTest >> testMetaclassInOriginSpecification [

	| docText bTester |
	docText := '```sync=true&origin=MicMethodBodySyncTest class>>#simpleCode
simpleCode
	"The comment of simpleCode"
	
	^ 100 slowFactorial
``` '.

	bTester := self parseAndTest: docText.
	self assert: bTester results isEmpty
]

{ #category : 'tests - broken input' }
MicMethodBodySyncTest >> testMetaclassWithSpacesInOriginSpecification [

	| docText bTester |
	docText := '```sync=true&origin=MicMethodBodySyncTest  class >>#simpleCode
simpleCode
	"The comment of simpleCode"
	
	^ 100 slowFactorial
``` '.

	bTester := self parseAndTest: docText.
	self assert: bTester results isEmpty
]

{ #category : 'tests - broken input' }
MicMethodBodySyncTest >> testMetaclassWithStartingSpacesInOriginSpecification [

	| docText bTester |
	docText := '```sync=true&origin= MicMethodBodySyncTest  class >>#simpleCode
simpleCode
	"The comment of simpleCode"
	
	^ 100 slowFactorial
``` '.

	bTester := self parseAndTest: docText.
	self assert: bTester results isEmpty
]

{ #category : 'tests - broken input' }
MicMethodBodySyncTest >> testReportCodeBlockInSyncWithMetaclassMethod [

	| docText bTester |
	docText := '```sync=true&origin=MicMethodBodySyncTest class>>#simpleCode
simpleCode
	"The comment of simpleCode"
	
	^ 100 slowFactorial
``` '.

	bTester := self parseAndTest: docText.
	self assert: bTester results isEmpty
]

{ #category : 'tests' }
MicMethodBodySyncTest >> testReportCodeblockIsInSync [

	| docText bTester |
	docText := '```sync=true&origin=MicMethodBodySyncTest>>#simpleCode
simpleCode
	"The comment of simpleCode"
	
	^ 100 slowFactorial
``` '.

	bTester := self parseAndTest: docText.
	self assert: bTester results isEmpty
	
]

{ #category : 'tests - broken sync' }
MicMethodBodySyncTest >> testReportCodeblockWithBrokenSync [
	"even if the code is in sync reports that the sync declaration is bogus"
	
	| bTester brokenHeaderString methodDef report |
	brokenHeaderString := '```sync=FooBar&origin=MicMethodBodySyncTest>>#simpleCode'.
	methodDef := 
'simpleCode
	"The comment of simpleCode"
	
	^ 100 slowFactorial'.

	bTester := self parseAndTest: brokenHeaderString, Character cr asString, methodDef, Character cr asString, '```'.
	
	self assert: (self class >> #simpleCode) sourceCode equals: methodDef.
	report := bTester results first.
	self assert: report class equals: MicBrokenSyncDefinition.
	self assert: report syncValue equals: 'FooBar'
	
]

{ #category : 'tests - broken sync' }
MicMethodBodySyncTest >> testReportCodeblockWithBrokenSyncDeclaration [

	| bTester headerString methodDef |
	headerString := '```sync=fooBar&origin=MicMethodBodySyncTest>>#simpleCode'.
	methodDef := 
'simpleCode
	"This is not the definition of simpleCode"
	
	^ 100 slowFactorial + 100'.

	bTester := self parseAndTest: headerString, Character cr asString , methodDef, Character cr asString, '```'.
	self deny: bTester results isEmpty.
	
]

{ #category : 'tests' }
MicMethodBodySyncTest >> testReportsCodeblockIsNotInSync [

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

{ #category : 'tests - broken input' }
MicMethodBodySyncTest >> testUnexistingClassInOriginSpecification [

	| docText bTester result |
	docText := '```sync=true&origin=MicMethodBodySyncTestDOESNNO>>#simpleCode
simpleCode
	"The comment of simpleCode"
	
	^ 100 slowFactorial
``` '.

	bTester := self parseAndTest: docText.
	result := bTester results first.
	self assert: result class equals: MicBrokenSyncOriginDefinition 
	
]

{ #category : 'tests - broken input' }
MicMethodBodySyncTest >> testUnexistingMethodInOriginSpecification [

	| docText bTester result |
	docText := '```sync=true&origin=MicMethodBodySyncTest>>#DoesNotExist
simpleCode
	"The comment of simpleCode"
	
	^ 100 slowFactorial
``` '.

	bTester := self parseAndTest: docText.
	result := bTester results first.
	self assert: result class equals: MicBrokenSyncOriginDefinition 
	
]
