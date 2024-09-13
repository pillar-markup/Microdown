"
The origin in `sync=true&origin=Class>>#selector` should point to a method. A method either in the instance or class side. 

I represent a wrong or badly defined origin specification so I represent that the 
 user specified something else than C [class]>>#selector 
"
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
