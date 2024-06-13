Class {
	#name : 'MicResultTest',
	#superclass : 'TestCase',
	#category : 'Microdown-BookTester-Tests',
	#package : 'Microdown-BookTester-Tests'
}

{ #category : 'tests' }
MicResultTest >> testErrorAnchorIsMissing [

	| doc validator |
	doc := Microdown parse: '# Section 
@anchorSection0

# Section 1
@anchorSection1

See *@anchorSection1@* and *@anchorSection2@* and *@anchorSection2@* and *@anchorSection3@*

'.
	validator := MicReferenceChecker new.
	doc accept: validator .
	self assert: validator isFailure .
	self assert: validator allTestsResults first explanation equals: ( MicResult allMessages at: #anchorIsMissing).
	self assert: validator allTestsResults first specification equals: 'anchorSection2'
	
]
