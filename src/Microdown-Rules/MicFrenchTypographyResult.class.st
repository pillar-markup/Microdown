Class {
	#name : 'MicFrenchTypographyResult',
	#superclass : 'MicAbstractResult',
	#instVars : [
		'detail'
	],
	#category : 'Microdown-Rules-FrenchTypography',
	#package : 'Microdown-Rules',
	#tag : 'FrenchTypography'
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
	, '" in file' , fileReference fullName
	, ' contains a mistake: ' , detail
]
