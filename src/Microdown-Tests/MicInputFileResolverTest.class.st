Class {
	#name : #MicInputFileResolverTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests-Parser'
}

{ #category : #tests }
MicInputFileResolverTest >> testRelsoveInputFile [

	| fs f1Ast topPath |
	fs := FileSystem memory.
	topPath := fs root / 'f1.md'.
	topPath writeStreamDo: [ :stream | 
		stream nextPutAll: '{!inputFile|path=f2.md!}' ].
	fs root / 'f2.md' writeStreamDo: [ :stream | 
		stream nextPutAll: 'toto' ].
	

	f1Ast := Microdown parse: topPath readStream.
	MicInputFileResolver new
		topPath: topPath;
		visit: f1Ast.

	self assert: f1Ast children first text equals: 'toto'

]
