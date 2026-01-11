Class {
	#name : 'MicPeriodInCaptionResult',
	#superclass : 'MicLastPeriodResult',
	#category : 'Microdown-Rules-CodeLastPeriod',
	#package : 'Microdown-Rules',
	#tag : 'CodeLastPeriod'
}

{ #category : 'accessing' }
MicPeriodInCaptionResult >> explanation [
	"not sure that text is ok
	we should have a common way to express caption between block, figure, and math"

	^ 'Text: "' , micElement text , '" in file' , fileReference fullName , ' contains a mistake: Captions should'
	  , (codeShouldEndWithPeriod
			   ifFalse: [ ' not ' ]
			   ifTrue: [ ' ' ]) , 'be terminated with a period (.).'
]
