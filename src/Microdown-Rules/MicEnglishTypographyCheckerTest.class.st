Class {
	#name : 'MicEnglishTypographyCheckerTest',
	#superclass : 'TestCase',
	#instVars : [
		'fileSystem',
		'checker'
	],
	#category : 'Microdown-Rules-EnglishTypography',
	#package : 'Microdown-Rules',
	#tag : 'EnglishTypography'
}

{ #category : 'running' }
MicEnglishTypographyCheckerTest >> generateFilesystemExample [

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

	file := fileSystem workingDirectory / 'urlHTTPS.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: 'See https://books.pharo.org for more.' ].

	file := fileSystem workingDirectory / 'urlHTTP.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: 'Visit http://pharo.org for details.' ].

	file := fileSystem workingDirectory / 'colonNewline.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: 'Here is a list: - item one' ].
		
	file := fileSystem workingDirectory / 'commaNewline.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: 'First, second.' ].
		
	file := fileSystem workingDirectory / 'semicolonNewline.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: 'First; second.' ].
	
]

{ #category : 'running' }
MicEnglishTypographyCheckerTest >> setUp [

	super setUp.
	fileSystem := FileSystem memory.
	self generateFilesystemExample.

	checker := MicEnglishTypographyChecker new.
	
]

{ #category : 'tests' }
MicEnglishTypographyCheckerTest >> testCorrectFile [

	checker checkProject: fileSystem / 'correct.md'.
	self assert: checker isOkay.
]

{ #category : 'tests' }
MicEnglishTypographyCheckerTest >> testMonospaceIgnored [

	checker checkProject: fileSystem / 'mono.md'.
	self assert: checker isOkay.
]

{ #category : 'tests' }
MicEnglishTypographyCheckerTest >> testNoFalsePositiveForColonNewline [

	checker checkProject: fileSystem / 'colonNewline.md'.
	self assert: checker isOkay.
]

{ #category : 'tests' }
MicEnglishTypographyCheckerTest >> testNoFalsePositiveForCommaline [

	checker checkProject: fileSystem / 'commaNewline.md'.
	self assert: checker isOkay.
]

{ #category : 'tests' }
MicEnglishTypographyCheckerTest >> testNoFalsePositiveForHTTPSURL [

	checker checkProject: fileSystem / 'urlHTTPS.md'.
	self assert: checker isOkay.
]

{ #category : 'tests' }
MicEnglishTypographyCheckerTest >> testNoFalsePositiveForHTTPURL [

	checker checkProject: fileSystem / 'urlHTTP.md'.
	self assert: checker isOkay.
]

{ #category : 'tests' }
MicEnglishTypographyCheckerTest >> testNoFalsePositiveForSemicolonNewline [

	checker checkProject: fileSystem / 'semicolonNewline.md'.
	self assert: checker isOkay.
]

{ #category : 'tests' }
MicEnglishTypographyCheckerTest >> testNoSpaceAfterColon [

	checker checkProject: fileSystem / 'noSpaceAfterColon.md'.
	self deny: checker isOkay.
	self 
		assert: checker results first explanation
		equals: 'Text: "Wrong:example." in file/noSpaceAfterColon.md contains a mistake: There is no space after :'
]

{ #category : 'tests' }
MicEnglishTypographyCheckerTest >> testNoSpaceAfterComma [

	checker checkProject: fileSystem / 'noSpaceAfterComma.md'.
	self deny: checker isOkay.
	self 
		assert: checker results first explanation
		equals: 'Text: "Wrong,example." in file/noSpaceAfterComma.md contains a mistake: There is no space after ,'
]

{ #category : 'tests' }
MicEnglishTypographyCheckerTest >> testSpaceBeforeColon [

	checker checkProject: fileSystem / 'spaceBeforeColon.md'.
	self deny: checker isOkay.
	self 
	assert: checker results first explanation
	equals: 'Text: "This is wrong : example." in file/spaceBeforeColon.md contains a mistake: There is a space before :'
]

{ #category : 'tests' }
MicEnglishTypographyCheckerTest >> testSpaceBeforeComma [

	checker checkProject: fileSystem / 'spaceBeforeComma.md'.
	self deny: checker isOkay.
	self 
		assert: checker results first explanation
		equals: 'Text: "Wrong ,example." in file/spaceBeforeComma.md contains a mistake: There is a space before ,'
]
