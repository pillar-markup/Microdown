Class {
	#name : 'MicExampleTesterStrategy',
	#superclass : 'MicBookTesterStrategy',
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'hook' }
MicExampleTesterStrategy class >> handleKey [

	^ #example

]

{ #category : 'main API' }
MicExampleTesterStrategy >> verify: aCodeBlock [

	self halt.
]
