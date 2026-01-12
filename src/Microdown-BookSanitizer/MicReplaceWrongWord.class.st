Class {
	#name : 'MicReplaceWrongWord',
	#superclass : 'MicAbstractSanitizer',
	#category : 'Microdown-BookSanitizer-ToCure',
	#package : 'Microdown-BookSanitizer',
	#tag : 'ToCure'
}

{ #category : 'private' }
MicReplaceWrongWord >> sanitize: aText [

	| dictionary orderedKeys aLocalText |
	
	aLocalText := aText .
	
	dictionary := MicMisusedVocabularyRule sample pairs asDictionary.

	orderedKeys := dictionary keys asSortedCollection: [ :a :b | a size > b size ].

	orderedKeys do: [ :key |
		       aLocalText := aLocalText copyReplaceAll: key with: (dictionary at: key) ].
	
	^ aLocalText .
]
