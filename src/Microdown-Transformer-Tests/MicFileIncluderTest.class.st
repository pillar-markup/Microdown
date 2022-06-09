Class {
	#name : #MicFileIncluderTest,
	#superclass : #TestCase,
	#instVars : [
		'filesystem',
		'includer'
	],
	#category : #'Microdown-Transformer-Tests'
}

{ #category : #running }
MicFileIncluderTest >> generateFilesystemExample [

	| file |
	file := filesystem workingDirectory / 'anExample1.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# Foo
Pharo is cool

```
	this is a code
```
' ].
	file := filesystem workingDirectory / 'anExample2.md'.
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
	filesystem := FileSystem memory.
	
	includer := MicFileIncluder new.
	includer topFile: filesystem root.
	
	self generateFilesystemExample.

]

{ #category : #'tests - simple' }
MicFileIncluderTest >> testBeforeIncludingTheInputFile [

	| root file reference |	
	file := filesystem workingDirectory / 'test.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: '{!inputFile|path=anExample1.md!}' ].
	
	reference := (MicResourceReference fromUri: 'file:///test.md') filesystem: filesystem .
	root := reference loadMicrodown.
	
	"here we verify that {! ... !} is not a block and an element of a paragraph"
	self assert: root children first class equals: MicParagraphBlock.
	self assert: root children first children first class equals: MicInputfileBlock.
	

]

{ #category : #'tests - simple' }
MicFileIncluderTest >> testGenerateFilesystemIsGood [
	
	self assert: (filesystem workingDirectory / 'anExample1.md') contents equals: '# Foo
Pharo is cool

```
	this is a code
```
'.

	self assert: (filesystem workingDirectory / 'anExample2.md') contents equals: '## Bar
Pharo is **cool**

```
	this is a code 2
```
' 
]

{ #category : #tests }
MicFileIncluderTest >> testHandleNestedFileResolution [

	| root file reference |
	(filesystem workingDirectory / 'Chapters') createDirectory.
	(filesystem workingDirectory / 'Chapters' / 'SUnit') createDirectory.
	
	file := filesystem workingDirectory / 'Chapters' / 'SUnit.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: '{!inputFile|path=SUnit/anExample1.md!}' ].
	
	file := filesystem workingDirectory / 'Chapters' / 'SUnit' / 'anExample1.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# Foo
{!inputFile|path=anExample2.md!}''

' ].
	
	file := filesystem workingDirectory / 'Chapters' / 'SUnit' / 'anExample2.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# Example2
' ].
	
	reference := (MicResourceReference fromUri: 'file:///Chapters/SUnit.md') filesystem: filesystem.

	includer topFile: reference fileReference parent.
	includer visit: (root := reference loadMicrodown).

	self assert: root children first children first class equals: MicHeaderBlock.
	self assert: root children first children first header equals: 'Foo'.
	self assert: root children first children second class equals: MicParagraphBlock.
	
	self flag: #tofix. 
	"this is wrong the header should not be inside a paragraph"
	
	self assert: root children first children second children first class equals: MicHeaderBlock.
	self assert: root children first children second children first header equals: 'Example2'.



]

{ #category : #tests }
MicFileIncluderTest >> testIncluderIncludesInputFileFromTheSameLevel [

	| root file reference |
	(filesystem workingDirectory / 'Chapters') createDirectory.
	(filesystem workingDirectory / 'Chapters' / 'SUnit') createDirectory.
	
	file := filesystem workingDirectory / 'Chapters' / 'SUnit' / 'anExample1.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# Foo
Pharo is cool

```
	this is a code
```
' ].
	
	file := filesystem workingDirectory / 'Chapters' / 'SUnit' / 'SUnit.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: '{!inputFile|path=anExample1.md!}' ].
	
	reference := (MicResourceReference fromUri: 'file:///Chapters/SUnit/SUnit.md') filesystem: filesystem.
	root := reference loadMicrodown.
					
	self assert: root children first children first class equals: MicInputfileBlock.
	self assert: (root children first children first path isKindOf: MicResourceReference).			

	includer visit: root.

	self assert: root children first children first class equals: MicHeaderBlock.
	self assert: root children first children first header equals: 'Foo'.
	self assert: root children first children second class equals: MicParagraphBlock.
	self assert: root children first children third class equals: MicCodeBlock.



]

{ #category : #tests }
MicFileIncluderTest >> testIncluderIncludesInputFilesWithinTheSameParagraph [
	"As a general remark I do not like that the input can produce document that are not correct from a parser 
	point of view. For example we should have a paragraph containing an header and this is what the transformation of the includer is doing."
	| root file reference |

	file := filesystem workingDirectory / 'test.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: '{!inputFile|path=anExample1.md!}
{!inputFile|path=anExample2.md!}' ].
	reference := (MicResourceReference fromUri: 'file:///test.md') filesystem: filesystem.
	root := reference loadMicrodown.
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

	| root file reference |

	file := filesystem workingDirectory / 'test.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: '{!inputFile|path=anExample1.md!} {!inputFile|path=anExample2.md!}' ].
	reference := (MicResourceReference fromUri: 'file:///test.md') filesystem: filesystem.
	root := reference loadMicrodown.
	
	includer visit: root.

	self assert: root children first children first class equals: MicHeaderBlock.
	self assert: root children first children second class equals: MicParagraphBlock.
	self assert: root children first children third class equals: MicCodeBlock.
	
	self assert: root children first children fourth class equals: MicTextBlock.
	
	self assert: root children first children fifth class equals: MicHeaderBlock.
	self assert: root children first children fifth header equals: 'Bar'.
	self assert: root children first children fifth level equals: 2.
	self assert: root children first children sixth class equals: MicParagraphBlock.
	self assert: root children first children seventh class equals: MicCodeBlock
]

{ #category : #tests }
MicFileIncluderTest >> testIncluderJustReturnInputFileBlockWhenIncludedFileDoesNotExist [

	| root file reference |
	file := filesystem workingDirectory / 'test.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: '{!inputFile|path=anExample3.md!}'].
	
	reference := (MicResourceReference fromUri: 'file:///test.md') filesystem: filesystem.
	root := reference loadMicrodown.
	
	includer beRelaxed.
	includer visit: root.
	
	self assert: root children first children first class equals: MicInputfileBlock.
]

{ #category : #tests }
MicFileIncluderTest >> testMicFileInclusionTransformMicInputFiles [
	"This test works because we have two paragraphs each one containing an inputfile."
	| root file reference |
	file := filesystem workingDirectory / 'test.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: '{!inputFile|path=anExample1.md!}

{!inputFile|path=anExample2.md!}' ].
	reference := (MicResourceReference fromUri: 'file:///test.md') filesystem: filesystem.
	root := reference loadMicrodown.
	includer visit: root.

	self assert: root children first children first class equals: MicHeaderBlock.
	self assert: root children first children second class equals: MicParagraphBlock.
	self assert: root children first children third class equals: MicCodeBlock.
	
	self assert: root children second children first class equals: MicHeaderBlock.
	self assert: root children second children second class equals: MicParagraphBlock.
	
	self assert: root children second children second children size equals: 2.
	self assert: root children second children third class equals: MicCodeBlock
]
