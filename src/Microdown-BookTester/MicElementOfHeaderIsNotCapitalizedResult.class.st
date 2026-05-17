Class {
	#name : 'MicElementOfHeaderIsNotCapitalizedResult',
	#superclass : 'MicWithDetailResult',
	#category : 'Microdown-BookTester-Checker-Capitalization',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-Capitalization'
}

{ #category : 'accessing' }
MicElementOfHeaderIsNotCapitalizedResult >> explanation [ 
	^ 'Header: "' , micElement text , '" in file' , fileReference fullName , ' contains a mistake: ' , detail , ' should be capitalized.'
]
