"
I report that a sync definition is not correct.

The sync feature is checking problems when true, ignored when false and reported as a broken sync definition else.

```
sync=what ever
```
"
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

{ #category : 'accessing' }
MicBrokenSyncDefinition >> explanation [

	^ 'The sync definition has the following broken value: ', syncValue, ' .'
]

{ #category : 'accessing' }
MicBrokenSyncDefinition >> syncValue [
	^ syncValue
]

{ #category : 'accessing' }
MicBrokenSyncDefinition >> syncValue: aString [ 
	syncValue := aString
]
