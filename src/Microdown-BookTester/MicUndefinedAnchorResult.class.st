Class {
	#name : 'MicUndefinedAnchorResult',
	#superclass : 'MicAnchorResult',
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'accessing' }
MicUndefinedAnchorResult >> explanation [

	^ 'Anchor ', anchorLabel, ' is ', self isWhat, ' in file: ', source
	
]

{ #category : 'accessing' }
MicUndefinedAnchorResult >> isWhat [
	^  'undefined'
]
