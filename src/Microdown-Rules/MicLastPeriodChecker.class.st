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
		'isEndingWithPeriod'
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
											codeShouldEndWithPeriod: isEndingWithPeriod
											) ]
	
]

{ #category : 'visiting' }
MicLastPeriodChecker >> checkMissingPeriodIn: aMicCodeBlock [

	aMicCodeBlock bodyString trimRight last = $. ifFalse: [
			results add: (MicPeriodInCodeResult new
					 micElement: aMicCodeBlock;
					 inFile: aMicCodeBlock fromFile;
					 codeShouldEndWithPeriod: isEndingWithPeriod) ]
]

{ #category : 'visiting' }
MicLastPeriodChecker >> configureFrom: aConfigurationValue [

	aConfigurationValue isNil ifTrue: [ isEndingWithPeriod := false. ^ self ]. 
	aConfigurationValue = 'true'
		ifTrue: [ isEndingWithPeriod := true ]
		ifFalse: [ isEndingWithPeriod := false ]
]

{ #category : 'visiting' }
MicLastPeriodChecker >> initialize [ 
	super initialize. 
	isEndingWithPeriod := true
]

{ #category : 'visiting' }
MicLastPeriodChecker >> isEndingWithPeriod [

	^ isEndingWithPeriod
]

{ #category : 'visiting' }
MicLastPeriodChecker >> shouldEndWithPeriod [

	isEndingWithPeriod := true 
]

{ #category : 'visiting' }
MicLastPeriodChecker >> shouldNotEndWithPeriod [

	isEndingWithPeriod := false
]
