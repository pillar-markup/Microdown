"
I'm responsible to validate that an example in a code block is correct.

```example
3 + 2 
>>> 5
```

The checking logic should probably be improved looking at the old book tester in old Pillar. 
See [PDF explaining book tester](https://github.com/pillar-markup/BookTester/tree/main/ressources/OldBookTester)
"
Class {
	#name : 'MicExampleTesterStrategy',
	#superclass : 'MicCodeBlockTesterStrategy',
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
		result sourceFileReference: aCodeBlock fromFile.
		results add: result.
		self executeAndReportIn: result.
		aCodeBlock isExpectedFailure 
			ifTrue: [
				result status: result status not.
				result isExpectedFailure: true ]
]
