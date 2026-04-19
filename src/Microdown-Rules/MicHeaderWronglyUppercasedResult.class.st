Class {
	#name : 'MicHeaderWronglyUppercasedResult',
	#superclass : 'MicWithDetailResult',
	#category : 'Microdown-Rules-Capitalization',
	#package : 'Microdown-Rules',
	#tag : 'Capitalization'
}

{ #category : 'accessing' }
MicHeaderWronglyUppercasedResult >> explanation [ 


	^ 'Header: "' , micElement text , '" in file' , fileReference fullName , ' contains a mistake: ', detail, ' should not be uppercased.'
	 
]
