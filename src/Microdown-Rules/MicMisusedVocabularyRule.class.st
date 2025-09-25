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

{ #category : 'examples' }
MicMisusedVocabularyRule class >> sample [
	<sampleInstance>
	| r |
	r := MicMisusedVocabularyRule new.
	r name: 'UseInstead'.
	r pairs: { 'sub-presenter' -> 'subpresenter' .
			'sub presenter' -> 'subpresenter' .
			'meta object' -> 'metaobject'}.
			
	^ r
]

{ #category : 'accessing' }
MicMisusedVocabularyRule >> computePatterns [
	^ pairs collect: [ :each | '*', each key, '*'  ]
]

{ #category : 'as yet unclassified' }
MicMisusedVocabularyRule >> goodWordFor: aString [ 
	
	| pair |
	pair := pairs detect: [ :each | each key = aString ].
	^ pair value
]

{ #category : 'accessing' }
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
