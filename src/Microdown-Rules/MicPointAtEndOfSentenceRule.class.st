Class {
	#name : 'MicPointAtEndOfSentenceRule',
	#superclass : 'MicRule',
	#category : 'Microdown-Rules-Others',
	#package : 'Microdown-Rules',
	#tag : 'Others'
}

{ #category : 'as yet unclassified' }
MicPointAtEndOfSentenceRule >> sentenceEndByAPoint: aText [

(aText isEmpty or: [ aText last = $. ])
	ifTrue: [ ^ true ].
	
^ false.
]
