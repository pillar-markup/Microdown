Class {
	#name : 'MicUseofWrongVocabularyReport',
	#superclass : 'Object',
	#instVars : [
		'text',
		'pattern',
		'file',
		'rule'
	],
	#category : 'Microdown-Rules',
	#package : 'Microdown-Rules'
}

{ #category : 'as yet unclassified' }
MicUseofWrongVocabularyReport >> explain [
	| wrongWord goodWord |
	wrongWord := pattern allButFirst allButLast.
	goodWord := rule goodWordFor: wrongWord. 
	^ 'Text: ', text bodyString,  ' in file', file fullName, ' contains a mistake: ', pattern , 'should not be used. We should use ', goodWord.
]

{ #category : 'as yet unclassified' }
MicUseofWrongVocabularyReport >> inFile [
	
	^ file
]

{ #category : 'as yet unclassified' }
MicUseofWrongVocabularyReport >> inFile: aFileReference [ 
	file := aFileReference
]

{ #category : 'as yet unclassified' }
MicUseofWrongVocabularyReport >> micElement: aMicText [

	text := aMicText 
]

{ #category : 'accessing' }
MicUseofWrongVocabularyReport >> pattern [

	^ pattern
]

{ #category : 'accessing' }
MicUseofWrongVocabularyReport >> pattern: anObject [

	pattern := anObject
]

{ #category : 'accessing' }
MicUseofWrongVocabularyReport >> rule: aRule [ 
	
	rule := aRule
]

{ #category : 'accessing' }
MicUseofWrongVocabularyReport >> text [

	^ text
]
