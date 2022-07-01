Class {
	#name : #MicInputFileResolverTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests-Parser'
}

{ #category : #tests }
MicInputFileResolverTest >> builder [ 

	^ self microdown builder
]

{ #category : #tests }
MicInputFileResolverTest >> microdown [ 

	^ Microdown
]

{ #category : #tests }
MicInputFileResolverTest >> testRelsoveInputFile [

	| fs f1Ast topPath |
	fs := FileSystem memory.
	topPath := fs root / 'f1.md'.
	topPath writeStreamDo: [ :stream |
		self builder
		 	setStream: stream;
			inputFile: 'f2.md'
	 ].
	fs root / 'f2.md' writeStreamDo: [ :stream | 
		stream nextPutAll: 'toto' ].


	f1Ast := Microdown parse: topPath readStream.
	MicInputFileResolver new
		topPath: topPath;
		visit: f1Ast.

	self assert: f1Ast children first text equals: 'toto'
]

{ #category : #tests }
MicInputFileResolverTest >> testRelsoveInputFileWithNestedFile [

	| fs f1Ast topPath |
	fs := FileSystem memory.
	fs ensureCreateDirectory: 'Depot'.
	topPath := fs root / 'f1.md'.
	topPath writeStreamDo: [ :stream | 
		self builder
		 	setStream: stream;
			inputFile: 'Depot/f2.md'  ].
	fs root / 'Depot' / 'f2.md' writeStreamDo: [ :stream | 
		stream nextPutAll: 'toto' ].


	f1Ast := self microdown parse: topPath readStream.
	MicInputFileResolver new
		topPath: topPath;
		visit: f1Ast.

	self assert: f1Ast children first text equals: 'toto'
]

{ #category : #tests }
MicInputFileResolverTest >> testRelsoveInputFileWithNestedInputFile [

	| fs f1Ast topPath |
	fs := FileSystem memory.
	fs ensureCreateDirectory: 'Depot'.
	topPath := fs root / 'f1.md'.
	topPath writeStreamDo: [ :stream | 
		self builder
		 	setStream: stream;
			inputFile: 'Depot/f2.md' ].
	fs root / 'Depot' / 'f2.md' writeStreamDo: [ :stream | 
		self builder
		 	setStream: stream;
			inputFile: 'Depot/f3.md' ].
	fs root / 'Depot' / 'f3.md' writeStreamDo: [ :stream | 
		stream nextPutAll: 'toto' ].


	f1Ast := Microdown parse: topPath readStream.
	MicInputFileResolver new
		topPath: topPath;
		visit: f1Ast.

	self assert: f1Ast children first children first text equals: 'toto'
]

{ #category : #tests }
MicInputFileResolverTest >> testRelsoveInputFileWithNestedInputFileAndFile [

	| fs f1Ast topPath |
	fs := FileSystem memory.
	fs ensureCreateDirectory: 'Depot'.
	fs ensureCreateDirectory: 'Depot/Depot2'.
	topPath := fs root / 'f1.md'.
	topPath writeStreamDo: [ :stream | 
		self builder
		 	setStream: stream;
			inputFile: 'Depot/f2.md' ].
	fs root / 'Depot' / 'f2.md' writeStreamDo: [ :stream | 
		self builder
		 	setStream: stream;
			inputFile: 'Depot/Depot2/f3.md' ].
	fs root / 'Depot' / 'Depot2' / 'f3.md' writeStreamDo: [ :stream | 
		stream nextPutAll: 'toto' ].


	f1Ast := Microdown parse: topPath readStream.
	MicInputFileResolver new
		topPath: topPath;
		visit: f1Ast.

	self assert: f1Ast children first children first text equals: 'toto'
]

{ #category : #tests }
MicInputFileResolverTest >> testRelsoveInputFileWithNestedInputFileButNotTheLastFile [

	| fs f1Ast topPath |
	fs := FileSystem memory.
	fs ensureCreateDirectory: 'Depot'.
	topPath := fs root / 'f1.md'.
	topPath writeStreamDo: [ :stream | 
		self builder
		 	setStream: stream;
			inputFile: 'Depot/f2.md' ].
	fs root / 'Depot' / 'f2.md' writeStreamDo: [ :stream | 
		self builder
		 	setStream: stream;
			inputFile: 'f3.md' ].
	fs root / 'f3.md' writeStreamDo: [ :stream | 
		stream nextPutAll: 'toto' ].


	f1Ast := Microdown parse: topPath readStream.
	MicInputFileResolver new
		topPath: topPath;
		visit: f1Ast.

	self assert: f1Ast children first children first text equals: 'toto'
]

{ #category : #tests }
MicInputFileResolverTest >> testRelsoveInputFileWithTwoInputFile [

	| fs f1Ast topPath |
	fs := FileSystem memory.
	topPath := fs root / 'f1.md'.
	topPath writeStreamDo: [ :stream | 
		self builder
		 	setStream: stream;
			inputFile: 'f2.md';
			inputFile: 'f3.md' ].
	fs root / 'f2.md' writeStreamDo: [ :stream | 
		stream nextPutAll: 'toto' ].
	fs root / 'f3.md' writeStreamDo: [ :stream | 
		stream nextPutAll: 'titi' ].


	f1Ast := Microdown parse: topPath readStream.
	MicInputFileResolver new
		topPath: topPath;
		visit: f1Ast.

	self assert: f1Ast children first text equals: 'toto'.
	self assert: f1Ast children second text equals: 'titi'
]

{ #category : #tests }
MicInputFileResolverTest >> testRelsoveInputFileWithWrongRef [

	| fs f1Ast topPath |
	fs := FileSystem memory.
	topPath := fs root / 'f1.md'.
	topPath writeStreamDo: [ :stream | 
		self builder
		 	setStream: stream;
			inputFile: 'f2.md' ].


	f1Ast := Microdown parse: topPath readStream.
	self
		should: [ 
			MicInputFileResolver new
				topPath: topPath;
				visit: f1Ast ]
		raise: FileDoesNotExistException
]
