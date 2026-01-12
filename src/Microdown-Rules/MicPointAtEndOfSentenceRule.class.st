Class {
	#name : 'MicPointAtEndOfSentenceRule',
	#superclass : 'MicRule',
	#category : 'Microdown-Rules-BogusImplementation',
	#package : 'Microdown-Rules',
	#tag : 'BogusImplementation'
}

{ #category : 'action' }
MicPointAtEndOfSentenceRule >> sentenceEndByAPoint: aText [

(aText isEmpty or: [ aText last = $. ])
	ifTrue: [ ^ true ].
	
^ false.
]
