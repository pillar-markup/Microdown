Class {
	#name : 'MicDoublePeriodResult',
	#superclass : 'MicAbstractResult',
	#category : 'Microdown-Rules-LastPeriod',
	#package : 'Microdown-Rules',
	#tag : 'LastPeriod'
}

{ #category : 'accessing' }
MicDoublePeriodResult >> explanation [

	^  '- Text: "' , micElement text , '" in file' , fileReference fullName , ' contains two periods.'
]
