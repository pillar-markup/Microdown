"
I represent the fact that a reference refers to an undefined anchor.
"
Class {
	#name : 'MicReferenceToUnexistingAnchorResult',
	#superclass : 'MicAnchorResult',
	#category : 'Microdown-BookTester-References',
	#package : 'Microdown-BookTester',
	#tag : 'References'
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
MicReferenceToUnexistingAnchorResult >> isWhat [
	^  'undefined'
]
