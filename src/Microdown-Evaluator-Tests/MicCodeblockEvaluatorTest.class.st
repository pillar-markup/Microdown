Class {
	#name : #MicCodeblockEvaluatorTest,
	#superclass : #TestCase,
	#instVars : [
		'replacement'
	],
	#category : #'Microdown-Evaluator-Tests'
}

{ #category : #private }
MicCodeblockEvaluatorTest >> actualClass [
	^ MicCodeblockEvaluator 
]

{ #category : #tests }
MicCodeblockEvaluatorTest >> executePhase: anInput [

	^ (self actualClass
		executeOn:
			(MicCompilationContext withDocument: anInput))
		input
]

{ #category : #tests }
MicCodeblockEvaluatorTest >> executePhase: anInput with: aConfig [

	^ (self actualClass
		executeOn:
			(MicCompilationContext withDocument: anInput withConfiguration: aConfig))
		input
]

{ #category : #private }
MicCodeblockEvaluatorTest >> testCodeblockWithEvalThatDoesntReturnAParagraph [
	| input |
	self skip.
	input := MicRootBlock new
		addChild:
			(MicParagraphBlock new
				addChild:
						((MicCodeBlock new body: 'stream nextPutAll: ''- test''')
								eval: true; 
								yourself);
				yourself) yourself.
	self executePhase: input.
	self assert: input children first class equals: MicParagraphBlock.
	self assert: input children first children first class equals: MicUnorderedListBlock.
	self assert: input children first children first children first class equals: MicListItemBlock
]

{ #category : #tests }
MicCodeblockEvaluatorTest >> testCodeblockWithProblematicEval [
	| input |
	self skip.
	input := MicRootBlock new
		addChild:
				((MicCodeBlock new body: 'Object SomethingThatIsNotAMethod')
						eval: true;
						yourself);
		yourself.
	self assert: (self executePhase: input) equals: input
]

{ #category : #tests }
MicCodeblockEvaluatorTest >> testCodeblockWithoutEval [
	| input |
	self skip.
	input := MicRootBlock new
		addChild:
				((MicCodeBlock new body: 'stream nextPut: $h; nextPut: $e; nextPut: $l; nextPutAll: ''lo''')
						eval: false;
						yourself);
		yourself.
	self assert: input children first class equals: MicCodeBlock.
	self assert: input children first body equals: 'stream nextPut: $h; nextPut: $e; nextPut: $l; nextPutAll: ''lo'''
]
