"
i visit code blocks and make sure that evaluation is correct 
"
Class {
	#name : 'MicrodownBookTesterVisitor',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'allTestResults'
	],
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'testing' }
MicrodownBookTesterVisitor class >> isAbstract [
	<ignoreForCoverage "This method is ignored for test coverage because it is overriden in all subclasses and these subclasses don't need to do a super-send.">
	^ false
]

{ #category : 'accessing' }
MicrodownBookTesterVisitor >> allTestResults [

	^ allTestResults
]

{ #category : 'accessing' }
MicrodownBookTesterVisitor >> allTestResults: anObject [

	allTestResults := anObject
]

{ #category : 'visiting' }
MicrodownBookTesterVisitor >> checkAssociation: aCodeBlockObject [
	"Asserts  the association created in any codeBlock "
	^ (self class  compiler evaluate: aCodeBlockObject text ) isPaired .
]

{ #category : 'visiting' }
MicrodownBookTesterVisitor >> excuteAndReportExample: aCodeBlockObject [
"aCodeBlockObject is an instance of The MicrodownTestResult"
	| isCorrect |
	isCorrect := false . 
	 [ isCorrect := self checkAssociation: aCodeBlockObject ]
	on: Exception 
	do: [ :exception | aCodeBlockObject explanation: exception asString ] .
	aCodeBlockObject status: isCorrect .
	isCorrect 
		ifTrue: [ aCodeBlockObject explanation: 'Test passed' ]
]

{ #category : 'visiting' }
MicrodownBookTesterVisitor >> failedTests [
	"Returns the failed tests within the test results"
	^ allTestResults select: [ :each | each isFailed ]
]

{ #category : 'initialization' }
MicrodownBookTesterVisitor >> initialize [
	super initialize.
	allTestResults := OrderedCollection new.
]

{ #category : 'visiting' }
MicrodownBookTesterVisitor >> isOk [ 
	| checkingVariable |
	checkingVariable := true.
	allTestResults do: [ :each | checkingVariable := checkingVariable and: [ each isPaired ] ].
	^ checkingVariable
]

{ #category : 'accessing' }
MicrodownBookTesterVisitor >> start: anObject [ 
	anObject accept: self . 
	
]

{ #category : 'testing' }
MicrodownBookTesterVisitor >> validTests [
	"Returns all passed tests"
	^ allTestResults select: [ :each | each isValid ]
]

{ #category : 'visiting' }
MicrodownBookTesterVisitor >> visitCode: aCodeBlock [	
		"Creates an instance of PRBookTestResult with parameters depending of the type of the codeblock. 
	Here it is for an example and therefore uses the specialized exmple methods
	textForTestcase
	executeAndReportExample:
	Note that there is no fragmentedText here, no need for it b/ecause the codeblock text contains the whole text and is the equivalent of  Playground execution"
			| result |
		result := MicrodownBookTestResult new.
		result text: aCodeBlock code.
		allTestResults add: result   .
		self excuteAndReportExample: result.
	   aCodeBlock isExpectedFailure
		ifTrue: [ result status: result status not] 

]
