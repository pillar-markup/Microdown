Class {
	#name : 'MicElementOfHeaderWronglyUppercasedResult',
	#superclass : 'MicResult',
	#instVars : [
		'micElement',
		'fileReference',
		'detail'
	],
	#category : 'Microdown-Rules-Capitalization',
	#package : 'Microdown-Rules',
	#tag : 'Capitalization'
}

{ #category : 'accessing' }
MicElementOfHeaderWronglyUppercasedResult >> detail: aString [ 
	
	detail := aString
]

{ #category : 'accessing' }
MicElementOfHeaderWronglyUppercasedResult >> explanation [ 


	^ 'Header: "' , micElement text , '" in file' , fileReference fullName , ' contains a mistake: ', detail, ' should not be uppercased.'
	 
]

{ #category : 'accessing' }
MicElementOfHeaderWronglyUppercasedResult >> fileReference [

	^ fileReference
]

{ #category : 'accessing' }
MicElementOfHeaderWronglyUppercasedResult >> fileReference: anObject [

	fileReference := anObject
]

{ #category : 'accessing' }
MicElementOfHeaderWronglyUppercasedResult >> inFile: aFileReference [ 
	fileReference := aFileReference 
]

{ #category : 'accessing' }
MicElementOfHeaderWronglyUppercasedResult >> micElement [

	^ micElement
]

{ #category : 'accessing' }
MicElementOfHeaderWronglyUppercasedResult >> micElement: anObject [

	micElement := anObject
]
