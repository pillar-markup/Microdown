Class {
	#name : 'MicUseofWrongVocabularyResult',
	#superclass : 'MicResult',
	#instVars : [
		'pattern',
		'text',
		'micElement',
		'fileReference',
		'patternPair'
	],
	#category : 'Microdown-Rules-Vocabulary',
	#package : 'Microdown-Rules',
	#tag : 'Vocabulary'
}

{ #category : 'explain' }
MicUseofWrongVocabularyResult >> explanation [

	| wrongWord goodWord |
	wrongWord := patternPair key allButFirst allButLast.
	goodWord := patternPair value.
	^ 'Text: "' , micElement bodyString , '" in file' , fileReference fullName , ' contains a mistake: [' , wrongWord
	  , '] should not be used. We should use ' , goodWord
]

{ #category : 'kinds' }
MicUseofWrongVocabularyResult >> headerString [
    ^ 'Wrong Vocabulary'
]

{ #category : 'accessing' }
MicUseofWrongVocabularyResult >> inFile: aFileReference [ 
	fileReference := aFileReference
]

{ #category : 'accessing' }
MicUseofWrongVocabularyResult >> micElement: aMicElement [ 
	micElement := aMicElement 
]

{ #category : 'accessing' }
MicUseofWrongVocabularyResult >> patternPair: anAssociation [ 
	patternPair := anAssociation 
]
