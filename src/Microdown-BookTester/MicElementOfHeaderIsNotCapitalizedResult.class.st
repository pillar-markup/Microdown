Class {
	#name : 'MicElementOfHeaderIsNotCapitalizedResult',
	#superclass : 'MicWithDetailResult',
	#category : 'Microdown-BookTester-Checker-Capitalization',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-Capitalization'
}

{ #category : 'accessing' }
MicElementOfHeaderIsNotCapitalizedResult >> explanation [ 
	^ 'Header: "' , micElement text , '" in file ' , self inFile fullName , ' contains a mistake: ' , detail , ' should be capitalized.'
]

{ #category : 'kinds' }
MicElementOfHeaderIsNotCapitalizedResult >> headerString [

	^ 'Element of Header is not Capitalized'
]
