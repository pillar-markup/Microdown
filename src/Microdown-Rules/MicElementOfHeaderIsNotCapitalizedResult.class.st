Class {
	#name : 'MicElementOfHeaderIsNotCapitalizedResult',
	#superclass : 'MicReport',
	#instVars : [
		'detail'
	],
	#category : 'Microdown-Rules-EnglishTypographic',
	#package : 'Microdown-Rules',
	#tag : 'EnglishTypographic'
}

{ #category : 'accessing' }
MicElementOfHeaderIsNotCapitalizedResult >> detail [
	^ detail 
]

{ #category : 'accessing' }
MicElementOfHeaderIsNotCapitalizedResult >> detail: aString [ 
	detail := aString
]
