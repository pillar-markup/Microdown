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
	| input expected |
	input := MicRootBlock new
		addChild:
			(MicParagraphBlock new
				addChild:
						((MicCodeBlock new body: 'stream nextPutAll: ''- test''')
								eval: true; 
								yourself);
				yourself) yourself.
	expected := MicRootBlock new
		addChild:
			(MicParagraphBlock new
				addChild: (MicUnorderedListBlock new addChild: (MicListItemBlock new textElements: { (MicTextBlock new substring: 'test') } ));
				yourself) yourself.
	self assert: (self executePhase: input with: self configuration) equals: expected
]
