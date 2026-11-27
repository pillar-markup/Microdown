Class {
	#name : 'MicMethodReferenceCheckerTest',
	#superclass : 'TestCase',
	#instVars : [
		'fileSystem',
		'checker'
	],
	#category : 'Microdown-BookTester-Checker-MethodReferences',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-MethodReferences'
}

{ #category : 'running' }
MicMethodReferenceCheckerTest >> generateFilesystemExample [
	| file |
	file := fileSystem workingDirectory / 'mixedReference.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: 'Use SpPresenter>>#methodOne and SpPresenter>>methodTwo'
		 ].
	file := fileSystem workingDirectory / 'withHashOnly.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: 'Use SpPresenter>>#methodOne and SpPresenter>>#methodTwo'
		 ].
		file := fileSystem workingDirectory / 'withoutHashOnly.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: 'Use SpPresenter>>methodOne and SpPresenter>>methodTwo'
		 ].
]

{ #category : 'running' }
MicMethodReferenceCheckerTest >> setUp [
	super setUp.

	fileSystem := FileSystem memory.
	self generateFilesystemExample.
	checker := MicMethodReferenceChecker new.
]

{ #category : 'tests' }
MicMethodReferenceCheckerTest >> testConfigureFromAnyValue [ 
	checker configureFrom: 'anything'.
	self assert: checker isOkay.
]

{ #category : 'tests' }
MicMethodReferenceCheckerTest >> testConfigureFromNil [ 
	checker configureFrom: nil.
	self assert: checker isOkay.
]

{ #category : 'tests' }
MicMethodReferenceCheckerTest >> testMixedReferenceDetected [
	checker checkProject: fileSystem / 'mixedReference.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	
]

{ #category : 'tests' }
MicMethodReferenceCheckerTest >> testWhenRequireHashIsFalseThenWithHashRaisesError [

	checker requireHash: false.
	checker checkProject: fileSystem / 'withHashOnly.md'.
	self deny: checker isOkay
]

{ #category : 'tests' }
MicMethodReferenceCheckerTest >> testWhenRequireHashIsTrueThenWithoutHashRaisesError [

	checker requireHash: true.
	checker checkProject: fileSystem / 'withoutHashOnly.md'.
	self deny: checker isOkay
]

{ #category : 'tests' }
MicMethodReferenceCheckerTest >> testWithHashOnlyCorrect [
	checker checkProject: fileSystem / 'withHashOnly.md'.
	self assert: checker isOkay.
	
]

{ #category : 'tests' }
MicMethodReferenceCheckerTest >> testWithoutHashOnlyCorrect [

	checker requireHash: false.
	checker checkProject: fileSystem / 'withoutHashOnly.md'.
	self assert: checker isOkay
]
