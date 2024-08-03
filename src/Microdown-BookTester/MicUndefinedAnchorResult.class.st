Class {
	#name : 'MicUndefinedAnchorResult',
	#superclass : 'MicAnchorResult',
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'kinds' }
MicUndefinedAnchorResult class >> headerString [

	^ 'Undefined Anchors:'
]

{ #category : 'accessing' }
MicUndefinedAnchorResult >> isWhat [
	^  'undefined'
]
