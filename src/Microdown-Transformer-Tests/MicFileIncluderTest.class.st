Class {
	#name : #MicFileIncluderTest,
	#superclass : #TestCase,
	#instVars : [
		'filesystem',
		'includer',
		'builder'
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
	builder := Microdown builder.
	self generateFilesystemExample.

]

{ #category : #'tests - simple' }
MicFileIncluderTest >> testBeforeIncludingTheInputFile [

	| root file reference |	
	file := filesystem workingDirectory / 'test.md'.
	file writeStreamDo: [ :stream |
		builder
		 	setStream: stream;
			inputFile: 'anExample1.md' ].
	
	reference := (MicResourceReference fromUri: 'file:///test.md') filesystem: filesystem .
	root := reference loadMicrodown.
	
	self assert: root children first class equals: MicInputfileBlock.
	

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
	file writeStreamDo: [ :stream | 
		builder
		 	setStream: stream;
			inputfile: 'SUnit/anExample1.md' ].
	
	file := filesystem workingDirectory / 'Chapters' / 'SUnit' / 'anExample1.md'.
	file writeStreamDo: [ :stream | 
		builder
		 	setStream: stream;
			header: [builder text: 'Foo'] withLevel: 1;
			inputfile: 'anExample2.md' ].
		
	file := filesystem workingDirectory / 'Chapters' / 'SUnit' / 'anExample2.md'.
	file writeStreamDo: [ :stream |  
		builder
		 	setStream: stream;
			header: [builder text: 'Example2'] withLevel: 1 ].
	
	reference := (MicResourceReference fromUri: 'file:///Chapters/SUnit.md') filesystem: filesystem.
	
	includer topFile: reference fileReference parent.
	includer visit: (root := reference loadMicrodown).
	
	self assert: root children first class equals: MicHeaderBlock.
	self assert: root children first header equals: 'Foo'.
	
	self assert: root children second class equals: MicHeaderBlock.
	self assert: root children second header equals: 'Example2'.



]

{ #category : #tests }
MicFileIncluderTest >> testHandleNestedFileResolutionOnDifferentLevel [

	| root file reference |
	(filesystem workingDirectory / 'Chapters') createDirectory.
	(filesystem workingDirectory / 'Chapters' / 'SUnit') createDirectory.
	(filesystem workingDirectory / 'Chapters' / 'SUnit' / 'Sub') createDirectory.
	
	file := filesystem workingDirectory / 'Chapters' / 'SUnit.md'.
	file writeStreamDo: [ :stream | 
		builder
		 	setStream: stream;
			inputfile: 'SUnit/anExample1.md' ].
	
	file := filesystem workingDirectory / 'Chapters' / 'SUnit' / 'anExample1.md'.
	file writeStreamDo: [ :stream | 
		builder
		 	setStream: stream;
			header: [builder text: 'Foo'] withLevel: 1;
			inputfile: 'Sub/anExample2.md' ].
		
	file := filesystem workingDirectory / 'Chapters' / 'SUnit' / 'Sub' / 'anExample2.md'.
	file writeStreamDo: [ :stream |  
		builder
		 	setStream: stream;
			header: [builder text: 'Example2'] withLevel: 1 ].
	
	reference := (MicResourceReference fromUri: 'file:///Chapters/SUnit.md') filesystem: filesystem.
	
	includer topFile: reference fileReference parent.
	includer visit: (root := reference loadMicrodown).
	
	self assert: root children first class equals: MicHeaderBlock.
	self assert: root children first header equals: 'Foo'.
	
	self assert: root children second class equals: MicHeaderBlock.
	self assert: root children second header equals: 'Example2'.



]

{ #category : #tests }
MicFileIncluderTest >> testIncluderIncludesInputFileFromTheSameLevel [

	| root file reference |
	(filesystem workingDirectory / 'Chapters') createDirectory.
	(filesystem workingDirectory / 'Chapters' / 'SUnit') createDirectory.
	
	file := filesystem workingDirectory / 'Chapters' / 'SUnit' / 'anExample1.md'.
	file writeStreamDo: [ :stream | 
		builder
		 	setStream: stream;
			header: [ builder text: 'Foo' ] withLevel: 1;
			text: 'Pharo is cool';
			codeblock: 'This is a code'].
	
	file := filesystem workingDirectory / 'Chapters' / 'SUnit' / 'SUnit.md'.
	file writeStreamDo: [ :stream | 
		builder
		 	setStream: stream;
			inputfile: 'anExample1.md' ].
	
	reference := (MicResourceReference fromUri: 'file:///Chapters/SUnit/SUnit.md') filesystem: filesystem.
	root := reference loadMicrodown.
					
	self assert: root children first class equals: MicInputfileBlock.
	self assert: (root children first path isKindOf: MicResourceReference).			

	includer visit: root.

	self assert: root children first class equals: MicHeaderBlock.
	self assert: root children first header equals: 'Foo'.
	self assert: root children second class equals: MicParagraphBlock.
	self assert: root children third class equals: MicCodeBlock.



]

{ #category : #tests }
MicFileIncluderTest >> testIncluderIncludesInputFilesWithinTheSameParagraph [
	"As a general remark I do not like that the input can produce document that are not correct from a parser point of view. For example we should have a paragraph containing an header and this is what the transformation of the includer is doing."
	| root file reference |

	file := filesystem workingDirectory / 'test.md'.
	file writeStreamDo: [ :stream |   
		builder
		 	setStream: stream;
			inputfile: 'anExample1.md';
			inputfile: 'anExample2.md' ].
	reference := (MicResourceReference fromUri: 'file:///test.md') filesystem: filesystem.
	root := reference loadMicrodown.
	includer visit: root.

	self assert: root children first class equals: MicHeaderBlock.
	self assert: root children first header equals: 'Foo'.
	self assert: root children first level equals: 1.
	self assert: root children second class equals: MicParagraphBlock.
	self assert: root children third class equals: MicCodeBlock.
	
	self assert: root children fourth class equals: MicHeaderBlock.
	self assert: root children fourth header equals: 'Bar'.
	self assert: root children fourth level equals: 2.
	self assert: root children fifth class equals: MicParagraphBlock.
	self assert: root children sixth class equals: MicCodeBlock
]

{ #category : #tests }
MicFileIncluderTest >> testIncluderJustReturnInputFileBlockWhenIncludedFileDoesNotExist [

	| root file reference |
	file := filesystem workingDirectory / 'test.md'.
	file writeStreamDo: [ :stream |  
		builder
		 	setStream: stream;
			inputfile: 'anExample3.md'].
	
	reference := (MicResourceReference fromUri: 'file:///test.md') filesystem: filesystem.
	root := reference loadMicrodown.
	
	includer beRelaxed.
	includer visit: root.
	
	self assert: root children first class equals: MicInputfileBlock.
]

{ #category : #tests }
MicFileIncluderTest >> testMicFileInclusionTransformMicInputFiles [

	| root file reference |
	file := filesystem workingDirectory / 'test.md'.
	file writeStreamDo: [ :stream |  
		builder
		 	setStream: stream;
			inputfile: 'anExample1.md';
			paragraph: '';
			inputfile: 'anExample2.md' ].
	reference := (MicResourceReference fromUri: 'file:///test.md') filesystem: filesystem.
	root := reference loadMicrodown.
	includer visit: root.

	self assert: root children first class equals: MicHeaderBlock.
	self assert: root children second class equals: MicParagraphBlock.
	self assert: root children third class equals: MicCodeBlock.
	
	self assert: root children fourth class equals: MicHeaderBlock.
	self assert: root children fifth class equals: MicParagraphBlock.
	
	self assert: root children fifth children size equals: 2.
	self assert: root children sixth class equals: MicCodeBlock
]
