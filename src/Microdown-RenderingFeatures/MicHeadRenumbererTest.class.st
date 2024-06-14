Class {
	#name : 'MicHeadRenumbererTest',
	#superclass : 'TestCase',
	#category : 'Microdown-RenderingFeatures',
	#package : 'Microdown-RenderingFeatures'
}

{ #category : 'private' }
MicHeadRenumbererTest >> actualClass [

	^ MicHeaderRenumberer
]

{ #category : 'private' }
MicHeadRenumbererTest >> checkWithOffset: offset [

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

{ #category : 'tests' }
MicHeadRenumbererTest >> configuration [

	^ self configurationClass new
]

{ #category : 'tests' }
MicHeadRenumbererTest >> configurationClass [

	^ MicMinimalConfiguration 
]

{ #category : 'tests' }
MicHeadRenumbererTest >> executePhase: anInput with: aConfig [

	^ (self actualClass executeOn:
		   (MicCompilationContext
			    withDocument: anInput
			    withConfiguration: aConfig)) input
]

{ #category : 'tests' }
MicHeadRenumbererTest >> testNegativeOffset [

	self checkWithOffset: -4
]

{ #category : 'tests' }
MicHeadRenumbererTest >> testPositiveOffset [

	self checkWithOffset: 2
]

{ #category : 'tests' }
MicHeadRenumbererTest >> testZeroOffset [

	self checkWithOffset: 0
]
