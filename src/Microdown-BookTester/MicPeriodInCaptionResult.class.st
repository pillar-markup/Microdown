Class {
	#name : 'MicPeriodInCaptionResult',
	#superclass : 'MicLastPeriodResult',
	#category : 'Microdown-BookTester-Checker-LastPeriod',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-LastPeriod'
}

{ #category : 'accessing' }
MicPeriodInCaptionResult >> explanation [
	"not sure that text is ok
	we should have a common way to express caption between block, figure, and math"

	^ 'Text: "' , micElement text , '" in file' , self inFile fullName , ' contains a mistake: Captions should'
	  , (codeShouldEndWithPeriod
			   ifFalse: [ ' not ' ]
			   ifTrue: [ ' ' ]) , 'be terminated with a period (.).'
]

{ #category : 'accessing' }
MicPeriodInCaptionResult >> headerString [

	^ 'Last Period in Caption'
]
