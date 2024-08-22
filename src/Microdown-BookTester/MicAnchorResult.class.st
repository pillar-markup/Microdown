Class {
	#name : 'MicAnchorResult',
	#superclass : 'MicResult',
	#instVars : [
		'anchorLabel'
	],
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'kinds' }
MicAnchorResult class >> errorType [

	^ 'UndefinedAnchor'
]

{ #category : 'accessing' }
MicAnchorResult >> StonFormatExplanation [

	^ '"', anchorLabel , '" : "', source,'"'
	
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
