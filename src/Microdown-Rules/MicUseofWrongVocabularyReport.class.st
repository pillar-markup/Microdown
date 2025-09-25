Class {
	#name : 'MicUseofWrongVocabularyReport',
	#superclass : 'Object',
	#instVars : [
		'text',
		'pattern',
		'file'
	],
	#category : 'Microdown-Rules',
	#package : 'Microdown-Rules'
}

{ #category : 'as yet unclassified' }
MicUseofWrongVocabularyReport >> explain [

	^ text bodyString,  ' in file', file fullName, ' contains a mistake: ', pattern
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
MicUseofWrongVocabularyReport >> text [

	^ text
]
