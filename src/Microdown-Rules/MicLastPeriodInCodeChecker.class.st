Class {
	#name : 'MicLastPeriodInCodeChecker',
	#superclass : 'MicChecker',
	#instVars : [
		'codeShouldEndWithPeriod'
	],
	#category : 'Microdown-Rules-CodeLastPeriod',
	#package : 'Microdown-Rules',
	#tag : 'CodeLastPeriod'
}

{ #category : 'visiting' }
MicLastPeriodInCodeChecker >> checkExtraPeriodIn: aMicCodeBlock [ 
	
	(aMicCodeBlock body trimRight last = $.)
		ifTrue: [ results add: (MicPeriodInCodeResult new
											micElement: aMicCodeBlock;
											inFile: aMicCodeBlock fromFile; 
											codeShouldEndWithPeriod: codeShouldEndWithPeriod
											) ]
	
]

{ #category : 'visiting' }
MicLastPeriodInCodeChecker >> checkMissingPeriodIn: aMicCodeBlock [

	aMicCodeBlock body trimRight last = $. ifFalse: [
			results add: (MicPeriodInCodeResult new
					 micElement: aMicCodeBlock;
					 inFile: aMicCodeBlock fromFile;
					 codeShouldEndWithPeriod: codeShouldEndWithPeriod) ]
]

{ #category : 'visiting' }
MicLastPeriodInCodeChecker >> identifyExtraLastPeriod [

	codeShouldEndWithPeriod := false
]

{ #category : 'visiting' }
MicLastPeriodInCodeChecker >> identifyMissingLastPeriod [

	codeShouldEndWithPeriod := true
]

{ #category : 'visiting' }
MicLastPeriodInCodeChecker >> visitCode: aCodeBlockElement [

	codeShouldEndWithPeriod 
		ifTrue: [ self checkMissingPeriodIn: aCodeBlockElement ]
		ifFalse: [ self checkExtraPeriodIn: aCodeBlockElement ]
]
