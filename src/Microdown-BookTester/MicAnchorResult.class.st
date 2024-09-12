Class {
	#name : 'MicAnchorResult',
	#superclass : 'MicResult',
	#instVars : [
		'anchorLabel'
	],
	#category : 'Microdown-BookTester-Results',
	#package : 'Microdown-BookTester',
	#tag : 'Results'
}

{ #category : 'kinds' }
MicAnchorResult class >> errorType [

	^ 'UndefinedAnchor'
]

{ #category : 'accessing' }
MicAnchorResult >> anchorLabel [

	^ anchorLabel
]

{ #category : 'accessing' }
MicAnchorResult >> anchorLabel: anObject [

	anchorLabel := anObject
]

{ #category : 'accessing' }
MicAnchorResult >> explanation [

	^ 'Anchor ', anchorLabel, ' is ', self isWhat, ' in file: ', source
	
]

{ #category : 'accessing' }
MicAnchorResult >> isWhat [
	^  'undefined'
]

{ #category : 'accessing' }
MicAnchorResult >> stonFormatExplanation [

	^ Association new key: anchorLabel value: source
	
]
