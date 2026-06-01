Class {
	#name : 'MicElementAfterColonIsNotCapitalizedResult',
	#superclass : 'MicWithDetailResult',
	#category : 'Microdown-BookTester-Checker-Capitalization',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-Capitalization'
}

{ #category : 'accessing' }
MicElementAfterColonIsNotCapitalizedResult >> explanation [ 
			^ 'Header: "' , micElement text , '" in file' , self inFile fullName , ' contains a mistake: ', detail , ' as first letter after a colon should be uppercased.'
]

{ #category : 'kinds' }
MicElementAfterColonIsNotCapitalizedResult >> headerString [

	^ 'Element After Conolis Not Capitalized'
]
