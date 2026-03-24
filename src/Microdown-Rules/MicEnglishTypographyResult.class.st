Class {
	#name : 'MicEnglishTypographyResult',
	#superclass : 'MicAbstractResult',
	#instVars : [
		'detail'
	],
	#category : 'Microdown-Rules-EnglishTypography',
	#package : 'Microdown-Rules',
	#tag : 'EnglishTypography'
}

{ #category : 'kinds' }
MicEnglishTypographyResult class >> headerString [

	^ 'English Typography Violations'
]

{ #category : 'accessing' }
MicEnglishTypographyResult >> detail: aString [ 
	detail := aString
]

{ #category : 'accessing' }
MicEnglishTypographyResult >> explanation [

	| text |
	text := micElement bodyString ifNil: [''].
	self flag: #todo.
	"this looks like a bug or hidden a bug!"
	
	^ 'Text: "' , text , '" in file' , fileReference fullName , ' contains a mistake: ', detail
]
