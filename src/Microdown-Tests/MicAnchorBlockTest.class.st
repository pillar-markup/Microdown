Class {
	#name : 'MicAnchorBlockTest',
	#superclass : 'MicBlockTest',
	#category : 'Microdown-Tests-Parser',
	#package : 'Microdown-Tests',
	#tag : 'Parser'
}

{ #category : 'tests' }
MicAnchorBlockTest >> subjectClass [ 
	^ MicAnchorBlock 
]

{ #category : 'tests' }
MicAnchorBlockTest >> testModifyLabel [
	| mic |
	mic := (parser parse: '@label') children first.
	self assert: mic label equals: 'label'.
	mic label: 'label2'.
	self assert: mic label equals: 'label2'.
]
