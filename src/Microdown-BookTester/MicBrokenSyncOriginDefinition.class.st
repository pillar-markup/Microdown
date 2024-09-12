Class {
	#name : 'MicBrokenSyncOriginDefinition',
	#superclass : 'MicResult',
	#instVars : [
		'origin',
		'codeBlock'
	],
	#category : 'Microdown-BookTester-Results',
	#package : 'Microdown-BookTester',
	#tag : 'Results'
}

{ #category : 'kinds' }
MicBrokenSyncOriginDefinition class >> headerString [

	^ 'Broken sync origin specification [ should be C [class]>>#selector ]'
]

{ #category : 'accessing' }
MicBrokenSyncOriginDefinition >> explanation [

	^ 'The sync origin in the definition is bogus it should be C [class]>> #selector and we get: ', origin
]

{ #category : 'accessing' }
MicBrokenSyncOriginDefinition >> initialize [ 
	super initialize.
	origin := 'C [class]>>#selector'
]

{ #category : 'accessing' }
MicBrokenSyncOriginDefinition >> originString: aString [ 
	origin := aString
]
