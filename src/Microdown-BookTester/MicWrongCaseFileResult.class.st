Class {
	#name : 'MicWrongCaseFileResult',
	#superclass : 'MicFileResult',
	#instVars : [
		'figureFileString',
		'sourceFileReference'
	],
	#category : 'Microdown-BookTester-Checker-References',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-References'
}

{ #category : 'accessing' }
MicWrongCaseFileResult >> explanation [
	^ 'The file exists on disk but has a different case (uppercase/lowercase) than the reference.'
]

{ #category : 'accessing' }
MicWrongCaseFileResult >> figureFileString: aString [
	figureFileString := aString
]

{ #category : 'accessing' }
MicWrongCaseFileResult >> sourceFileReference: aFileReference [
	sourceFileReference := aFileReference
]

{ #category : 'accessing' }
MicWrongCaseFileResult >> what [
	^ figureFileString
]
