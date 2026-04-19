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
	file := fileSystem workingDirectory / 'UppercaseNoStopWords.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '
## Writing Books
	 ' ].
	
	
	
	file := fileSystem workingDirectory / 'HeaderCorrectlyUppercased.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: '

## Header with Uppercases

' ].

	file := fileSystem workingDirectory / 'HeaderAllLowercase.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '

## header with first word in lowercase

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








	file := fileSystem workingDirectory
	        / 'AfterColonLowercaseUncorrect.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '
## Today and tomorrow: the days
## Today: "the days"
## Tomorrow: shouldBeUppercased
' ].

	file := fileSystem workingDirectory
	        / 'LowercasedStyleAfterColonCorrect.md'.
	file writeStreamDo: [ :stream |
			stream nextPutAll: '
## Today and tomorrow: The days
## Sun and moon: CorrectlyUppercased
	 ' ]
]

{ #category : 'running' }
MicHeaderCapitalizationCheckerTest >> setUp [

	super setUp.
	fileSystem := FileSystem memory.
	self generateFilesystemExample.

	checker := MicHeaderCapitalizationChecker new.
	
]

{ #category : 'tests - uppercase' }
MicHeaderCapitalizationCheckerTest >> testCheckAfterColonCorrectLowercase [
	
	self skip.
	checker verifyUppercase.
	checker keepAsIs: (Set new add: 'days'; add: 'tomorrow'; yourself).
	checker checkProject: fileSystem / 'AfterColonLowercaseUncorrect.md'.
	self deny: checker isOkay.
	checker results 
]

{ #category : 'tests - headers should be lowercased' }
MicHeaderCapitalizationCheckerTest >> testCheckAfterColonCorrectUppercase [
	
	self skip.
	checker verifyLowercase.
	checker checkProject: fileSystem / 'LowercasedStyleAfterColonCorrect.md'.
	self deny: checker isOkay.
	
	self assert: checker results size equals: 1.
	self assert: checker results first 
]

{ #category : 'tests - headers should be lowercased' }
MicHeaderCapitalizationCheckerTest >> testCheckAfterColonLowercase [
| colonResult |
	checker verifyLowercase.
	checker checkProject: fileSystem / 'AfterColonLowercaseUncorrect.md'.
	self deny: checker isOkay.
	"trouver le result spécifique au mot après ':' "
	
	colonResult := (checker results detect: [:r | r class = MicElementAfterColonIsNotCapitalizedResult]).
	self assert: colonResult notNil. 
	self
		assert: colonResult explanation
		equals: 'Header: "Today and tomorrow: the days" in file/AfterColonLowercaseUncorrect.md contains a mistake: the as first letter after a colon should be uppercased.'.

]

{ #category : 'tests - headers should be lowercased' }
MicHeaderCapitalizationCheckerTest >> testCheckAfterColonUppercase [
| colonResult |
	checker verifyUppercase.
	checker checkProject: fileSystem / 'AfterColonLowercaseUncorrect.md'.
	self deny: checker isOkay.
	colonResult := (checker results detect: [:r | r class = MicElementAfterColonIsNotCapitalizedResult]).
	self assert: colonResult notNil.
	self
		assert: colonResult explanation
		equals: 'Header: "Today and tomorrow: the days" in file/AfterColonLowercaseUncorrect.md contains a mistake: the as first letter after a colon should be uppercased.'
]

{ #category : 'tests - headers should be lowercased' }
MicHeaderCapitalizationCheckerTest >> testCheckIdentifyHeaderFirstLetterNotCapitalized [

	checker verifyLowercase.
	checker checkProject: fileSystem / 'HeaderAllLowercase.md'.
	self deny: checker isOkay.
	
	self
		assert: checker results first explanation 
		equals: 'Header: "header with first word in lowercase" in file/HeaderAllLowercase.md contains a mistake: header as first word of the header should be uppercased.'
	
]

{ #category : 'tests - headers should be lowercased' }
MicHeaderCapitalizationCheckerTest >> testCheckIdentifyHeaderFirstLetterNotCapitalizedEvenInUppercase [

	checker verifyUppercase.
	checker checkProject: fileSystem / 'HeaderAllLowercase.md'.
	self deny: checker isOkay.
	
	self
		assert: checker results first explanation 
		equals: 'Header: "header with first word in lowercase" in file/HeaderAllLowercase.md contains a mistake: header as first word of the header should be uppercased.'
	
]

{ #category : 'tests - headers should be lowercased' }
MicHeaderCapitalizationCheckerTest >> testCheckIdentifyHeaderNotLowercased [

	checker verifyLowercase.
	checker checkProject: fileSystem / 'HeaderCorrectlyUppercased.md'.
	self deny: checker isOkay.
	self
		assert: checker results first explanation
		equals:  'Header: "Header with Uppercases" in file/HeaderCorrectlyUppercased.md contains a mistake: Uppercases should be uppercased.'
		
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
MicHeaderCapitalizationCheckerTest >> testInLowercaseStyleWordsAfterColonShouldBeUppercased [

	self skip.
	checker verifyLowercase.
	checker checkProject:
		fileSystem / 'LowercasedStyleAfterColonCorrect.md'.
	self assert: checker isOkay.

	' ## Today and tomorrow: The days
## Sun and moon: CorrectlyUppercased'
]

{ #category : 'tests - lowercase' }
MicHeaderCapitalizationCheckerTest >> testKeepAsIsWhenLowercaseUppercasedSecondWordPasses [

	checker verifyLowercase.
	checker keepAsIs: #( 'Books' ).
	checker checkProject: fileSystem / 'UppercaseNoStopWords.md'.
	self assert: checker isOkay
]

{ #category : 'tests - lowercase' }
MicHeaderCapitalizationCheckerTest >> testWhenLowercaseUppercasedSecondWordIsFlagged [

	checker verifyLowercase.
	checker checkProject: fileSystem / 'UppercaseNoStopWords.md'.
	self deny: checker isOkay.
	self assert: checker results first detail equals: 'Books'
]

{ #category : 'tests - uppercase' }
MicHeaderCapitalizationCheckerTest >> testWhenUppercaseUppercasedNoStopWordPasses [

	checker verifyUppercase.
	checker checkProject: fileSystem / 'UppercaseNoStopWords.md'.
	self assert: checker isOkay
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
