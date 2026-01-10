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

{ #category : 'main API' }
MicVocabularyChecker >> checkProject: aFileReference [

	| collector |
	collector := self fileCollectorForMainFileReference: aFileReference.
	collector visitedFilesAsDOM do: [ :each | each accept: self ]
]

{ #category : 'visiting - inline elements' }
MicVocabularyChecker >> checkText: aMicText [

	patternPairs do: [ :patternPair |
			"note that match: ignore upper/lower case differences."
			(patternPair key match: aMicText bodyString ) ifTrue: [
					results add: (MicUseofWrongVocabularyResult new
							 micElement: aMicText;
							 inFile: aMicText fromFile;
							 patternPair: patternPair) ] ]
]

{ #category : 'testing' }
MicVocabularyChecker >> isOkay [
	^ results isEmpty 
]

{ #category : 'visiting - inline elements' }
MicVocabularyChecker >> pairs: aCollectionOfPairs [

	patternPairs := aCollectionOfPairs collect: [ :each | ('*' , each key , '*') -> each value  ] 
	
]

{ #category : 'visiting - inline elements' }
MicVocabularyChecker >> visitText: aMicText [

	self checkText: aMicText
]
