"
i visit code blocks and make sure that evaluation is correct 
"
Class {
	#name : 'MicBookTesterVisitor',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'allTestResults',
		'strategies'
	],
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'testing' }
MicBookTesterVisitor class >> isAbstract [
	<ignoreForCoverage "This method is ignored for test coverage because it is overriden in all subclasses and these subclasses don't need to do a super-send.">
	^ false
]

{ #category : 'visiting' }
MicBookTesterVisitor >> checkAssociation: aCodeBlockObject [
	"Asserts  the association created in any codeBlock "

	| association |
	association := self class compiler evaluate: aCodeBlockObject text.
	^ association key = association value
]

{ #category : 'initialization' }
MicBookTesterVisitor >> collectStrategies [


	MicBookTesterStrategy allSubclasses do: [ :each |
		| strat |
		strat := each new.
		strat results: allTestResults. 
		strategies at: each handleKey put: strat  ]
]

{ #category : 'visiting' }
MicBookTesterVisitor >> executeAndReportIn: aResult [

	| isCorrect |
	isCorrect := false.
	[ isCorrect := self checkAssociation: aResult ]
		on: Exception
		do: [ :exception | aResult message: exception asString ].
	aResult status: isCorrect.
	isCorrect ifTrue: [ aResult message: 'Test passed' ]
]

{ #category : 'visiting' }
MicBookTesterVisitor >> failedTests [

	^ allTestResults select: [ :each | each isFailed ]
]

{ #category : 'initialization' }
MicBookTesterVisitor >> initialize [
	super initialize.
	allTestResults := OrderedCollection new.
	strategies := Dictionary new. 
	self collectStrategies
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
	anObject accept: self
	
]

{ #category : 'testing' }
MicBookTesterVisitor >> validTests [

	^ allTestResults select: [ :each | each isValid ]
]

{ #category : 'visiting' }
MicBookTesterVisitor >> visitCode: aCodeBlock [
	"Creates an instance of PRBookTestResult with parameters depending of the type of the codeblock. 
	Here it is for an example and therefore uses the specialized exmple methods
	textForTestcase
	executeAndReportExample:
	Note that there is no fragmentedText here, no need for it because the codeblock text contains 
	the whole text and is the equivalent of Playground execution"

	aCodeBlock isExample ifTrue: [
		| result |
		result := MicBookTestResult new.
		result text: aCodeBlock code.
		[ result source: aCodeBlock fromFile ]
			on: Error
			do: [ result source: nil ].
		allTestResults add: result.
		self executeAndReportIn: result.
		aCodeBlock isExpectedFailure ifTrue: [
			result status: result status not .
			result isExpectedFailure: true  ] ]
]
