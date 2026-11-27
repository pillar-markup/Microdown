Class {
	#name : 'MicFileIncluderTest',
	#superclass : 'TestCase',
	#instVars : [
		'filesystem',
		'includer',
		'builder'
	],
	#category : 'Microdown-Transformer-Tests',
	#package : 'Microdown-Transformer-Tests'
}

{ #category : 'running' }
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

{ #category : 'running' }
MicFileIncluderTest >> setUp [
	super setUp.
	filesystem := FileSystem memory.
	
	includer := MicFileIncluder new.
	includer topFile: filesystem root.
	builder := Microdown builder.
	self generateFilesystemExample.

]

{ #category : 'tests - simple' }
MicFileIncluderTest >> testBeforeIncludingTheInputFile [

	| root file reference |	
	file := filesystem workingDirectory / 'test.md'.
	file writeStreamDo: [ :stream |
		builder
		 	setStream: stream;
			inputFile: 'anExample1.md' ].
	
	reference := (MicResourceReference fromUri: 'file:///test.md') fileSystem: filesystem.
	root := reference loadMicrodown.
	
	self assert: root children first class equals: MicInputfileBlock.
	

]

{ #category : 'tests - simple' }
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

{ #category : 'tests' }
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
			header: [ builder text: 'Foo' ] withLevel: 1;
			inputfile: 'anExample2.md' ].

	file := filesystem workingDirectory / 'Chapters' / 'SUnit' / 'anExample2.md'.
	file writeStreamDo: [ :stream |
		builder
			setStream: stream;
			header: [ builder text: 'Example2' ] withLevel: 1 ].

	reference := (MicResourceReference fromUri: 'file:///Chapters/SUnit.md') fileSystem: filesystem.

	includer topFile: reference fileReference parent.
	includer visit: (root := reference loadMicrodown).

	self assert: root children first class equals: MicSecondaryRootBlock.
	self assert: root children first children first class equals: MicHeaderBlock.
	self assert: root children first children first children first bodyString equals: 'Foo'.

	self assert: root children first children second class equals: MicSecondaryRootBlock.
	self 
		assert: root children first children second children first class 
		equals: MicHeaderBlock.
	self 
		assert: root children first children second children first children first bodyString 
		equals: 'Example2'.
	"make sure that we do not duplicate children"
	self assert: root children first children size equals: 2
]

{ #category : 'tests' }
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
			header: [ builder text: 'Foo' ] withLevel: 1;
			inputfile: 'Sub/anExample2.md' ].

	file := filesystem workingDirectory / 'Chapters' / 'SUnit' / 'Sub' / 'anExample2.md'.
	file writeStreamDo: [ :stream |
		builder
			setStream: stream;
			header: [ builder text: 'Example2' ] withLevel: 1 ].

	reference := (MicResourceReference fromUri: 'file:///Chapters/SUnit.md') fileSystem: filesystem.

	includer topFile: reference fileReference parent.
	includer visit: (root := reference loadMicrodown).

	self assert: root children first class equals: MicSecondaryRootBlock.
	self assert: root children first children first class equals: MicHeaderBlock.
	self assert: root children first children first children first bodyString equals: 'Foo'.

	self assert: root children first children second class equals: MicSecondaryRootBlock.
	self assert: root children first children second children first class equals: MicHeaderBlock.
	self assert: root children first children second children first children first bodyString equals: 'Example2'
]

{ #category : 'tests - line numbers' }
MicFileIncluderTest >> testIncludedBlockFileIsFoundFromItsSecondaryRoot [
	"A line number is only meaningful with its file: the nearest secondary root above an included block names the file the number refers to."

	| root header |
	filesystem workingDirectory / 'main.md' writeStreamDo: [ :stream |
			stream nextPutAll: '# Main

<!inputFile|path=sub.md!>' ].
	filesystem workingDirectory / 'sub.md' writeStreamDo: [ :stream |
			stream nextPutAll: 'first

# Sub header at 3' ].
	root := ((MicResourceReference fromUri: 'file:///main.md') fileSystem: filesystem) loadMicrodown.

	includer visit: root.

	header := root children second children second.
	self assert: header startLine equals: 3.
	self assert: header parent isSecondaryRoot.
	self assert: header parent fromFile fileReference basename equals: 'sub.md'
]

{ #category : 'tests - line numbers' }
MicFileIncluderTest >> testIncludedBlocksHaveLineNumbersOfTheirOwnFile [
	"Blocks coming from an included file are numbered from the first line of that file, and the blocks of the including file after the inputFile keep the numbering of the including file."

	| root secondary |
	filesystem workingDirectory / 'main.md' writeStreamDo: [ :stream |
			stream nextPutAll: '# Main
line 2

<!inputFile|path=sub.md!>

# After include' ].
	filesystem workingDirectory / 'sub.md' writeStreamDo: [ :stream |
			stream nextPutAll: 'first

# Sub header at 3' ].
	root := ((MicResourceReference fromUri: 'file:///main.md') fileSystem: filesystem) loadMicrodown.

	includer visit: root.

	secondary := root children third.
	self assert: secondary isSecondaryRoot.
	self assert: (root children collect: [ :each | each startLine ] as: Array) equals: #( 1 2 nil 6 ).
	self assert: (secondary children collect: [ :each | each startLine ] as: Array) equals: #( 1 3 ).
	self assert: secondary children second class equals: MicHeaderBlock
]

{ #category : 'tests - parent' }
MicFileIncluderTest >> testIncludedSecondaryRootKnowsItsParent [

	| root secondary |
	filesystem workingDirectory / 'main.md' writeStreamDo: [ :stream |
			builder
				setStream: stream;
				header: [ builder text: 'Main' ] withLevel: 1;
				inputfile: 'anExample1.md' ].
	root := ((MicResourceReference fromUri: 'file:///main.md') fileSystem: filesystem) loadMicrodown.

	includer visit: root.

	secondary := root children second.
	self assert: secondary isSecondaryRoot.
	self assert: secondary parent identicalTo: root.
	self assert: secondary children first parent identicalTo: secondary
]

{ #category : 'tests' }
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
			codeblock: 'This is a code' ].

	file := filesystem workingDirectory / 'Chapters' / 'SUnit' / 'SUnit.md'.
	file writeStreamDo: [ :stream |
		builder
			setStream: stream;
			inputfile: 'anExample1.md' ].

	reference := (MicResourceReference fromUri: 'file:///Chapters/SUnit/SUnit.md') fileSystem: filesystem.
	root := reference loadMicrodown.

	self assert: root children first class equals: MicInputfileBlock.
	self assert: (root children first path isKindOf: MicResourceReference).

	includer visit: root.

	self assert: root children first class equals: MicSecondaryRootBlock.
	self assert: root children first children first class equals: MicHeaderBlock.
	self assert: root children first children first children first bodyString equals: 'Foo'.
	self assert: root children first children second class equals: MicParagraphBlock.
	self assert: root children first children third class equals: MicCodeBlock
]

{ #category : 'tests' }
MicFileIncluderTest >> testIncluderIncludesInputFilesWithinTheSameParagraph [
	"As a general remark I do not like that the input can produce document that are not correct from a parser point of view. For example we should have a paragraph containing an header and this is what the transformation of the includer is doing."

	| root file reference |
	file := filesystem workingDirectory / 'test.md'.
	file writeStreamDo: [ :stream |
		builder
			setStream: stream;
			inputfile: 'anExample1.md';
			inputfile: 'anExample2.md' ].
	reference := (MicResourceReference fromUri: 'file:///test.md') fileSystem: filesystem.
	root := reference loadMicrodown.
	includer visit: root.

	self assert: root children first class equals: MicSecondaryRootBlock.
	self assert: root children first children first class equals: MicHeaderBlock.
	self assert: root children first children first children first bodyString equals: 'Foo'.
	self assert: root children first children first level equals: 1.
	self assert: root children first children second class equals: MicParagraphBlock.
	self assert: root children first children third class equals: MicCodeBlock.

	self assert: root children second class equals: MicSecondaryRootBlock.
	self assert: root children second children first class equals: MicHeaderBlock.
	self assert: root children second children first children first bodyString equals: 'Bar'.
	self assert: root children second children first level equals: 2.
	self assert: root children second children second class equals: MicParagraphBlock.
	self assert: root children second children third class equals: MicCodeBlock
]

{ #category : 'tests' }
MicFileIncluderTest >> testIncluderJustReturnInputFileBlockWhenIncludedFileDoesNotExist [

	| root file reference |
	file := filesystem workingDirectory / 'test.md'.
	file writeStreamDo: [ :stream |  
		builder
		 	setStream: stream;
			inputfile: 'anExample3.md'].
	
	reference := (MicResourceReference fromUri: 'file:///test.md') fileSystem: filesystem.
	root := reference loadMicrodown.
	
	includer beRelaxed.
	includer visit: root.
	
	self assert: root children first class equals: MicInputfileBlock.
]

{ #category : 'tests' }
MicFileIncluderTest >> testMicFileInclusionTransformMicInputFiles [
	| root file reference |
	file := filesystem workingDirectory / 'test.md'.
	file writeStreamDo: [ :stream |  
		builder
			setStream: stream;
			inputfile: 'anExample1.md';
			paragraph: '';
			inputfile: 'anExample2.md' ].
	reference := (MicResourceReference fromUri: 'file:///test.md') fileSystem: filesystem.
	root := reference loadMicrodown.
	includer visit: root.

	self assert: root children first class equals: MicSecondaryRootBlock.
	self assert: root children first children first class equals: MicHeaderBlock.
	self assert: root children first children second class equals: MicParagraphBlock.
	self assert: root children first children third class equals: MicCodeBlock.
	
	self assert: root children second class equals: MicSecondaryRootBlock.
	self assert: root children second children first class equals: MicHeaderBlock.
	self assert: root children second children second class equals: MicParagraphBlock.
	self assert: root children second children second children size equals: 2.
	self assert: root children second children third class equals: MicCodeBlock
]

{ #category : 'tests' }
MicFileIncluderTest >> testNestedFileResolutionDoesNotAddChildren [
	"this is to cover a bug and get a regression test"

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
			header: [ builder text: 'Foo' ] withLevel: 1;
			inputfile: 'anExample2.md' ].

	file := filesystem workingDirectory / 'Chapters' / 'SUnit' / 'anExample2.md'.
	file writeStreamDo: [ :stream |
		builder
			setStream: stream;
			header: [ builder text: 'Example2' ] withLevel: 1 ].

	reference := (MicResourceReference fromUri: 'file:///Chapters/SUnit.md') fileSystem: filesystem.

	includer topFile: reference fileReference parent.
	includer visit: (root := reference loadMicrodown).

	self assert: root children first class equals: MicSecondaryRootBlock.
	self 
		assert: root children first children first class 
		equals: MicHeaderBlock.
	self 
		assert: root children first children first children first bodyString 
		equals: 'Foo'.

	self 
		assert: root children first children size 
		equals: 2
]

{ #category : 'tests - line numbers' }
MicFileIncluderTest >> testNestedIncludedBlocksHaveLineNumbersOfTheirOwnFile [
	"Each level of inclusion is numbered from the first line of its own file."

	| root outer inner |
	filesystem workingDirectory / 'main.md' writeStreamDo: [ :stream |
			stream nextPutAll: '# Main

<!inputFile|path=middle.md!>

# After middle' ].
	filesystem workingDirectory / 'middle.md' writeStreamDo: [ :stream |
			stream nextPutAll: 'middle line 1

<!inputFile|path=deep.md!>

# Middle at 5' ].
	filesystem workingDirectory / 'deep.md' writeStreamDo: [ :stream |
			stream nextPutAll: '

# Deep at 3' ].
	root := ((MicResourceReference fromUri: 'file:///main.md') fileSystem: filesystem) loadMicrodown.

	includer visit: root.

	outer := root children second.
	inner := outer children second.
	self assert: outer isSecondaryRoot.
	self assert: inner isSecondaryRoot.
	self assert: (root children collect: [ :each | each startLine ] as: Array) equals: #( 1 nil 5 ).
	self assert: (outer children collect: [ :each | each startLine ] as: Array) equals: #( 1 nil 5 ).
	self assert: (inner children collect: [ :each | each startLine ] as: Array) equals: #( 3 )
]

{ #category : 'tests - parent' }
MicFileIncluderTest >> testNestedSecondaryRootsKnowTheirParents [

	| root outer inner |
	filesystem workingDirectory / 'main.md' writeStreamDo: [ :stream |
			builder
				setStream: stream;
				inputfile: 'middle.md' ].
	filesystem workingDirectory / 'middle.md' writeStreamDo: [ :stream |
			builder
				setStream: stream;
				header: [ builder text: 'Middle' ] withLevel: 1;
				inputfile: 'anExample1.md' ].
	root := ((MicResourceReference fromUri: 'file:///main.md') fileSystem: filesystem) loadMicrodown.

	includer visit: root.

	outer := root children first.
	inner := outer children second.
	self assert: outer isSecondaryRoot.
	self assert: inner isSecondaryRoot.
	self assert: outer parent identicalTo: root.
	self assert: inner parent identicalTo: outer.
	self assert: inner children first parent identicalTo: inner
]
