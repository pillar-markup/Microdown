Class {
	#name : #MicToPillarBasicTest,
	#superclass : #TestCase,
	#instVars : [
		'pillarDocument'
	],
	#category : #'Microdown-Pillar-Tests'
}

{ #category : #tests }
MicToPillarBasicTest >> parserClass [
	^ MicroDownParser
]
