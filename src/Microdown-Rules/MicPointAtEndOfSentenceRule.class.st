Class {
	#name : 'MicPointAtEndOfSentenceRule',
	#superclass : 'MicRule',
	#category : 'Microdown-Rules-Others',
	#package : 'Microdown-Rules',
	#tag : 'Others'
}

{ #category : 'action' }
MicPointAtEndOfSentenceRule >> sentenceEndByAPoint: aText [

(aText isEmpty or: [ aText last = $. ])
	ifTrue: [ ^ true ].
	
^ false.
]
