Class {
	#name : 'MicFrenchTypoCheckerTest',
	#superclass : 'TestCase',
	#instVars : [
		'fileSystem',
		'checker'
	],
	#category : 'Microdown-Rules-FrenchTypography',
	#package : 'Microdown-Rules',
	#tag : 'FrenchTypography'
}

{ #category : 'running' }
MicFrenchTypoCheckerTest >> generateFilesystemExample [
	| file |
	"incorrect cases"
	file := fileSystem workingDirectory / 'noSpaceBeforeColon.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: 'Voici le code suivant:'
		 ]. 
		file := fileSystem workingDirectory / 'noSpaceBeforeSemiColon.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: 'Premier exemple; deuxième exemple'
		 ].
		file := fileSystem workingDirectory / 'noSpaceBeforeExlamation.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: 'Attention!'
		 ].
		file := fileSystem workingDirectory / 'SpaceBeforeComma.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: 'Premier exemple ,deuxième exemple'
		 ].
		file := fileSystem workingDirectory / 'noSpaceAfterComma.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: 'Premier exemple,deuxième exemple'
		 ].
	"correct cases"
		file := fileSystem workingDirectory / 'correct.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: 'Voici le code : exemple, test.'
		 ].
			file := fileSystem workingDirectory / 'noSpaceBeforeQuestion.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: 'Comment faire?'
		 ].
]

{ #category : 'running' }
MicFrenchTypoCheckerTest >> setUp [
	super setUp.

	fileSystem := FileSystem memory.
	self generateFilesystemExample.
	checker := MicFrenchTypoChecker new.
]

{ #category : 'tests' }
MicFrenchTypoCheckerTest >> testConfigureFromAnyValue [
	checker configureFrom: 'anything'.
	self assert: checker isOkay.
]

{ #category : 'tests' }
MicFrenchTypoCheckerTest >> testConfigureFromNil [ 
	checker configureFrom: nil.
	self assert: checker isOkay.
]

{ #category : 'tests' }
MicFrenchTypoCheckerTest >> testCorrect [
	checker checkProject: fileSystem / 'correct.md'.
	self assert: checker isOkay.
]

{ #category : 'tests' }
MicFrenchTypoCheckerTest >> testNoSpaceAfterCommaDetected [
	checker checkProject: fileSystem / 'noSpaceAfterComma.md'.
	self deny: checker isOkay.
	self assert: checker results first detail
	 equals: 'There should be a space after ,'. 
]

{ #category : 'tests' }
MicFrenchTypoCheckerTest >> testNoSpaceBeforeColonDetected [
	checker checkProject: fileSystem / 'noSpaceBeforeColon.md'.
	self deny: checker isOkay.
	self assert: checker results first detail
	 equals: 'There should be a space before :'. 
]

{ #category : 'tests' }
MicFrenchTypoCheckerTest >> testNoSpaceBeforeExclamationDetected [
	checker checkProject: fileSystem / 'noSpaceBeforeExlamation.md'.
	self deny: checker isOkay.
	self assert: checker results first detail
	 equals: 'There should be a space before !'. 
]

{ #category : 'tests' }
MicFrenchTypoCheckerTest >> testNoSpaceBeforeQuestionDetected [
	checker checkProject: fileSystem / 'noSpaceBeforeQuestion.md'.
	self deny: checker isOkay.
	self assert: checker results first detail
	 equals: 'There should be a space before ?'. 
]

{ #category : 'tests' }
MicFrenchTypoCheckerTest >> testNoSpaceBeforeSemiColonDetected [
	checker checkProject: fileSystem / 'noSpaceBeforeSemiColon.md'.
	self deny: checker isOkay.
	self assert: checker results first detail
	 equals: 'There should be a space before ;'. 
]

{ #category : 'tests' }
MicFrenchTypoCheckerTest >> testSpaceBeforeCommaDetected [
	checker checkProject: fileSystem / 'SpaceBeforeComma.md'.
	self deny: checker isOkay.
	self assert: checker results first detail
	 equals: 'There should be no space before ,'. 
]
