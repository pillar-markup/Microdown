Class {
	#name : 'MicHeaderWronglyLowercasedResult',
	#superclass : 'MicHeaderWronglyUppercasedResult',
	#category : 'Microdown-Rules-Capitalization',
	#package : 'Microdown-Rules',
	#tag : 'Capitalization'
}

{ #category : 'accessing' }
MicHeaderWronglyLowercasedResult >> explanation [ 


	^ 'Header: "' , micElement text , '" in file' , fileReference fullName , ' contains a mistake: ', detail, ' should not be lowercased.'
	 
]
