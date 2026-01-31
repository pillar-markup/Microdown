Class {
	#name : 'MicAbstractResult',
	#superclass : 'MicResult',
	#instVars : [
		'micElement',
		'fileReference'
	],
	#category : 'Microdown-Rules-CodeLastPeriod',
	#package : 'Microdown-Rules',
	#tag : 'CodeLastPeriod'
}

{ #category : 'accessing' }
MicAbstractResult >> fileReference [

	^ fileReference
]

{ #category : 'accessing' }
MicAbstractResult >> fileReference: anObject [

	fileReference := anObject
]

{ #category : 'accessing' }
MicAbstractResult >> inFile: aFileReference [ 
	fileReference := aFileReference 
]

{ #category : 'accessing' }
MicAbstractResult >> micElement [

	^ micElement
]

{ #category : 'accessing' }
MicAbstractResult >> micElement: aMicElement [ 
	micElement := aMicElement
]
