"
I check that code blocks end with a period or not, depending on the configuration.

I can be configured in two modes:
- identifyMissingPeriod (true): flags code blocks that do NOT end with a period.
- identifyExtraPeriod (false): flags code blocks that DO end with a period.

In pillar.conf add:
	""checkerConfigurations"" : [
		""CodeLastPeriod"" : ""true""
		]
"
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

{ #category : 'public - name' }
MicLastPeriodChecker class >> checkerName [ 
	^ 'CodeLastPeriod'
]

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

{ #category : 'accessing' }
MicLastPeriodChecker >> codeShouldEndWithPeriod [

	^ codeShouldEndWithPeriod
]

{ #category : 'visiting' }
MicLastPeriodChecker >> configureFrom: aConfiguration [
	aConfiguration isNil ifTrue: [ ^ self ]. 
	aConfiguration = 'true'
		ifTrue: [ codeShouldEndWithPeriod := true ]
		ifFalse: [ codeShouldEndWithPeriod := false ]
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
