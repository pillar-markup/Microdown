"
I'm the superclass of problem related to anchors.
"
Class {
	#name : 'MicAnchorResult',
	#superclass : 'MicResult',
	#instVars : [
		'anchorLabel'
	],
	#category : 'Microdown-BookTester-Checker-References',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-References'
}

{ #category : 'kinds' }
MicAnchorResult class >> errorType [
	"The error type of a result is used by the report writer to group problems."
	
	^ 'Anchor problem'
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

	^ 'Anchor ', anchorLabel, ' is ', self isWhat, ' in file: ', fileReference fullName
	
]

{ #category : 'accessing' }
MicAnchorResult >> isWhat [
	^  'anchor problem'
]

{ #category : 'accessing' }
MicAnchorResult >> stonFormatExplanation [

	^ Association new key: anchorLabel value: fileReference
	
]
