Class {
	#name : 'MicElementAfterColonIsNotCapitalizedResult',
	#superclass : 'MicAbstractResult',
	#instVars : [
		'detail'
	],
	#category : 'Microdown-Rules-AfterColon',
	#package : 'Microdown-Rules',
	#tag : 'AfterColon'
}

{ #category : 'accessing' }
MicElementAfterColonIsNotCapitalizedResult >> detail: aString [

	detail := aString
]

{ #category : 'accessing' }
MicElementAfterColonIsNotCapitalizedResult >> explanation [ 
			^ 'Header: "' , micElement text , '" in file' , fileReference fullName , ' contains a mistake: ', detail , ' as first letter after a colon should be uppercased.'
]
