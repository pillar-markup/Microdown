Class {
	#name : 'MicDoublePeriodResult',
	#superclass : 'MicAbstractResult',
	#category : 'Microdown-BookTester-Checker-LastPeriod',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-LastPeriod'
}

{ #category : 'accessing' }
MicDoublePeriodResult >> explanation [

	^  'Text: "' , micElement text , '" in file' , fileReference fullName , ' contains two periods.'
]
