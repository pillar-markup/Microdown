Class {
	#name : 'MicMisusedVocabularyRule',
	#superclass : 'MicRule',
	#instVars : [
		'name',
		'pairs',
		'matchingPatterns'
	],
	#category : 'Microdown-Rules',
	#package : 'Microdown-Rules'
}

{ #category : 'as yet unclassified' }
MicMisusedVocabularyRule >> computePatterns [
	^ pairs collect: [ :each | '*', each key, '*'  ]
]

{ #category : 'as yet unclassified' }
MicMisusedVocabularyRule >> matchingPatterns [
	^ matchingPatterns ifNil: [ matchingPatterns := self computePatterns]
]

{ #category : 'accessing' }
MicMisusedVocabularyRule >> name: aString [ 
	name := aString
]

{ #category : 'accessing' }
MicMisusedVocabularyRule >> pairs [
	^ pairs
]

{ #category : 'accessing' }
MicMisusedVocabularyRule >> pairs: aCollection [ 
	pairs := aCollection
]
