Class {
	#name : 'MicFrenchTypographyResult',
	#superclass : 'MicResult',
	#instVars : [
		'detail'
	],
	#category : 'Microdown-BookTester-Checker-FrenchTypography',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-FrenchTypography'
}

{ #category : 'accessing' }
MicFrenchTypographyResult >> detail [

	^ detail
]

{ #category : 'accessing' }
MicFrenchTypographyResult >> detail: aString [

	detail := aString 
]

{ #category : 'accessing' }
MicFrenchTypographyResult >> explanation [ 
	| text |
	text := micElement bodyString ifNil: [ '' ].
	^ 'Text: "' , text 
	, '" in file' , self inFile fullName
	, ' contains a mistake: ' , detail
]

{ #category : 'kinds' }
MicFrenchTypographyResult >> headerString [

	^ 'French Typography'
]
