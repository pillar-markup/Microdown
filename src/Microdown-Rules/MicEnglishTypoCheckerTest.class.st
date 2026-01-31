Class {
	#name : 'MicEnglishTypoCheckerTest',
	#superclass : 'TestCase',
	#instVars : [
		'fileSystem',
		'checker'
	],
	#category : 'Microdown-Rules-EnglishTypos',
	#package : 'Microdown-Rules',
	#tag : 'EnglishTypos'
}

{ #category : 'running' }
MicEnglishTypoCheckerTest >> generateFilesystemExample [

	| file |
	file := fileSystem workingDirectory / 'paragraphWithSpaceBeforeSemiColon.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '

Authors may want to detect useless period as in the following code snippet ;

And more blabla.

And a space before : in english typo there is no space before diacritics' ]



	
]

{ #category : 'running' }
MicEnglishTypoCheckerTest >> setUp [

	super setUp.
	fileSystem := FileSystem memory.
	self generateFilesystemExample.

	checker := MicEnglishTypoChecker new.
	
]

{ #category : 'tests - english typos' }
MicEnglishTypoCheckerTest >> testCheckerChecksCorrectlyNoExtraPeriod [
	self skip.
	checker checkProject: fileSystem / 'codeNotEndingWithPeriod.md'.
	self assert: checker isOkay
]

{ #category : 'tests - english typos' }
MicEnglishTypoCheckerTest >> testCheckerIdentifyExtraSpace [

	checker checkProject: fileSystem / 'paragraphWithSpaceBeforeSemiColon.md'.
	self deny: checker isOkay.

	self 
		assert: checker results first explanation  
		equals: 'Text: "Authors may want to detect useless period as in the following code snippet ;" in file/paragraphWithSpaceBeforeSemiColon.md contains a mistake: There is a space before ;'
	
]
