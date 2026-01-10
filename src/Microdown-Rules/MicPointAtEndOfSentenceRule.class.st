Class {
	#name : 'MicPointAtEndOfSentenceRule',
	#superclass : 'MicRule',
	#category : 'Microdown-Rules-Old',
	#package : 'Microdown-Rules',
	#tag : 'Old'
}

{ #category : 'action' }
MicPointAtEndOfSentenceRule >> sentenceEndByAPoint: aText [

(aText isEmpty or: [ aText last = $. ])
	ifTrue: [ ^ true ].
	
^ false.
]
