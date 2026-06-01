"
I represent the fact that an achor is defined more than one.
"
Class {
	#name : 'MicDuplicatedAnchorResult',
	#superclass : 'MicAnchorResult',
	#category : 'Microdown-BookTester-Checker-References',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-References'
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
MicDuplicatedAnchorResult >> headerString [

	^ 'Duplicated Anchor'
]

{ #category : 'accessing' }
MicDuplicatedAnchorResult >> isWhat [
	^  'duplicated'
]
