Class {
	#name : 'MicExampleTesterStrategy',
	#superclass : 'MicBookTesterStrategy',
	#category : 'Microdown-BookTester-Analysis',
	#package : 'Microdown-BookTester',
	#tag : 'Analysis'
}

{ #category : 'hook' }
MicExampleTesterStrategy class >> handleKey [

	^ #example

]

{ #category : 'main API' }
MicExampleTesterStrategy >> checkAssociation: aCodeBlockObject [
	"Asserts  the association created in any codeBlock "

	| association |
	association := self class compiler evaluate: aCodeBlockObject text.
	^ association key = association value
]

{ #category : 'main API' }
MicExampleTesterStrategy >> executeAndReportIn: aResult [

	| isCorrect |
	isCorrect := false.
	[ isCorrect := self checkAssociation: aResult ]
		on: Exception
		do: [ :exception | aResult message: exception asString ].
	aResult status: isCorrect.
	isCorrect ifTrue: [ aResult message: 'Test passed' ]
]

{ #category : 'main API' }
MicExampleTesterStrategy >> verify: aCodeBlock [

		| result |
		result := MicBookTestResult new.
		result text: aCodeBlock code.
		[ result source: aCodeBlock fromFile ]
			on: Error
			do: [ result source: nil ].
		results add: result.
		self executeAndReportIn: result.
		aCodeBlock isExpectedFailure 
			ifTrue: [
				result status: result status not.
				result isExpectedFailure: true ]
]
