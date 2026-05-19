Class {
	#name : 'MicFirstElementOfHeaderIsNotCapitalizedResult',
	#superclass : 'MicWithDetailResult',
	#category : 'Microdown-BookTester-Checker-Capitalization',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-Capitalization'
}

{ #category : 'accessing' }
MicFirstElementOfHeaderIsNotCapitalizedResult >> explanation [ 


	^ 'Header: "' , micElement text , '" in file' , self inFile fullName , ' contains a mistake: ', detail, ' as first word of the header should be uppercased.'
	 
]
