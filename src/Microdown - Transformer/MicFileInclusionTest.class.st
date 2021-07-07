Class {
	#name : #MicFileInclusionTest,
	#superclass : #TestCase,
	#instVars : [
		'filesystem'
	],
	#category : #'Microdown - Transformer'
}

{ #category : #'as yet unclassified' }
MicFileInclusionTest >> cleanFilesystem [

	filesystem := FileSystem memory
]

{ #category : #'as yet unclassified' }
MicFileInclusionTest >> generateFilesystemExample [

	| file |
	file := filesystem workingDirectory / 'anExample.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# Foo
Pharo is cool

```
	this is a code
```
' ]
]

{ #category : #running }
MicFileInclusionTest >> setUp [
	super setUp.
	
	filesystem := FileSystem memory
]
