Class {
	#name : #MicHeadReunberingTest,
	#superclass : #TestCase,
	#category : #'Microdown - NewVisitor'
}

{ #category : #private }
MicHeadReunberingTest >> actualClass [

	^ MicHeadReunbering
]

{ #category : #private }
MicHeadReunberingTest >> checkWithOffset: offset [

	| result input configuration |
	configuration := self configuration.
	configuration headingLevelOffset: offset.
	input := MicHeaderBlock new
		         level: 3;
		         addChild: (MicTextBlock new substring: 'a title');
		         yourself.
	result := self executePhase: input with: configuration.
	self assert: result level equals: offset + 3
]

{ #category : #tests }
MicHeadReunberingTest >> configuration [

	^ self configurationClass new
]

{ #category : #tests }
MicHeadReunberingTest >> configurationClass [

	^ ConfigurationForMicrodown
]

{ #category : #tests }
MicHeadReunberingTest >> executePhase: anInput with: aConfig [

	^ (self actualClass executeOn:
		   (MicCompilationContext
			    withDocument: anInput
			    withConfiguration: aConfig)) input
]

{ #category : #tests }
MicHeadReunberingTest >> testPositiveOffset [

	self checkWithOffset: 2
]

{ #category : #tests }
MicHeadReunberingTest >> testZeroOffset [

	self checkWithOffset: 0
]
