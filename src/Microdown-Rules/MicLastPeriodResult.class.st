Class {
	#name : 'MicLastPeriodResult',
	#superclass : 'MicAbstractResult',
	#instVars : [
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
