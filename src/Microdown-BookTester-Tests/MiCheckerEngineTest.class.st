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
MiCheckerEngineTest >> testCheckersFromConfiguration [
	| config checkers |
	config := OrderedDictionary new.
	config at: 'EnglishTypography' put: nil.
	config at: 'HeaderCapitalization' put: 'lowercase'.
	checkers := engine checkersFromConfiguration: config.
	self assert: checkers size equals: 2.
	self assert: (checkers anySatisfy: [:c | c isKindOf: MicEnglishTypographyChecker]).
	self assert: (checkers anySatisfy: [:c | c isKindOf: MicRuleHeaderChecker]).
]

{ #category : 'running' }
MiCheckerEngineTest >> testCheckersFromConfigurationAllCheckers [
	| config checkers |
	config := OrderedDictionary new.
	config at: 'EnglishTypography' put: nil.
	config at: 'FrenchTypography' put: nil.
	config at: 'HeaderCapitalization' put: 'lowercase'.
	config at: 'Vocabulary' put: { #('colour' 'color')}.
	config at: 'CodeIndentation' put: nil.
	config at: 'MethodReferenceUsingHash' put: nil.
	config at: 'MethodStructure' put: nil.
	config at: 'NotTheFigureX' put: nil.
	config at: 'CodeLastPeriod' put: 'true'.
	config at: 'ParagraphLabelEndPeriod' put: 'true'.
	config at: 'CodeLastPeriodInCaption' put: nil.
	config at: 'LastPeriodInCode' put: nil.
	checkers := engine checkersFromConfiguration: config.
	self assert: checkers size equals: 12.
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
