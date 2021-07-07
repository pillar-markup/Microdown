Class {
	#name : #MicFileInclusionTest,
	#superclass : #TestCase,
	#instVars : [
		'filesystem'
	],
	#category : #'Microdown - Transformer'
}

{ #category : #running }
MicFileInclusionTest >> cleanFilesystem [

	filesystem := FileSystem memory
]

{ #category : #running }
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

{ #category : #tests }
MicFileInclusionTest >> testGenerateFilesystemIsGood [
	self cleanFilesystem.
	self generateFilesystemExample.
	self assert: (filesystem workingDirectory / 'anExample.mic') contents equals: '# Foo
Pharo is cool

```
	this is a code
```
'
]

{ #category : #tests }
MicFileInclusionTest >> testMicFileInclusionTransformMicInputFile [
	| micFileInclusion mic |
	self flag: #completeMe.
	self cleanFilesystem.
	self generateFilesystemExample.
	micFileInclusion := MicFileInclusion new.
	micFileInclusion topFile: filesystem workingDirectory.
	mic := (MicroDownParser new parse: '?{inputfile|path=anExample.mic}?').
	micFileInclusion start: mic.
	self halt.
]
