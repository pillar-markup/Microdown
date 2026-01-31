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


' ]




	
]

{ #category : 'running' }
MicHeaderCapitalizationCheckerTest >> setUp [

	super setUp.
	fileSystem := FileSystem memory.
	self generateFilesystemExample.

	checker := MicRuleHeaderChecker new.
	
]

{ #category : 'running' }
MicHeaderCapitalizationCheckerTest >> testCheckIdentifyHeaderFirstLetterNotCapitalized [

	checker verifyLowercase.
	checker checkProject: fileSystem / 'FirstWordOfHeadderNotCapitalized.md'.
	self deny: checker isOkay.
	
	self
		assert: checker results first explanation 
		equals: 'Header: "header with first word in lowercase" in file/FirstWordOfHeadderNotCapitalized.md contains a mistake: header as first word of the header should be uppercased.'
	
]

{ #category : 'running' }
MicHeaderCapitalizationCheckerTest >> testCheckIdentifyHeaderNotLowercased [

	checker verifyLowercase.
	checker checkProject: fileSystem / 'HeadersAreNotLowerCased.md'.
	self deny: checker isOkay.
	
	self
		assert: checker results first explanation
		equals:  'Header: "Header with Uppercases" in file/HeadersAreNotLowerCased.md contains a mistake: Uppercases should not be uppercased.'
		
]
