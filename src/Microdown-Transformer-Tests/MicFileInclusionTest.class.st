Class {
	#name : #MicFileInclusionTest,
	#superclass : #TestCase,
	#instVars : [
		'filesystem'
	],
	#category : #'Microdown-Transformer-Tests'
}

{ #category : #running }
MicFileInclusionTest >> cleanFilesystem [

	filesystem := FileSystem memory
]

{ #category : #running }
MicFileInclusionTest >> generateFilesystemExample [

	| file |
	file := filesystem workingDirectory / 'anExample1.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# Foo
Pharo is cool

```
	this is a code
```
' ].
	file := filesystem workingDirectory / 'anExample2.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '## Bar
Pharo is **cool**

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
	self assert: (filesystem workingDirectory / 'anExample1.mic') contents equals: '# Foo
Pharo is cool

```
	this is a code
```
'
]

{ #category : #tests }
MicFileInclusionTest >> testMicFileInclusionTransformMicInputFile [
	| micFileInclusion mic |
	self cleanFilesystem.
	self generateFilesystemExample.
	micFileInclusion := MicFileInclusion new.
	micFileInclusion topFile: filesystem workingDirectory.
	mic := (MicroDownParser new parse: '?{inputfile|path=anExample1.mic}?').
	micFileInclusion start: mic.
	self assert: mic children first children first class equals: MicHeaderBlock.
	self assert: mic children first children second class equals: MicParagraphBlock.
	self assert: mic children first children third class equals: MicCodeBlock
]

{ #category : #tests }
MicFileInclusionTest >> testMicFileInclusionTransformMicInputFileDoesNotExist [
	| micFileInclusion mic |
	self cleanFilesystem.
	self generateFilesystemExample.
	micFileInclusion := MicFileInclusion new.
	micFileInclusion topFile: filesystem workingDirectory.
	mic := (MicroDownParser new parse: '?{inputfile|path=anExample3.mic}?').
	micFileInclusion start: mic.
	self assert: mic children first children first class equals: MicInputfileBlock.
]

{ #category : #tests }
MicFileInclusionTest >> testMicFileInclusionTransformMicInputFiles [
	| micFileInclusion mic |
	self cleanFilesystem.
	self generateFilesystemExample.
	micFileInclusion := MicFileInclusion new.
	micFileInclusion topFile: filesystem workingDirectory.
	mic := (MicroDownParser new parse: '?{inputfile|path=anExample1.mic}?

?{inputfile|path=anExample2.mic}?').
	micFileInclusion start: mic.
	self assert: mic children first children first class equals: MicHeaderBlock.
	self assert: mic children first children second class equals: MicParagraphBlock.
	self assert: mic children first children third class equals: MicCodeBlock.
	
	self assert: mic children second children first class equals: MicHeaderBlock.
	self assert: mic children second children second class equals: MicParagraphBlock.
	self assert: mic children second children second children size equals: 2.
	self assert: mic children second children third class equals: MicCodeBlock
]

{ #category : #tests }
MicFileInclusionTest >> testMicFileInclusionTransformMicInputFilesWithoutNewline [
	| micFileInclusion mic |
	self cleanFilesystem.
	self generateFilesystemExample.
	micFileInclusion := MicFileInclusion new.
	micFileInclusion topFile: filesystem workingDirectory.
	mic := (MicroDownParser new parse: '?{inputfile|path=anExample1.mic}?
?{inputfile|path=anExample2.mic}?').
	micFileInclusion start: mic.
	self assert: mic children first children first class equals: MicHeaderBlock.
	self assert: mic children first children second class equals: MicParagraphBlock.
	self assert: mic children first children third class equals: MicCodeBlock.
	
	self assert: mic children first children fourth class equals: MicTextBlock.
	
	self assert: mic children first children fifth class equals: MicHeaderBlock.
	self assert: mic children first children sixth class equals: MicParagraphBlock.
	self assert: mic children first children seventh class equals: MicCodeBlock
]
