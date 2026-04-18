Class {
	#name : 'MicHeaderCapitalizationCheckerStrategy',
	#superclass : 'Object',
	#instVars : [
		'checker'
	],
	#category : 'Microdown-Rules-Capitalization',
	#package : 'Microdown-Rules',
	#tag : 'Capitalization'
}

{ #category : 'as yet unclassified' }
MicHeaderCapitalizationCheckerStrategy >> checkColonCapitalizationIn: words of: aMicHeader [
 | size current next firstLetter firstWord |
 size := words size.
1 to: size - 1 do: [ :i |
	current := words at: i.
	(current endsWith: ':') ifTrue: [ 
		next := words at: i + 1.
		next notEmpty ifTrue: [
			firstLetter := next detect: [ :c | c isLetter] ifNone: [ nil ].
			(firstLetter notNil and: [ firstLetter isLowercase ]) ifTrue: [
				firstWord := next substrings first.
				checker addResult: (
				MicElementAfterColonIsNotCapitalizedResult new
					micElement: aMicHeader;
					detail: firstWord;
					inFile: aMicHeader fromFile)
					].
		] 
	]
].
]

{ #category : 'accessing' }
MicHeaderCapitalizationCheckerStrategy >> checker [

	^ checker
]

{ #category : 'accessing' }
MicHeaderCapitalizationCheckerStrategy >> checker: anObject [

	checker := anObject
]
