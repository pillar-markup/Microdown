Class {
	#name : 'MicFirstElementOfHeaderIsNotCapitalizedResult',
	#superclass : 'MicWithDetailResult',
	#category : 'Microdown-Rules-Capitalization',
	#package : 'Microdown-Rules',
	#tag : 'Capitalization'
}

{ #category : 'accessing' }
MicFirstElementOfHeaderIsNotCapitalizedResult >> explanation [ 


	^ 'Header: "' , micElement text , '" in file' , fileReference fullName , ' contains a mistake: ', detail, ' as first word of the header should be uppercased.'
	 
]
