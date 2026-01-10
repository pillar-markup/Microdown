Class {
	#name : 'MicCodeCorrectSecondLineTest',
	#superclass : 'MicAbstractSanitizerTest',
	#category : 'Microdown-BookSanitizer-Tests',
	#package : 'Microdown-BookSanitizer-Tests'
}

{ #category : 'tests' }
MicCodeCorrectSecondLineTest >> testSanitize [

	| testMethod result |
	testMethod := 'test: aTest
	temp := 1 + 2.
    ^ temp.'.

	result := MicCodeCorrectSecondLine new sanitize: testMethod.

	self assert: result equals: 'test: aTest

	temp := 1 + 2.
    ^ temp.'
]

{ #category : 'tests' }
MicCodeCorrectSecondLineTest >> testSanitizeIsCorrect [

	| testMethod result |
	testMethod := 'test: aTest

	temp := 1 + 2.
    ^ temp.'.

	result := MicCodeCorrectSecondLine new sanitize: testMethod.

	self assert: result equals: 'test: aTest

	temp := 1 + 2.
    ^ temp.'
]

{ #category : 'tests' }
MicCodeCorrectSecondLineTest >> testSanitizeIsCorrectWithComments [

	| testMethod result |
	testMethod := 'test: aTest
	"there is comments"
	temp := 1 + 2.
    ^ temp.'.

	result := MicCodeCorrectSecondLine new sanitize: testMethod.

	self assert: result equals: 'test: aTest
	"there is comments"
	temp := 1 + 2.
    ^ temp.'
]
