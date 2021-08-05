Class {
	#name : #MicCodeblockEvaluatorTest,
	#superclass : #TestCase,
	#category : #'Microdown-Evaluator-Tests'
}

{ #category : #private }
MicCodeblockEvaluatorTest >> actualClass [
	^ MicCodeblockEvaluator 
]

{ #category : #private }
MicCodeblockEvaluatorTest >> testCodeblockWithEvalThatDoesntReturnAParagraph [
	| input |
	input := MicRootBlock new
		addChild:
			(MicParagraphBlock new
				addChild:
						((MicCodeBlock new body: 'stream nextPutAll: ''- test''')
								eval: true; 
								yourself);
				yourself) yourself.
	self actualClass new visit: input.
	self assert: input children first class equals: MicParagraphBlock.
	self assert: input children first children first class equals: MicUnorderedListBlock.
	self assert: input children first children first children first class equals: MicListItemBlock
]

{ #category : #tests }
MicCodeblockEvaluatorTest >> testCodeblockWithProblematicEval [
	| input |
	input := MicRootBlock new
		addChild:
				((MicCodeBlock new body: 'Object SomethingThatIsNotAMethod')
						eval: true;
						yourself);
		yourself.
	self assert: (self actualClass new visit: input) equals: input
]

{ #category : #tests }
MicCodeblockEvaluatorTest >> testCodeblockWithoutEval [
	| input |
	input := MicRootBlock new
		addChild:
				((MicCodeBlock new body: 'stream nextPut: $h; nextPut: $e; nextPut: $l; nextPutAll: ''lo''')
						eval: false;
						yourself);
		yourself.
	self actualClass new visit: input.
	self assert: input children first class equals: MicCodeBlock.
	self assert: input children first body equals: 'stream nextPut: $h; nextPut: $e; nextPut: $l; nextPutAll: ''lo'''
]
