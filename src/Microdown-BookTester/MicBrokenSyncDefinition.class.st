Class {
	#name : 'MicBrokenSyncDefinition',
	#superclass : 'MicResult',
	#instVars : [
		'syncValue',
		'codeBlock'
	],
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'building' }
MicBrokenSyncDefinition >> codeBlock: aMicCodeBlock [ 
	codeBlock := aMicCodeBlock 
]

{ #category : 'as yet unclassified' }
MicBrokenSyncDefinition >> syncValue: aString [ 
	syncValue := aString
]
