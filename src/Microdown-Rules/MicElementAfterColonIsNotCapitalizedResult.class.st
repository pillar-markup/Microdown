Class {
	#name : 'MicElementAfterColonIsNotCapitalizedResult',
	#superclass : 'MicWithDetailResult',
	#category : 'Microdown-Rules-Capitalization',
	#package : 'Microdown-Rules',
	#tag : 'Capitalization'
}

{ #category : 'accessing' }
MicElementAfterColonIsNotCapitalizedResult >> explanation [ 
			^ 'Header: "' , micElement text , '" in file' , fileReference fullName , ' contains a mistake: ', detail , ' as first letter after a colon should be uppercased.'
]
