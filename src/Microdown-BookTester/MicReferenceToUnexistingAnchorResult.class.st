"
I represent the fact that a reference refers to an undefined anchor.
"
Class {
	#name : 'MicReferenceToUnexistingAnchorResult',
	#superclass : 'MicAnchorResult',
	#category : 'Microdown-BookTester-Checker-References',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-References'
}

{ #category : 'kinds' }
MicReferenceToUnexistingAnchorResult class >> errorType [

	^ 'UndefinedAnchor'
]

{ #category : 'kinds' }
MicReferenceToUnexistingAnchorResult class >> headerString [

	^ 'Undefined Anchors:'
]

{ #category : 'accessing' }
MicReferenceToUnexistingAnchorResult >> headerString [

	^ 'Reference To Unexisting Anchor'
]

{ #category : 'accessing' }
MicReferenceToUnexistingAnchorResult >> isWhat [
	^  'undefined'
]
