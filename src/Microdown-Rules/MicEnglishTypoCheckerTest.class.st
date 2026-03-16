Class {
	#name : 'MicEnglishTypoCheckerTest',
	#superclass : 'TestCase',
	#instVars : [
		'fileSystem',
		'checker'
	],
	#category : 'Microdown-Rules-EnglishTypographic',
	#package : 'Microdown-Rules',
	#tag : 'EnglishTypographic'
}

{ #category : 'running' }
MicEnglishTypoCheckerTest >> generateFilesystemExample [

	| file |
	file := fileSystem workingDirectory / 'spaceBeforeColon.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '
This is wrong : example.' ].

	file := fileSystem workingDirectory / 'spaceBeforeComma.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '
Wrong ,example.' ].

	file := fileSystem workingDirectory / 'noSpaceAfterComma.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '
Wrong,example.' ].

	file := fileSystem workingDirectory / 'noSpaceAfterColon.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '
Wrong:example.' ].

	file := fileSystem workingDirectory / 'correct.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '
This is correct: example, test.' ].

	file := fileSystem workingDirectory / 'mono.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '
`[ :each | collection do: each ]`' ].

	file := fileSystem workingDirectory / 'codeWithCaption.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '
```smalltalk
collection do: [:each | each printString' ].



	
]

{ #category : 'running' }
MicEnglishTypoCheckerTest >> setUp [

	super setUp.
	fileSystem := FileSystem memory.
	self generateFilesystemExample.

	checker := MicEnglishTypoChecker new.
	
]

{ #category : 'tests' }
MicEnglishTypoCheckerTest >> testCorrectFile [

	checker checkProject: fileSystem / 'correct.md'.
	self assert: checker isOkay.
]

{ #category : 'tests' }
MicEnglishTypoCheckerTest >> testMonospaceIgnored [

	checker checkProject: fileSystem / 'mono.md'.
	self assert: checker isOkay.
]

{ #category : 'tests' }
MicEnglishTypoCheckerTest >> testNoSpaceAfterColon [

	checker checkProject: fileSystem / 'noSpaceAfterColon.md'.
	self deny: checker isOkay.
	self 
		assert: checker results first explanation
		equals: 'Text: "Wrong:example." in file/noSpaceAfterColon.md contains a mistake: There is no space after :'
]

{ #category : 'tests' }
MicEnglishTypoCheckerTest >> testNoSpaceAfterComma [

	checker checkProject: fileSystem / 'noSpaceAfterComma.md'.
	self deny: checker isOkay.
	self 
		assert: checker results first explanation
		equals: 'Text: "Wrong,example." in file/noSpaceAfterComma.md contains a mistake: There is no space after ,'
]

{ #category : 'tests' }
MicEnglishTypoCheckerTest >> testSpaceBeforeColon [

	checker checkProject: fileSystem / 'spaceBeforeColon.md'.
	self deny: checker isOkay.
	self 
	assert: checker results first explanation
	equals: 'Text: "This is wrong : example." in file/spaceBeforeColon.md contains a mistake: There is a space before :'
]

{ #category : 'tests' }
MicEnglishTypoCheckerTest >> testSpaceBeforeComma [

	checker checkProject: fileSystem / 'spaceBeforeComma.md'.
	self deny: checker isOkay.
	self 
		assert: checker results first explanation
		equals: 'Text: "Wrong ,example." in file/spaceBeforeComma.md contains a mistake: There is a space before ,'
]
