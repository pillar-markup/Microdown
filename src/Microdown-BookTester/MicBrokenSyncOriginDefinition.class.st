Class {
	#name : 'MicBrokenSyncOriginDefinition',
	#superclass : 'MicResult',
	#instVars : [
		'origin',
		'codeBlock'
	],
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'accessing' }
MicBrokenSyncOriginDefinition >> originString: aString [ 
	origin := aString
]
