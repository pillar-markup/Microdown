Class {
	#name : 'MicLastPeriodResult',
	#superclass : 'MicResult',
	#instVars : [
		'micElement',
		'fileReference',
		'codeShouldEndWithPeriod'
	],
	#category : 'Microdown-Rules-CodeLastPeriod',
	#package : 'Microdown-Rules',
	#tag : 'CodeLastPeriod'
}

{ #category : 'accessing' }
MicLastPeriodResult >> codeShouldEndWithPeriod: aBoolean [ 
	codeShouldEndWithPeriod := aBoolean 
]

{ #category : 'accessing' }
MicLastPeriodResult >> inFile: aFileReference [ 
	fileReference := aFileReference 
]

{ #category : 'accessing' }
MicLastPeriodResult >> micElement [

	^ micElement
]

{ #category : 'accessing' }
MicLastPeriodResult >> micElement: anObject [

	micElement := anObject
]
