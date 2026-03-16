Class {
	#name : 'MicSpaceBeforeDiacriticsResult',
	#superclass : 'MicAbstractResult',
	#instVars : [
		'detail'
	],
	#category : 'Microdown-Rules-EnglishTypographic',
	#package : 'Microdown-Rules',
	#tag : 'EnglishTypographic'
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
