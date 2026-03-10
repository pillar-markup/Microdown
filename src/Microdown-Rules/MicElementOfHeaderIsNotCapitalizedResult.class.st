Class {
	#name : 'MicElementOfHeaderIsNotCapitalizedResult',
	#superclass : 'MicReport',
	#instVars : [
		'detail'
	],
	#category : 'Microdown-Rules-AfterColon',
	#package : 'Microdown-Rules',
	#tag : 'AfterColon'
}

{ #category : 'accessing' }
MicElementOfHeaderIsNotCapitalizedResult >> detail [
	^ detail 
]

{ #category : 'accessing' }
MicElementOfHeaderIsNotCapitalizedResult >> detail: aString [ 
	detail := aString
]
