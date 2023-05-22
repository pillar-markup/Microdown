Class {
	#name : #MicPharoScriptBlockTest,
	#superclass : #MicBlockTest,
	#category : #'Microdown-Tests-Extensions'
}

{ #category : #tests }
MicPharoScriptBlockTest >> subjectClass [

	^ MicPharoScriptBlock
]

{ #category : #tests }
MicPharoScriptBlockTest >> testScriptBloc [

	| doc |
	doc := Microdown parse: 
'```pharoscript|title=A cool roassal script
1 < 3
```'.
	self assert: doc children first class equals: MicPharoScriptBlock.
	self assert: doc children first body equals: '1 < 3'
]
