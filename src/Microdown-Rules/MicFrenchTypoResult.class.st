Class {
	#name : 'MicFrenchTypoResult',
	#superclass : 'MicAbstractResult',
	#instVars : [
		'detail'
	],
	#category : 'Microdown-Rules-FrenchTypography',
	#package : 'Microdown-Rules',
	#tag : 'FrenchTypography'
}

{ #category : 'accessing' }
MicFrenchTypoResult >> detail [

	^ detail
]

{ #category : 'accessing' }
MicFrenchTypoResult >> detail: aString [

	detail := aString 
]

{ #category : 'accessing' }
MicFrenchTypoResult >> explanation [ 
	| text |
	text := micElement bodyString ifNil: [ '' ].
	^ 'Text: "' , text 
	, '" in file' , fileReference fullName
	, ' contains a mistake: ' , detail
]
