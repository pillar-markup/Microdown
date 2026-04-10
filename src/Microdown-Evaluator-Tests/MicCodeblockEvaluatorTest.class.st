Class {
	#name : 'MicCodeblockEvaluatorTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Evaluator-Tests',
	#package : 'Microdown-Evaluator-Tests'
}

{ #category : 'private' }
MicCodeblockEvaluatorTest >> actualClass [
	^ MicCodeblockEvaluator 
]

{ #category : 'private' }
MicCodeblockEvaluatorTest >> testCodeblockWithEvalExecuteBody [

	| input |
	input := MicRootBlock new addChild: (MicParagraphBlock new
			          addChild:
				          ((MicCodeBlock new body: 'stream nextPutAll: ''- test''')
					           eval: true;
					           yourself);
			          yourself) yourself.
	self actualClass new visit: input.
	self assert: input children first class equals: MicParagraphBlock.
	self
		assert: input children first children first class
		equals: MicUnorderedListBlock.
	self
		assert: input children first children first children first class
		equals: MicListItemBlock.
	self
		assert: input children first children first children first testText
		equals: 'Text(test)'
]

{ #category : 'tests' }
MicCodeblockEvaluatorTest >> testCodeblockWithProblematicEval [
	| input |
	input := MicRootBlock new
		addChild:
				((MicCodeBlock new body: 'Object SomethingThatIsNotAMethod')
						eval: true;
						yourself);
		yourself.
	self actualClass new visit: input.
	self 
		assert: input children first text 
		equals: 'Instance of Object class did not understand #SomethingThatIsNotAMethod'
]

{ #category : 'tests' }
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

{ #category : 'tests' }
MicCodeblockEvaluatorTest >> testParsedCodeblockEvaluated [
	| input |
	input := MicCodeblockEvaluator new  visit: (Microdown
 parse: '```eval=true
stream nextPutAll: ''Hello world''
```').

	self actualClass new visit: input.
	self assert: input children first class equals: MicParagraphBlock.
	self assert: input children first text equals: 'Hello world'
]

{ #category : 'tests' }
MicCodeblockEvaluatorTest >> testParsedCodeblockNonEvaluated [
	| input |
	input := MicCodeblockEvaluator new  visit: (Microdown
 parse: '```eval=grgrgr
stream nextPutAll: ''Hello world''
```').

	self actualClass new visit: input.
	self assert: input children first class equals: MicCodeBlock.
	self assert: input children first body equals: 'stream nextPutAll: ''Hello world'''
]
