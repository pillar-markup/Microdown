"
The origin in `sync=true&origin=Class>>#selector` should point to a method. A method either in the instance or class side. 

I represent a wrong or badly defined origin specification so I represent that the 
 user specified something else than C [class]>>#selector 
"
Class {
	#name : 'MicBrokenSyncOriginDefinitionResult',
	#superclass : 'MicResult',
	#instVars : [
		'origin'
	],
	#category : 'Microdown-BookTester-Checker-CodeBlockAnalysis',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-CodeBlockAnalysis'
}

{ #category : 'accessing' }
MicBrokenSyncOriginDefinitionResult >> explanation [

	^ 'The sync origin in the definition is bogus it should be C [class]>> #selector and we get: ', origin
]

{ #category : 'kinds' }
MicBrokenSyncOriginDefinitionResult >> headerString [

	^ 'Broken Sync Origin Definition'
]

{ #category : 'initialization' }
MicBrokenSyncOriginDefinitionResult >> initialize [ 
	super initialize.
	origin := 'C [class]>>#selector'
]

{ #category : 'accessing' }
MicBrokenSyncOriginDefinitionResult >> originString: aString [ 
	origin := aString
]
