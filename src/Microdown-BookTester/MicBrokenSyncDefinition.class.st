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
	#category : 'Microdown-BookTester-Results',
	#package : 'Microdown-BookTester',
	#tag : 'Results'
}

{ #category : 'kinds' }
MicBrokenSyncDefinition class >> headerString [

	^ 'Broken sync definition [should be sync=''true|false'''
]

{ #category : 'building' }
MicBrokenSyncDefinition >> codeBlock: aMicCodeBlock [ 
	codeBlock := aMicCodeBlock 
]

{ #category : 'accessing' }
MicBrokenSyncDefinition >> explanation [

	^ 'The sync definition has the following broken value: ', syncValue, ' .'
]

{ #category : 'initialization' }
MicBrokenSyncDefinition >> initialize [ 
	
	super initialize. 
	syncValue := 'empty'
]

{ #category : 'accessing' }
MicBrokenSyncDefinition >> syncValue [
	^ syncValue
]

{ #category : 'accessing' }
MicBrokenSyncDefinition >> syncValue: aString [ 
	syncValue := aString
]
