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
	MicFileResource host: #testsystem is: [ filesystem  ].
]

{ #category : #running }
MicFileIncluderTest >> tearDown [ 
	filesystem := nil.
	MicFileResource removeHost: #testsystem.
]

{ #category : #tests }
MicFileIncluderTest >> testBeforeIncludingTheInputFile [

	| includer root file|
	includer := MicFileIncluder new.
	includer topFile: filesystem workingDirectory.
	
	file := filesystem workingDirectory / 'test.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '?{inputfile|path=anExample1.mic}?' ].
	root := (MicResourceReference fromUri: 'file://testsystem/test.mic') loadMicrodown.
	
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
	includer topFile: (MicResourceReference fromUri: 'file://testsystem/').
	(filesystem workingDirectory / 'Chapters') createDirectory.
	(filesystem workingDirectory / 'Chapters' / 'SUnit') createDirectory.
	
	file := filesystem workingDirectory / 'Chapters' / 'SUnit' / 'anExample1.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# Foo
Pharo is cool

```
	this is a code
```
' ].
	
	
	file := filesystem workingDirectory / 'Chapters' / 'SUnit' / 'SUnit.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '?{inputfile|path=anExample1.mic}?' ].
	root := (MicResourceReference fromUri: 'file://testsystem/Chapters/SUnit/SUnit.mic') loadMicrodown.
					
	self assert: root children first children first class equals: MicInputfileBlock.
	self assert: (root children first children first path isKindOf: MicResourceReference).			

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
MicFileIncluderTest >> testIncluderIncludesInputFilesWithinTheSameParagraph [
	"As a general remark I do not like that the input can produce document that are not correct from a parser 
	point of view. For example we should have a paragraph containing an header and this is what the transformation of the includer is doing."
	| includer root file |
	includer := MicFileIncluder new.
	includer topFile: (MicResourceReference fromUri: 'file://testsystem/').

	file := filesystem workingDirectory / 'test.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '?{inputfile|path=anExample1.mic}?
?{inputfile|path=anExample2.mic}?' ].
	root := (MicResourceReference fromUri: 'file://testsystem/test.mic') loadMicrodown.
	includer visit: root.

	self assert: root children size equals: 1.
	self assert: root children first children first class equals: MicHeaderBlock.
	self assert: root children first children first header equals: 'Foo'.
	self assert: root children first children first level equals: 1.
	self assert: root children first children second class equals: MicParagraphBlock.
	self assert: root children first children third class equals: MicCodeBlock.
	
	self assert: root children first children fifth class equals: MicHeaderBlock.
	self assert: root children first children fifth header equals: 'Bar'.
	self assert: root children first children fifth level equals: 2.
	self assert: root children first children sixth class equals: MicParagraphBlock.
	self assert: root children first children seventh class equals: MicCodeBlock
]

{ #category : #tests }
MicFileIncluderTest >> testIncluderIncludesInputFilesWithoutNewline [

	| includer mic file |
	includer := MicFileIncluder new.
	includer topFile: (MicResourceReference fromUri: 'file://testsystem/').

	file := filesystem workingDirectory / 'test.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '?{inputfile|path=anExample1.mic}? ?{inputfile|path=anExample2.mic}?' ].
	mic := (MicResourceReference fromUri: 'file://testsystem/test.mic') loadMicrodown.
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

	| includer mic file |
	includer := MicFileIncluder new.
	includer topFile: (MicResourceReference fromUri: 'file://testsystem/').
	file := filesystem workingDirectory / 'test.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '?{inputfile|path=anExample3.mic}?'].
	mic := (MicResourceReference fromUri: 'file://testsystem/test.mic') loadMicrodown.
	includer visit: mic.
	self assert: mic children first children first class equals: MicInputfileBlock.
]

{ #category : #tests }
MicFileIncluderTest >> testMicFileInclusionTransformMicInputFiles [
	"This test works because we have two paragraphs each one containing an inputfile."
	| includer root file |
	includer := MicFileIncluder new.
	includer topFile: (MicResourceReference fromUri: 'file://testsystem/').
	file := filesystem workingDirectory / 'test.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '?{inputfile|path=anExample1.mic}? 

?{inputfile|path=anExample2.mic}?' ].
	root := (MicResourceReference fromUri: 'file://testsystem/test.mic') loadMicrodown.
	includer visit: root.

	self assert: root children first children first class equals: MicHeaderBlock.
	self assert: root children first children second class equals: MicParagraphBlock.
	self assert: root children first children third class equals: MicCodeBlock.
	
	self assert: root children second children first class equals: MicHeaderBlock.
	self assert: root children second children second class equals: MicParagraphBlock.
	
	self assert: root children second children second children size equals: 2.
	self assert: root children second children third class equals: MicCodeBlock
]
