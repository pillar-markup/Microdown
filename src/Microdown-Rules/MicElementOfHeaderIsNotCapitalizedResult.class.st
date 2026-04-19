Class {
	#name : 'MicElementOfHeaderIsNotCapitalizedResult',
	#superclass : 'MicWithDetailResult',
	#category : 'Microdown-Rules-Capitalization',
	#package : 'Microdown-Rules',
	#tag : 'Capitalization'
}

{ #category : 'accessing' }
MicElementOfHeaderIsNotCapitalizedResult >> explanation [ 
	^ 'Header: "' , micElement text , '" in file' , fileReference fullName , ' contains a mistake: ' , detail , ' should be capitalized.'
]
