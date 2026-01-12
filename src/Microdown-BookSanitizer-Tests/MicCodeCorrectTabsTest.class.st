Class {
	#name : 'MicCodeCorrectTabsTest',
	#superclass : 'MicAbstractSanitizerTest',
	#category : 'Microdown-BookSanitizer-Tests',
	#package : 'Microdown-BookSanitizer-Tests'
}

{ #category : 'tests' }
MicCodeCorrectTabsTest >> testSanitize [

	| testMethod result |
	testMethod := 'test: aTest
	temp := 1 + 2.
	^ temp.'.

	result := MicCodeCorrectTabs new sanitize: testMethod.

	self assert: result equals: 'test: aTest
	temp := 1 + 2.
	^ temp.'
]

{ #category : 'tests' }
MicCodeCorrectTabsTest >> testSanitizeIsCorrect [

	| testMethod result |
	testMethod := 'test: aTest
	temp := 1 + 2.
	^ temp.'.

	result := MicCodeCorrectTabs new sanitize: testMethod.

	self assert: result equals: 'test: aTest
	temp := 1 + 2.
	^ temp.'
]

{ #category : 'tests' }
MicCodeCorrectTabsTest >> testSanitizeSpaces [

	| testMethod result |
	testMethod := 'test: aTest
   temp := 1 + 2.
  ^ temp.'.

	result := MicCodeCorrectTabs new sanitize: testMethod.

	self assert: result equals: 'test: aTest
	temp := 1 + 2.
  ^ temp.'
]
