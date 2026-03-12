Class {
	#name : 'MicElementAfterColonIsNotCapitalizedResult',
	#superclass : 'MicAbstractResult',
	#instVars : [
		'detail'
	],
	#category : 'Microdown-Rules-EnglishTypographic',
	#package : 'Microdown-Rules',
	#tag : 'EnglishTypographic'
}

{ #category : 'accessing' }
MicElementAfterColonIsNotCapitalizedResult >> detail: aString [

	detail := aString
]

{ #category : 'accessing' }
MicElementAfterColonIsNotCapitalizedResult >> explanation [ 
			^ 'Header: "' , micElement text , '" in file' , fileReference fullName , ' contains a mistake: ', detail , ' as first letter after a colon should be uppercased.'
]
