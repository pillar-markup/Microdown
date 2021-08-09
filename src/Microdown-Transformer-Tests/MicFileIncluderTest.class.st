Class {
	#name : #MicFileIncluderTest,
	#superclass : #TestCase,
	#instVars : [
		'filesystem'
	],
	#category : #'Microdown-Transformer-Tests'
}

{ #category : #running }
MicFileIncluderTest >> cleanFilesystem [

	filesystem := FileSystem memory
]

{ #category : #running }
MicFileIncluderTest >> generateFilesystemExample [

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
	this is a code 2
```
' ]
]

{ #category : #running }
MicFileIncluderTest >> setUp [
	super setUp.
	self cleanFilesystem.
	self generateFilesystemExample.
]

{ #category : #tests }
MicFileIncluderTest >> testBeforeIncludingTheInputFile [

	| includer root file|
	includer := MicFileIncluder new.
	includer topFile: filesystem workingDirectory.
	
	file := filesystem workingDirectory / 'test.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '?{inputfile|path=anExample1.mic}?' ].
	root := MicroDownParser new parseFile: file.
	
	"here we verify that ?{ ...}? is not a block and an element of a paragraph"
	self assert: root children first class equals: MicParagraphBlock.
	self assert: root children first children first class equals: MicInputfileBlock.
	

]

{ #category : #tests }
MicFileIncluderTest >> testGenerateFilesystemIsGood [
	
	self assert: (filesystem workingDirectory / 'anExample1.mic') contents equals: '# Foo
Pharo is cool

```
	this is a code
```
'.

	self assert: (filesystem workingDirectory / 'anExample2.mic') contents equals: '## Bar
Pharo is **cool**

```
	this is a code 2
```
' 
]

{ #category : #tests }
MicFileIncluderTest >> testIncluderIncludesInputFile [

	| includer root file|
	includer := MicFileIncluder new.
	includer topFile: filesystem workingDirectory.
	
	file := filesystem workingDirectory / 'test.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '?{inputfile|path=anExample1.mic}?' ].
	root := (MicroDownParser new parseFile: file).
	
	includer visit: root.
	"even if inputFile was in a paragraph this raises the question of where do we put the expansion. 
	For example putting a header inside a paragraph does not make sense. 
	I feel that I would prefer to have a top level expander in addition to an in place expander."

	self assert: root children first children first class equals: MicHeaderBlock.
	self assert: root children first children first header equals: 'Foo'.
	self assert: root children first children second class equals: MicParagraphBlock.
	self assert: root children first children third class equals: MicCodeBlock.



]

{ #category : #tests }
MicFileIncluderTest >> testIncluderIncludesInputFilesWithNewline [

	| includer mic file |
	includer := MicFileIncluder new.
	includer topFile: filesystem workingDirectory.

	file := filesystem workingDirectory / 'test.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '?{inputfile|path=anExample1.mic}?


?{inputfile|path=anExample2.mic}?' ].
	mic := (MicroDownParser new parseFile: file).
	includer visit: mic.

	self assert: mic children first children first class equals: MicHeaderBlock.
	self assert: mic children first children second class equals: MicParagraphBlock.
	self assert: mic children first children third class equals: MicCodeBlock.
	
	self assert: mic children first children fourth class equals: MicTextBlock.
	
	self assert: mic children first children fifth class equals: MicHeaderBlock.
	self assert: mic children first children fifth header equals: 'Bar'.
	self assert: mic children first children fifth level equals: 2.
	self assert: mic children first children sixth class equals: MicParagraphBlock.
	self assert: mic children first children seventh class equals: MicCodeBlock
]

{ #category : #tests }
MicFileIncluderTest >> testIncluderIncludesInputFilesWithoutNewline [

	| includer mic file |
	includer := MicFileIncluder new.
	includer topFile: filesystem workingDirectory.

	file := filesystem workingDirectory / 'test.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '?{inputfile|path=anExample1.mic}? ?{inputfile|path=anExample2.mic}?' ].
	mic := (MicroDownParser new parseFile: file).
	includer visit: mic.

	self assert: mic children first children first class equals: MicHeaderBlock.
	self assert: mic children first children second class equals: MicParagraphBlock.
	self assert: mic children first children third class equals: MicCodeBlock.
	
	self assert: mic children first children fourth class equals: MicTextBlock.
	
	self assert: mic children first children fifth class equals: MicHeaderBlock.
	self assert: mic children first children fifth header equals: 'Bar'.
	self assert: mic children first children fifth level equals: 2.
	self assert: mic children first children sixth class equals: MicParagraphBlock.
	self assert: mic children first children seventh class equals: MicCodeBlock
]

{ #category : #tests }
MicFileIncluderTest >> testIncluderJustReturnInputFileBlockWhenIncludedFileDoesNotExist [

	| includer mic |
	includer := MicFileIncluder new.
	includer topFile: filesystem workingDirectory.
	mic := (MicroDownParser new parse: '?{inputfile|path=anExample3.mic}?').
	includer visit: mic.
	self assert: mic children first children first class equals: MicInputfileBlock.
]

{ #category : #tests }
MicFileIncluderTest >> testMicFileInclusionTransformMicInputFiles [

	| includer root file |
	includer := MicFileIncluder new.
	includer topFile: filesystem workingDirectory.
	file := filesystem workingDirectory / 'test.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '?{inputfile|path=anExample1.mic}? ?{inputfile|path=anExample2.mic}?' ].
	root := MicroDownParser new parseFile: file.
	includer visit: root.

	self assert: root children first children first class equals: MicHeaderBlock.
	self assert: root children first children second class equals: MicParagraphBlock.
	self assert: root children first children third class equals: MicCodeBlock.
	
	self assert: root children second children first class equals: MicHeaderBlock.
	self assert: root children second children second class equals: MicParagraphBlock.
	self halt.
	self assert: root children second children second children size equals: 2.
	self assert: root children second children third class equals: MicCodeBlock
]
