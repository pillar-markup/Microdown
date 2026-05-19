Class {
	#name : 'MicDoublePeriodResult',
	#superclass : 'MicAbstractResult',
	#category : 'Microdown-BookTester-Checker-LastPeriod',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-LastPeriod'
}

{ #category : 'accessing' }
MicDoublePeriodResult >> explanation [

	^  'Text: "' , micElement text , '" in file' , self inFile fullName , ' contains two periods.'
]
