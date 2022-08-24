Class {
	#name : #MicScriptBlockTest,
	#superclass : #MicBlockTest,
	#category : #'Microdown-Tests-Extensions'
}

{ #category : #tests }
MicScriptBlockTest >> subjectClass [

	^ MicScriptBlock
]

{ #category : #tests }
MicScriptBlockTest >> testScriptBloc [

	| doc |
	doc := Microdown parse: 

'$$script|title=A cool roassal script
1 < 3
$$'.
	self assert: doc children first class equals: MicScriptBlock.
	self assert: doc children first body equals: '1 < 3'
]
