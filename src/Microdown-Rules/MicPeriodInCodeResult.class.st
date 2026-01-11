Class {
	#name : 'MicPeriodInCodeResult',
	#superclass : 'MicLastPeriodResult',
	#category : 'Microdown-Rules-CodeLastPeriod',
	#package : 'Microdown-Rules',
	#tag : 'CodeLastPeriod'
}

{ #category : 'explanation' }
MicPeriodInCodeResult >> explanation [

	^ 'Text: "' , micElement body , '" in file' , fileReference fullName , ' contains a mistake: It should'
	  , (codeShouldEndWithPeriod
			   ifFalse: [ ' not ' ]
			   ifTrue: [ ' ' ]) , 'be terminated with a period (.).'
]
