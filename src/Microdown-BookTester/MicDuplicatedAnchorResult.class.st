Class {
	#name : 'MicDuplicatedAnchorResult',
	#superclass : 'MicAnchorResult',
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'kinds' }
MicDuplicatedAnchorResult class >> errorType [

	^ 'DuplicatedAnchor'
]

{ #category : 'kinds' }
MicDuplicatedAnchorResult class >> headerString [

	^ 'Duplicated Anchors:'
]

{ #category : 'accessing' }
MicDuplicatedAnchorResult >> isWhat [
	^  'duplicated'
]
