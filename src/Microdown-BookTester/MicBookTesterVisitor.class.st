"
i visit code blocks and make sure that evaluation is correct 
"
Class {
	#name : 'MicBookTesterVisitor',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'allTestResults'
	],
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'testing' }
MicBookTesterVisitor class >> isAbstract [
	<ignoreForCoverage "This method is ignored for test coverage because it is overriden in all subclasses and these subclasses don't need to do a super-send.">
	^ false
]

{ #category : 'accessing' }
MicBookTesterVisitor >> allTestResults [

	^ allTestResults
]

{ #category : 'accessing' }
MicBookTesterVisitor >> allTestResults: anObject [

	allTestResults := anObject
]

{ #category : 'visiting' }
MicBookTesterVisitor >> checkAssociation: aCodeBlockObject [
	"Asserts  the association created in any codeBlock "

	| association |
	association := self class compiler evaluate: aCodeBlockObject text.
	^ association key = association value
]

{ #category : 'visiting' }
MicBookTesterVisitor >> executeAndReportIn: aCodeBlockObject [
	"aCodeBlockObject is an instance of The MicrodownTestResult"

	| isCorrect |
	isCorrect := false.
	[ isCorrect := self checkAssociation: aCodeBlockObject ]
		on: Exception
		do: [ :exception | aCodeBlockObject explanation: exception asString ].
	aCodeBlockObject status: isCorrect.
	isCorrect ifTrue: [ aCodeBlockObject explanation: 'Test passed' ]
]

{ #category : 'visiting' }
MicBookTesterVisitor >> failedTests [
	"Returns the failed tests within the test results"
	^ allTestResults select: [ :each | each isFailed ]
]

{ #category : 'initialization' }
MicBookTesterVisitor >> initialize [
	super initialize.
	allTestResults := OrderedCollection new.
]

{ #category : 'visiting' }
MicBookTesterVisitor >> isOk [ 
	| checkingVariable |
	checkingVariable := true.
	allTestResults do: [ :each | checkingVariable := checkingVariable and: [ each isPaired ] ].
	^ checkingVariable
]

{ #category : 'accessing' }
MicBookTesterVisitor >> start: anObject [ 
	anObject accept: self . 
	
]

{ #category : 'testing' }
MicBookTesterVisitor >> validTests [
	"Returns all passed tests"
	^ allTestResults select: [ :each | each isValid ]
]

{ #category : 'visiting' }
MicBookTesterVisitor >> visitCode: aCodeBlock [
	"Creates an instance of PRBookTestResult with parameters depending of the type of the codeblock. 
	Here it is for an example and therefore uses the specialized exmple methods
	textForTestcase
	executeAndReportExample:
	Note that there is no fragmentedText here, no need for it b/ecause the codeblock text contains the whole text and is the equivalent of  Playground execution"

	aCodeBlock isExample
		ifTrue: [
			| result |
			result := MicBookTestResult new.
			result text: aCodeBlock code.
			allTestResults add: result.
			self executeAndReportIn: result.
			aCodeBlock isExpectedFailure ifTrue: [
				result status: result status not ] ]
]
