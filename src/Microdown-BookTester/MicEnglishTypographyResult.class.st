Class {
	#name : 'MicEnglishTypographyResult',
	#superclass : 'MicResult',
	#instVars : [
		'detail'
	],
	#category : 'Microdown-BookTester-Checker-EnglishTypography',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-EnglishTypography'
}

{ #category : 'kinds' }
MicEnglishTypographyResult class >> headerString [

	^ 'English Typography Violations'
]

{ #category : 'accessing' }
MicEnglishTypographyResult >> detail [

	^ detail
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

{ #category : 'kinds' }
MicEnglishTypographyResult >> headerString [ 
	^ 'English Typography violations'
]
