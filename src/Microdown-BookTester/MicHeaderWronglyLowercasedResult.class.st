Class {
	#name : 'MicHeaderWronglyLowercasedResult',
	#superclass : 'MicHeaderWronglyUppercasedResult',
	#category : 'Microdown-BookTester-Checker-Capitalization',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-Capitalization'
}

{ #category : 'accessing' }
MicHeaderWronglyLowercasedResult >> explanation [ 


	^ 'Header: "' , micElement text , '" in file' , fileReference fullName , ' contains a mistake: ', detail, ' should not be lowercased.'
	 
]
