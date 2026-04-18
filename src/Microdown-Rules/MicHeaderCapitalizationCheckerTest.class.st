Class {
	#name : 'MicHeaderCapitalizationCheckerTest',
	#superclass : 'TestCase',
	#instVars : [
		'fileSystem',
		'checker'
	],
	#category : 'Microdown-Rules-Capitalization',
	#package : 'Microdown-Rules',
	#tag : 'Capitalization'
}

{ #category : 'running' }
MicHeaderCapitalizationCheckerTest >> generateFilesystemExample [

	| file |
	file := fileSystem workingDirectory / 'HeadersAreNotLowerCased.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '

## Header with Uppercases


' ].

	file := fileSystem workingDirectory / 'FirstWordOfHeadderNotCapitalized.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '

## header with first word in lowercase


' ].

	file := fileSystem workingDirectory / 'AfterColonLowercase.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '
## Today and tomorrow: the days
## Today: "the days"
' ].

	file := fileSystem workingDirectory / 'AfterColonCorrect.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '
## Today and tomorrow: The days
## Today: "The days"
	 ' ].
	
	file := fileSystem workingDirectory / 'WritingBooksCorrect.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '
## Writing Books
	 ' ].

	file := fileSystem workingDirectory / 'WritingBooksInPharo.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '
## Writing Books in Pharo
	 ' ].

	file := fileSystem workingDirectory / 'WritingBooksIncorrect.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '
## Writing books in Pharo
	 ' ].



	
]

{ #category : 'running' }
MicHeaderCapitalizationCheckerTest >> setUp [

	super setUp.
	fileSystem := FileSystem memory.
	self generateFilesystemExample.

	checker := MicHeaderCapitalizationChecker new.
	
]

{ #category : 'tests - headers should be lowercased' }
MicHeaderCapitalizationCheckerTest >> testCheckAfterColonCorrectLowercase [

	checker verifyLowercase.
	checker checkProject: fileSystem / 'AfterColonCorrect.md'.
	self deny: checker isOkay.
]

{ #category : 'tests - headers should be lowercased' }
MicHeaderCapitalizationCheckerTest >> testCheckAfterColonCorrectUppercase [

	checker verifyUppercase.
	checker checkProject: fileSystem / 'AfterColonCorrect.md'.
	self deny: checker isOkay.
]

{ #category : 'tests - headers should be lowercased' }
MicHeaderCapitalizationCheckerTest >> testCheckAfterColonLowercase [
| colonResult |
	checker verifyLowercase.
	checker checkProject: fileSystem / 'AfterColonLowercase.md'.
	self deny: checker isOkay.
	"trouver le result spécifique au mot après ':' "
	
	colonResult := (checker results detect: [:r | r class = MicElementAfterColonIsNotCapitalizedResult]).
	self assert: colonResult notNil. 
	self
		assert: colonResult explanation
		equals: 'Header: "Today and tomorrow: the days" in file/AfterColonLowercase.md contains a mistake: the as first letter after a colon should be uppercased.'.

]

{ #category : 'tests - headers should be lowercased' }
MicHeaderCapitalizationCheckerTest >> testCheckAfterColonUppercase [
| colonResult |
	checker verifyUppercase.
	checker checkProject: fileSystem / 'AfterColonLowercase.md'.
	self deny: checker isOkay.
	colonResult := (checker results detect: [:r | r class = MicElementAfterColonIsNotCapitalizedResult]).
	self assert: colonResult notNil.
	self
		assert: colonResult explanation
		equals: 'Header: "Today and tomorrow: the days" in file/AfterColonLowercase.md contains a mistake: the as first letter after a colon should be uppercased.'
]

{ #category : 'tests - headers should be lowercased' }
MicHeaderCapitalizationCheckerTest >> testCheckIdentifyHeaderFirstLetterNotCapitalized [

	checker verifyLowercase.
	checker checkProject: fileSystem / 'FirstWordOfHeadderNotCapitalized.md'.
	self deny: checker isOkay.
	
	self
		assert: checker results first explanation 
		equals: 'Header: "header with first word in lowercase" in file/FirstWordOfHeadderNotCapitalized.md contains a mistake: header as first word of the header should be uppercased.'
	
]

{ #category : 'tests - headers should be lowercased' }
MicHeaderCapitalizationCheckerTest >> testCheckIdentifyHeaderFirstLetterNotCapitalizedEvenInUppercase [

	checker verifyUppercase.
	checker checkProject: fileSystem / 'FirstWordOfHeadderNotCapitalized.md'.
	self deny: checker isOkay.
	
	self
		assert: checker results first explanation 
		equals: 'Header: "header with first word in lowercase" in file/FirstWordOfHeadderNotCapitalized.md contains a mistake: header as first word of the header should be uppercased.'
	
]

{ #category : 'tests - headers should be lowercased' }
MicHeaderCapitalizationCheckerTest >> testCheckIdentifyHeaderNotLowercased [

	checker verifyLowercase.
	checker checkProject: fileSystem / 'HeadersAreNotLowerCased.md'.
	self deny: checker isOkay.
	
	self
		assert: checker results first explanation
		equals:  'Header: "Header with Uppercases" in file/HeadersAreNotLowerCased.md contains a mistake: Uppercases should not be uppercased.'
		
]

{ #category : 'tests - configuration' }
MicHeaderCapitalizationCheckerTest >> testConfigurationPart [

	self 
		assert: (MicHeaderCapitalizationChecker configurationPartWithNewLine: Character cr asString)
		equals:  '{
	"HeaderCapitalization" : {
		"keepAs" : [
			"mini",
			"uDown"
		],
		"uppercase" : true
	}
}'
		
]

{ #category : 'tests - configuration' }
MicHeaderCapitalizationCheckerTest >> testConfigureFromLowercase [

	checker configureFrom: 
		{ ('uppercase' -> false) . 
			('keepAs' -> { 'mini' . 'uDown'  }) } asDictionary.
	self assert: (checker strategy isKindOf: MicRuleLowercaseHeaderStrategy).
	self assert: (checker keepAsIs includes: 'mini').
	self assert: (checker keepAsIs includes: 'uDown').
]

{ #category : 'tests - configuration' }
MicHeaderCapitalizationCheckerTest >> testConfigureFromNil [

	checker configureFrom: nil.
	self assert: (checker strategy isKindOf: MicRuleLowercaseHeaderStrategy).
]

{ #category : 'tests - configuration' }
MicHeaderCapitalizationCheckerTest >> testConfigureFromUppercase [

	checker configureFrom: 
		{ ('uppercase' -> true) . 
			('keepAs' -> { 'mini' . 'uDown'  }) } asDictionary.
	self assert: (checker strategy isKindOf: MicRuleUppercaseHeaderStrategy).
	self assert: (checker keepAsIs includes: 'mini').
	self assert: (checker keepAsIs includes: 'uDown').
]

{ #category : 'tests - headers should be lowercased' }
MicHeaderCapitalizationCheckerTest >> testWritingBooksCorrect [

	checker verifyUppercase.
	checker checkProject: fileSystem / 'WritingBooksCorrect.md'.
	self assert: checker isOkay.
]

{ #category : 'tests - headers should be lowercased' }
MicHeaderCapitalizationCheckerTest >> testWritingBooksInPharoCorrect [

	checker verifyUppercase.
	checker checkProject: fileSystem / 'WritingBooksInPharo.md'.
	self assert: checker isOkay.
]

{ #category : 'tests - headers should be lowercased' }
MicHeaderCapitalizationCheckerTest >> testWritingBooksIncorrect [

	checker verifyUppercase.
	checker checkProject: fileSystem / 'WritingBooksIncorrect.md'.
	self deny: checker isOkay.
	self assert: checker results size equals: 1.
	self assert: checker results first detail equals: 'books'.
]
