Class {
	#name : 'MicLastPeriodChecker',
	#superclass : 'MicChecker',
	#instVars : [
		'codeShouldEndWithPeriod'
	],
	#category : 'Microdown-Rules-CodeLastPeriod',
	#package : 'Microdown-Rules',
	#tag : 'CodeLastPeriod'
}

{ #category : 'visiting' }
MicLastPeriodChecker >> checkExtraPeriodIn: aMicCodeBlock [ 
	
	(aMicCodeBlock bodyString trimRight last = $.)
		ifTrue: [ results add: (MicPeriodInCodeResult new
											micElement: aMicCodeBlock;
											inFile: aMicCodeBlock fromFile; 
											codeShouldEndWithPeriod: codeShouldEndWithPeriod
											) ]
	
]

{ #category : 'visiting' }
MicLastPeriodChecker >> checkMissingPeriodIn: aMicCodeBlock [

	aMicCodeBlock bodyString trimRight last = $. ifFalse: [
			results add: (MicPeriodInCodeResult new
					 micElement: aMicCodeBlock;
					 inFile: aMicCodeBlock fromFile;
					 codeShouldEndWithPeriod: codeShouldEndWithPeriod) ]
]

{ #category : 'visiting' }
MicLastPeriodChecker >> identifyExtraLastPeriod [

	codeShouldEndWithPeriod := false
]

{ #category : 'visiting' }
MicLastPeriodChecker >> identifyMissingLastPeriod [

	codeShouldEndWithPeriod := true
]

{ #category : 'visiting' }
MicLastPeriodChecker >> initialize [ 
	super initialize. 
	codeShouldEndWithPeriod := true
]
