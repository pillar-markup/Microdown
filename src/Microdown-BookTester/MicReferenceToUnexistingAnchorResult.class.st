"
I represent the fact that a reference refers to an undefined anchor.
"
Class {
	#name : 'MicReferenceToUnexistingAnchorResult',
	#superclass : 'MicAnchorResult',
	#category : 'Microdown-BookTester-Results',
	#package : 'Microdown-BookTester',
	#tag : 'Results'
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
