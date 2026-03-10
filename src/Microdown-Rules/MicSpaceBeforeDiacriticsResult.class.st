Class {
	#name : 'MicSpaceBeforeDiacriticsResult',
	#superclass : 'MicAbstractResult',
	#instVars : [
		'detail'
	],
	#category : 'Microdown-Rules-EnglishTypos',
	#package : 'Microdown-Rules',
	#tag : 'EnglishTypos'
}

{ #category : 'as yet unclassified' }
MicSpaceBeforeDiacriticsResult >> detail: aString [ 
	detail := aString
]

{ #category : 'accessing' }
MicSpaceBeforeDiacriticsResult >> explanation [

	| text |
	text := micElement bodyString ifNil: [''].

	^ 'Text: "' , text , '" in file' , fileReference fullName , ' contains a mistake: ', detail
]
