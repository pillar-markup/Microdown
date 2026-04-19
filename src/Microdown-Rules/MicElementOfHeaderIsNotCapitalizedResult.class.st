Class {
	#name : 'MicElementOfHeaderIsNotCapitalizedResult',
	#superclass : 'MicAbstractResult',
	#instVars : [
		'detail'
	],
	#category : 'Microdown-Rules-Capitalization',
	#package : 'Microdown-Rules',
	#tag : 'Capitalization'
}

{ #category : 'accessing' }
MicElementOfHeaderIsNotCapitalizedResult >> detail [
	^ detail 
]

{ #category : 'accessing' }
MicElementOfHeaderIsNotCapitalizedResult >> detail: aString [ 
	detail := aString
]

{ #category : 'accessing' }
MicElementOfHeaderIsNotCapitalizedResult >> explanation [ 
	^ 'Header: "' , micElement text , '" in file' , fileReference fullName , ' contains a mistake: ' , detail , ' should be capitalized.'
]

{ #category : 'printing' }
MicElementOfHeaderIsNotCapitalizedResult >> printOn: aStream [

	super printOn: aStream. 
	aStream nextPutAll: ' (', detail, ')'
]
