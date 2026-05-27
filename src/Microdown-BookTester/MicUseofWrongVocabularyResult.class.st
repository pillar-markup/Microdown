Class {
	#name : 'MicUseofWrongVocabularyResult',
	#superclass : 'MicResult',
	#instVars : [
		'patternPair'
	],
	#category : 'Microdown-BookTester-Checker-Vocabulary',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-Vocabulary'
}

{ #category : 'explain' }
MicUseofWrongVocabularyResult >> explanation [

	| wrongWord goodWord |
	wrongWord := patternPair key allButFirst allButLast.
	goodWord := patternPair value.
	^ 'Text: "' , micElement bodyString , '" in file' , self inFile fullName , ' contains a mistake: [' , wrongWord
	  , '] should not be used. We should use ' , goodWord
]

{ #category : 'accessing' }
MicUseofWrongVocabularyResult >> patternPair: anAssociation [ 
	patternPair := anAssociation 
]
