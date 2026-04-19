Class {
	#name : 'MicWithDetailResult',
	#superclass : 'MicAbstractResult',
	#instVars : [
		'detail'
	],
	#category : 'Microdown-Rules-Capitalization',
	#package : 'Microdown-Rules',
	#tag : 'Capitalization'
}

{ #category : 'accessing' }
MicWithDetailResult >> detail [
	^ detail
]

{ #category : 'accessing' }
MicWithDetailResult >> detail: aString [ 
	
	detail := aString
]

{ #category : 'printing' }
MicWithDetailResult >> printOn: aStream [

	super printOn: aStream. 
	aStream nextPutAll: ' (', detail, ')'
]
