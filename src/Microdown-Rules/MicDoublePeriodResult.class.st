Class {
	#name : 'MicDoublePeriodResult',
	#superclass : 'MicAbstractResult',
	#category : 'Microdown-Rules-CodeLastPeriod',
	#package : 'Microdown-Rules',
	#tag : 'CodeLastPeriod'
}

{ #category : 'accessing' }
MicDoublePeriodResult >> explanation [

	^  '- Text: "' , micElement text , '" in file' , fileReference fullName , ' contains two periods.'
]
