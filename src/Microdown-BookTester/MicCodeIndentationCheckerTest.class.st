Class {
	#name : 'MicCodeIndentationCheckerTest',
	#superclass : 'TestCase',
	#instVars : [
		'fileSystem',
		'checker'
	],
	#category : 'Microdown-BookTester-Checker-CodeIndentation',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-CodeIndentation'
}

{ #category : 'running' }
MicCodeIndentationCheckerTest >> generateFilesystemExample [
	| file |
	"incorrect cases - space instead of tabs"
	file := fileSystem workingDirectory / 'indentationWrong.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '```
foo
   self
		`````'
		 ].
	"correct cases - tabs"
	file := fileSystem workingDirectory / 'indentationCorrect.md'.
	file writeStreamDo: [  :stream |
		stream nextPutAll: '```
foo
	self
		````' ].
]

{ #category : 'running' }
MicCodeIndentationCheckerTest >> setUp [
	super setUp.

	fileSystem := FileSystem memory.
	self generateFilesystemExample.
	checker := MicCodeIndentationChecker new.
]

{ #category : 'tests' }
MicCodeIndentationCheckerTest >> testConfigureFromAnyValue [ 
	checker configureFrom: 'anything'.
	self assert: checker isOkay.
]

{ #category : 'tests' }
MicCodeIndentationCheckerTest >> testConfigureFromNil [
	checker configureFrom: nil.
	self assert: checker isOkay.
]

{ #category : 'tests' }
MicCodeIndentationCheckerTest >> testIndentationCorrect [
	checker checkProject: fileSystem / 'indentationCorrect.md'.
	self assert: checker isOkay.
]

{ #category : 'tests' }
MicCodeIndentationCheckerTest >> testIndentationWrongDetected [
	checker checkProject: fileSystem / 'indentationWrong.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
]
