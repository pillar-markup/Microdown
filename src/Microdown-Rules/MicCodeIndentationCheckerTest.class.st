Class {
	#name : 'MicCodeIndentationCheckerTest',
	#superclass : 'TestCase',
	#instVars : [
		'fileSystem',
		'checker'
	],
	#category : 'Microdown-Rules-CodeIndetation',
	#package : 'Microdown-Rules',
	#tag : 'CodeIndetation'
}

{ #category : 'running' }
MicCodeIndentationCheckerTest >> generateFilesystemExample [
	| file |
	"incorrect cases - space instead of tabs"
	file := fileSystem workingDirectory / 'indentationWrong.md'.
	file writeStreamDo: [ :steam |
		steam nextPutAll: '```
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
	"correct cases - exception nextPut: ' '"
	file := fileSystem workingDirectory / 'indentationException.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '```
		foo
			self nextPut: " "
		````'
		 ]
]

{ #category : 'running' }
MicCodeIndentationCheckerTest >> setUp [
	super setUp.

	fileSystem := FileSystem memory.
	self generateFilesystemExample.
	checker := MicCodeIndentationChecker new.
]

{ #category : 'tests' }
MicCodeIndentationCheckerTest >> testIndentationCorrect [
	checker checkProject: fileSystem / 'indentationCorrect.md'.
	self assert: checker isOkay.
]

{ #category : 'tests' }
MicCodeIndentationCheckerTest >> testIndentationExceptionNotFlagged [
	checker checkProject: fileSystem / 'indentationException.md'.
	self assert: checker isOkay.
]

{ #category : 'tests' }
MicCodeIndentationCheckerTest >> testIndentationWrongDetected [
	checker checkProject: fileSystem / 'indentationWrong.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
]
