Class {
	#name : 'MicHeaderWronglyUppercasedResult',
	#superclass : 'MicWithDetailResult',
	#category : 'Microdown-BookTester-Checker-Capitalization',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-Capitalization'
}

{ #category : 'accessing' }
MicHeaderWronglyUppercasedResult >> explanation [ 


	^ 'Header: "' , micElement text , '" in file' , self inFile fullName , ' contains a mistake: ', detail, ' should not be uppercased.'
	 
]

{ #category : 'kinds' }
MicHeaderWronglyUppercasedResult >> headerString [

	^ 'Header Wrongly Uppercased'
]
