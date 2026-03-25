Class {
	#name : 'MiCheckerEngineTest',
	#superclass : 'TestCase',
	#instVars : [
		'fileSystem',
		'engine',
		'file'
	],
	#category : 'Microdown-BookTester-Tests',
	#package : 'Microdown-BookTester-Tests'
}

{ #category : 'running' }
MiCheckerEngineTest >> generateFilesystemExample [
	file := fileSystem workingDirectory / 'test.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: 'The colour of the sky is blue.
## writing books in pharo'
		 ].
]

{ #category : 'running' }
MiCheckerEngineTest >> setUp [
	super setUp.

	fileSystem := FileSystem memory.
	engine := MicCheckerEngine new.
	self generateFilesystemExample.
]

{ #category : 'running' }
MiCheckerEngineTest >> testEngineDetectsHeaderMistake [
	| config results |
	config := OrderedDictionary new.
	config at: 'HeaderCapitalization' put: 'uppercase'.
	results := engine runOn: file withConfiguration: config.
	self deny: results isEmpty.
	self assert: results size equals: 3.
]

{ #category : 'running' }
MiCheckerEngineTest >> testEngineDetectsVocabularyMistake [
	| config results |
	config := OrderedDictionary new.
	config at: 'Vocabulary' put: { #('colour' . 'color') }.
	results := engine runOn: file withConfiguration: config.
	self deny: results isEmpty.
	self assert: results size equals: 1.
	self assert: (results first explanation includesSubstring: 'colour').
]

{ #category : 'running' }
MiCheckerEngineTest >> testEngineRunsMultipleCheckers [
	| config results |
	config := OrderedDictionary new.
	config at: 'Vocabulary' put: { #('colour' 'color') }.
	config at: 'HeaderCapitalization' put: 'uppercase'.
	results := engine runOn: file withConfiguration: config.
	self deny: results isEmpty.
	self assert: results size > 1.
]

{ #category : 'running' }
MiCheckerEngineTest >> testEngineWithEmptyConfiguration [
	| config results |
	config := OrderedDictionary new.
	results := engine runOn: file withConfiguration: config.
	self assert: results isEmpty.
]

{ #category : 'running' }
MiCheckerEngineTest >> testEngineWithUnknownChecker [
	| config results |
	config := OrderedDictionary new.
	config at: 'UnknownChecker' put: nil.
	results := engine runOn: file withConfiguration: config.
	self assert: results isEmpty.
]
