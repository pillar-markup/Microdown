Class {
	#name : 'MicElementOfHeaderWronglyUppercasedResult',
	#superclass : 'MicAbstractResult',
	#instVars : [
		'detail'
	],
	#category : 'Microdown-Rules-Capitalization',
	#package : 'Microdown-Rules',
	#tag : 'Capitalization'
}

{ #category : 'accessing' }
MicElementOfHeaderWronglyUppercasedResult >> detail: aString [ 
	
	detail := aString
]

{ #category : 'accessing' }
MicElementOfHeaderWronglyUppercasedResult >> explanation [ 


	^ 'Header: "' , micElement text , '" in file' , fileReference fullName , ' contains a mistake: ', detail, ' should be uppercased.'
	 
]
