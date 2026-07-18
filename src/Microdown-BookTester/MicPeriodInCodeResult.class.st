Class {
	#name : 'MicPeriodInCodeResult',
	#superclass : 'MicLastPeriodResult',
	#category : 'Microdown-BookTester-Checker-LastPeriod',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-LastPeriod'
}

{ #category : 'explanation' }
MicPeriodInCodeResult >> explanation [

	^ 'Text: "' , micElement body , '" in file' , self inFile fullName , ' contains a mistake: It should'
	  , (codeShouldEndWithPeriod
			   ifFalse: [ ' not ' ]
			   ifTrue: [ ' ' ]) , 'be terminated with a period (.).'
]

{ #category : 'explanation' }
MicPeriodInCodeResult >> headerString [

	^ 'Last Period in Code'
]
