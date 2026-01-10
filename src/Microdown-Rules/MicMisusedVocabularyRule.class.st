Class {
	#name : 'MicMisusedVocabularyRule',
	#superclass : 'MicRule',
	#instVars : [
		'pairs',
		'matchingPatterns'
	],
	#category : 'Microdown-Rules-Others',
	#package : 'Microdown-Rules',
	#tag : 'Others'
}

{ #category : 'examples' }
MicMisusedVocabularyRule class >> sample [

	<sampleInstance>
	| r |
	r := MicMisusedVocabularyRule new.
	r name: 'UseInstead'.
	r pairs: {
			('sub-presenter' -> 'subpresenter').
			('sub presenter' -> 'subpresenter').
			('meta object' -> 'metaobject').
			('section' -> 'Section').
			('figure' -> 'Figure'). 
			('back-end' -> 'backend'). 
			('back end' -> 'backend'). 
			('Pharo Image' -> 'Pharo image')}.

	^ r
]

{ #category : 'accessing' }
MicMisusedVocabularyRule >> computePatterns [
	^ pairs collect: [ :each | '*', each key, '*'  ]
]

{ #category : 'accessing' }
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
MicMisusedVocabularyRule >> pairs [
	^ pairs
]

{ #category : 'accessing' }
MicMisusedVocabularyRule >> pairs: aCollection [ 
	pairs := aCollection
]
