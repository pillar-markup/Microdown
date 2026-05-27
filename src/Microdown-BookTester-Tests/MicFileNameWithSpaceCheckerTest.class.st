Class {
	#name : 'MicFileNameWithSpaceCheckerTest',
	#superclass : 'TestCase',
	#category : 'Microdown-BookTester-Tests',
	#package : 'Microdown-BookTester-Tests'
}

{ #category : 'tests' }
MicFileNameWithSpaceCheckerTest >> testFileWithSpaceIsDetected [
	| checker document |
	document := Microdown parse: '![mon image](fichier avec des espaces.png)'.
	checker := MicFilenameWithSpaceChecker new.
	checker visit: document.
	self assert: checker errors size equals: 1.
]

{ #category : 'tests' }
MicFileNameWithSpaceCheckerTest >> testFileWithoutSpaceIsNotDetected [
	| checker document |
	document := Microdown parse: '![mon image](fichier-parfait.png)'.
	checker := MicFilenameWithSpaceChecker new.
	checker visit: document.
	self assert: checker errors isEmpty
]

{ #category : 'tests' }
MicFileNameWithSpaceCheckerTest >> testProposedCorrectionForSpacedFilename [
	| checker document figure |
	document := Microdown parse: '![mon image](fichier avec des espaces.png)'.
	checker := MicFilenameWithSpaceChecker new.
	checker visit: document.
	figure := checker errors first.
	self assert: (checker proposedNameFor: figure) equals: 'fichier-avec-des-espaces.png'
]
