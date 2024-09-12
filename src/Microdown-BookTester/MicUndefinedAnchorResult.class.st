Class {
	#name : 'MicUndefinedAnchorResult',
	#superclass : 'MicAnchorResult',
	#category : 'Microdown-BookTester-Results',
	#package : 'Microdown-BookTester',
	#tag : 'Results'
}

{ #category : 'kinds' }
MicUndefinedAnchorResult class >> errorType [

	^ 'UndefinedAnchor'
]

{ #category : 'kinds' }
MicUndefinedAnchorResult class >> headerString [

	^ 'Undefined Anchors:'
]

{ #category : 'accessing' }
MicUndefinedAnchorResult >> isWhat [
	^  'undefined'
]
