Class {
	#name : 'MicMethodStructureCheckerTest',
	#superclass : 'TestCase',
	#instVars : [
		'fileSystem',
		'checker'
	],
	#category : 'Microdown-Rules-MethodStructure',
	#package : 'Microdown-Rules',
	#tag : 'MethodStructure'
}

{ #category : 'running' }
MicMethodStructureCheckerTest >> generateFilesystemExample [
	| file |
	file := fileSystem workingDirectory / 'methodWrong.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '```
		goodWordFor: aString
			| pair |
			pair := pairs detect: [ :each | each key = aString ].
			^ pair value
		
		`````'
		 ].
		file := fileSystem workingDirectory / 'methodCorrect.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '```
		goodWordFor: aString
		
			| pair |
			pair := pairs detect: [ :each | each key = aString ].
			^ pair value
		
		`````'
		 ].
		file := fileSystem workingDirectory / 'methodWithComment.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '```
		goodWordFor: aString
		"there is a comment"
			| pair |
			pair := pairs detect: [ :each | each key = aString ].
			^ pair value
		
		`````'
		 ].
]

{ #category : 'running' }
MicMethodStructureCheckerTest >> setUp [
	super setUp.

	fileSystem := FileSystem memory.
	self generateFilesystemExample.
	checker := MicMethodStructureChecker new.
]

{ #category : 'tests' }
MicMethodStructureCheckerTest >> testConfigureFromAnyValue [ 
	checker configureFrom: 'anything'.
	self assert: checker isOkay.
]

{ #category : 'tests' }
MicMethodStructureCheckerTest >> testConfigureFromNil [ 
	checker configureFrom: nil.
	self assert: checker isOkay.
]

{ #category : 'tests' }
MicMethodStructureCheckerTest >> testMethodCorrect [
	checker checkProject: fileSystem / 'methodCorrect.md'.
	self assert: checker isOkay.
]

{ #category : 'tests' }
MicMethodStructureCheckerTest >> testMethodWithCommentCorrect [
	checker checkProject: fileSystem / 'methodWithComment.md'.
	self assert: checker isOkay.
]

{ #category : 'tests' }
MicMethodStructureCheckerTest >> testMethodWrongDetected [
	checker checkProject: fileSystem / 'methodWrong.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'goodWordFor: aString'. 
]
