Class {
	#name : #MicCodeblockEvaluatorTest,
	#superclass : #TestCase,
	#instVars : [
		'replacement'
	],
	#category : #'Microdown - Transformer'
}

{ #category : #private }
MicCodeblockEvaluatorTest >> actualClass [
	^ MicCodeblockEvaluator 
]

{ #category : #accessing }
MicCodeblockEvaluatorTest >> configuration [
	^ self configurationClass new
]

{ #category : #accessing }
MicCodeblockEvaluatorTest >> configurationClass [
	^ ConfigurationForPillar
]

{ #category : #tests }
MicCodeblockEvaluatorTest >> executePhase: anInput with: aConfig [

	^ (self actualClass
		executeOn:
			(PRCompilationContext withDocument: anInput withConfiguration: aConfig))
		input
]

{ #category : #private }
MicCodeblockEvaluatorTest >> testScriptWithEvalThatDoesntReturnAParagraph [
	| input |
	input := MicRootBlock new
		addChild:
			(MicParagraphBlock new
				addChild:
						((MicCodeBlock new body: 'stream nextPutAll: ''- test''')
								eval: true; 
								yourself);
				yourself) yourself.
	self executePhase: input with: self configuration.
	self assert: input children first class equals: MicParagraphBlock.
	self assert: input children first children first class equals: MicUnorderedListBlock.
	self assert: input children first children first children first class equals: MicListItemBlock
]

{ #category : #tests }
MicCodeblockEvaluatorTest >> testScriptWithProblematicEval [
	| input |
	input := MicRootBlock new
		addChild:
				((MicCodeBlock new body: 'Object SomethingThatIsNotAMethod')
						eval: true;
						yourself);
		yourself.
	self assert: (self executePhase: input with: self configuration) equals: input
]

{ #category : #tests }
MicCodeblockEvaluatorTest >> testScriptWithoutEval [
	| input |
	input := MicRootBlock new
		addChild:
				((MicCodeBlock new body: 'stream nextPut: $h; nextPut: $e; nextPut: $l; nextPutAll: ''lo''')
						eval: false;
						yourself);
		yourself.
	self assert: input children first class equals: MicCodeBlock.
	self assert: input children first body equals: 'stream nextPut: $h; nextPut: $e; nextPut: $l; nextPutAll: ''lo'''
]
