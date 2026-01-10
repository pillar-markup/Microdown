Class {
	#name : 'MicAddParagraphLabelPeriodTest',
	#superclass : 'MicAbstractSanitizerTest',
	#category : 'Microdown-BookSanitizer-Tests',
	#package : 'Microdown-BookSanitizer-Tests'
}

{ #category : 'tests' }
MicAddParagraphLabelPeriodTest >> testSanitize [

	| testMethod result |
	testMethod := 'test: aTest
  temp := 1 + 2.
    ^ temp'.

	result := MicCodeEndWithoutPeriod new sanitize: testMethod.

	self assert: result equals: 'test: aTest
  temp := 1 + 2.
    ^ temp'
]

{ #category : 'tests' }
MicAddParagraphLabelPeriodTest >> testSanitizeIsCorrect [

	| testMethod result |
	testMethod := 'test: aTest
  temp := 1 + 2.
    ^ temp.'.

	result := MicCodeEndWithoutPeriod new sanitize: testMethod.

	self assert: result equals: 'test: aTest
  temp := 1 + 2.
    ^ temp'
]
