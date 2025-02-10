"
I represent the fact that an achor is defined more than one.
"
Class {
	#name : 'MicDuplicatedAnchorResult',
	#superclass : 'MicAnchorResult',
	#category : 'Microdown-BookTester-Results',
	#package : 'Microdown-BookTester',
	#tag : 'Results'
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
