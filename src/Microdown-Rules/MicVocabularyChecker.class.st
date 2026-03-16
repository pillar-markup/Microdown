Class {
	#name : 'MicVocabularyChecker',
	#superclass : 'MicChecker',
	#instVars : [
		'patternPairs'
	],
	#category : 'Microdown-Rules-Vocabulary',
	#package : 'Microdown-Rules',
	#tag : 'Vocabulary'
}

{ #category : 'visiting - inline elements' }
MicVocabularyChecker >> checkText: aMicText [
	| text sortedPairs |
	
	text := aMicText bodyString asLowercase.
	sortedPairs := patternPairs asSortedCollection: [ :a :b | a key size > b key size ].
	sortedPairs do: [  :patternPair |
		| pattern |
		pattern := patternPair key asLowercase.
		(text includesSubstring: pattern ) ifTrue: [ 
			results add: (
				MicUseofWrongVocabularyResult new
					micElement: aMicText;
					inFile: aMicText fromFile;
					patternPair: patternPair;
					yourself 
			).
			text := text copyReplaceAll: pattern with: '' 
			 ].
		 ].
]

{ #category : 'visiting - inline elements' }
MicVocabularyChecker >> pairs: aCollectionOfPairs [

	patternPairs := aCollectionOfPairs
	
]

{ #category : 'visiting - inline elements' }
MicVocabularyChecker >> visitText: aMicText [

	self checkText: aMicText
]
