Class {
	#name : 'MicAbstractResult',
	#superclass : 'MicResult',
	#instVars : [
		'micElement',
		'fileReference'
	],
	#category : 'Microdown-BookTester-Checker-LastPeriod',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-LastPeriod'
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

{ #category : 'accessing' }
MicAbstractResult >> sourceFileReference [
	^ fileReference 
]
