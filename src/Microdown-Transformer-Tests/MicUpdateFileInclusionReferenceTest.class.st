Class {
	#name : #MicUpdateFileInclusionReferenceTest,
	#superclass : #TestCase,
	#category : #'Microdown-Transformer-Tests'
}

{ #category : #private }
MicUpdateFileInclusionReferenceTest >> actualClass [
	^MicUpdateFileInclusionReference 
]

{ #category : #private }
MicUpdateFileInclusionReferenceTest >> testNewReferenceFor [
	|figure result |
	figure := MicFigureBlock new url: 'file://foo.mic'.
	result := self actualClass start: figure with: 'bar'.
	
	self assert: result url equals: 'file://bar/foo.mic'
]
