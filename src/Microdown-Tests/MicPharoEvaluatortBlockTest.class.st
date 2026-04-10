Class {
	#name : 'MicPharoEvaluatortBlockTest',
	#superclass : 'MicBlockTest',
	#category : 'Microdown-Tests-Extensions',
	#package : 'Microdown-Tests',
	#tag : 'Extensions'
}

{ #category : 'tests' }
MicPharoEvaluatortBlockTest >> subjectClass [

	^ MicPharoEvaluatorBlock
]

{ #category : 'tests' }
MicPharoEvaluatortBlockTest >> testScriptBloc [

	| doc |
	doc := Microdown parse: 
'```pharoeval
1 < 3
```'.
	self assert: doc children first class equals: MicPharoEvaluatorBlock.
	self assert: doc children first body equals: '1 < 3'
]
