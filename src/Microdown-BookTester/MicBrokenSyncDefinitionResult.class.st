"
I report that a sync definition is not correct.

The sync feature is checking problems when true, ignored when false and reported as a broken sync definition else.

```
sync=what ever
```
"
Class {
	#name : 'MicBrokenSyncDefinitionResult',
	#superclass : 'MicResult',
	#instVars : [
		'syncValue',
		'codeBlock'
	],
	#category : 'Microdown-BookTester-Checker-CodeBlockAnalysis',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-CodeBlockAnalysis'
}

{ #category : 'kinds' }
MicBrokenSyncDefinitionResult class >> headerString [

	^ 'Broken sync definition [should be sync=''true|false'''
]

{ #category : 'building' }
MicBrokenSyncDefinitionResult >> codeBlock: aMicCodeBlock [ 
	codeBlock := aMicCodeBlock 
]

{ #category : 'accessing' }
MicBrokenSyncDefinitionResult >> explanation [

	^ 'The sync definition has the following broken value: ', syncValue, ' .'
]

{ #category : 'initialization' }
MicBrokenSyncDefinitionResult >> headerString [

	^ 'Broken Sync Definition'
]

{ #category : 'initialization' }
MicBrokenSyncDefinitionResult >> initialize [ 
	
	super initialize. 
	syncValue := 'empty'
]

{ #category : 'accessing' }
MicBrokenSyncDefinitionResult >> syncValue [
	^ syncValue
]

{ #category : 'accessing' }
MicBrokenSyncDefinitionResult >> syncValue: aString [ 
	syncValue := aString
]
