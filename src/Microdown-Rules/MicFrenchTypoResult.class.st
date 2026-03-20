Class {
	#name : 'MicFrenchTypoResult',
	#superclass : 'MicAbstractResult',
	#instVars : [
		'detail'
	],
	#category : 'Microdown-Rules-FrenchTypo',
	#package : 'Microdown-Rules',
	#tag : 'FrenchTypo'
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
