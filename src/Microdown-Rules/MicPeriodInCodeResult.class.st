Class {
	#name : 'MicPeriodInCodeResult',
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
MicPeriodInCodeResult >> codeShouldEndWithPeriod: aBoolean [ 
	codeShouldEndWithPeriod := aBoolean 
]

{ #category : 'explanation' }
MicPeriodInCodeResult >> explanation [

	^ 'Text: "' , micElement bodyString , '" in file' , fileReference fullName , ' contains a mistake: It should'
	  , (codeShouldEndWithPeriod
			   ifFalse: [ ' not ' ]
			   ifTrue: [ ' ' ]) , 'be terminated with a period (.).'
]

{ #category : 'accessing' }
MicPeriodInCodeResult >> inFile: aFileReference [ 
	fileReference := aFileReference 
]

{ #category : 'accessing' }
MicPeriodInCodeResult >> micElement [

	^ micElement
]

{ #category : 'accessing' }
MicPeriodInCodeResult >> micElement: anObject [

	micElement := anObject
]
