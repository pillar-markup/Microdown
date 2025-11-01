Class {
	#name : 'MicUseofWrongVocabularyReport',
	#superclass : 'MicReport',
	#instVars : [
		'pattern'
	],
	#category : 'Microdown-Rules-Others',
	#package : 'Microdown-Rules',
	#tag : 'Others'
}

{ #category : 'explain' }
MicUseofWrongVocabularyReport >> explain [
	| wrongWord goodWord |
	wrongWord := pattern allButFirst allButLast.
	goodWord := rule goodWordFor: wrongWord. 
	^ 'Text: ', text bodyString,  ' in file', file fullName, ' contains a mistake: ', pattern , 'should not be used. We should use ', goodWord.
]

{ #category : 'accessing' }
MicUseofWrongVocabularyReport >> pattern [

	^ pattern
]

{ #category : 'accessing' }
MicUseofWrongVocabularyReport >> pattern: anObject [

	pattern := anObject
]
