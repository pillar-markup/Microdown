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
	#category : 'Microdown-BookTester-Checker-LastPeriod',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-LastPeriod'
}

{ #category : 'checking' }
MicLastPeriodChecker >> checkExtraPeriodIn: aMicCodeBlock [ 
	
	(aMicCodeBlock bodyString trimRight last = $.)
		ifTrue: [ results add: (MicPeriodInCodeResult new
											micElement: aMicCodeBlock;
											inFile: aMicCodeBlock fromFile; 
											codeShouldEndWithPeriod: isEndingWithPeriod
											) ]
	
]

{ #category : 'checking' }
MicLastPeriodChecker >> checkMissingPeriodIn: aMicCodeBlock [

	aMicCodeBlock bodyString trimRight last = $. ifFalse: [
			results add: (MicPeriodInCodeResult new
					 micElement: aMicCodeBlock;
					 inFile: aMicCodeBlock fromFile;
					 codeShouldEndWithPeriod: isEndingWithPeriod) ]
]

{ #category : 'configuration' }
MicLastPeriodChecker >> configureFrom: aConfigurationValue [

	aConfigurationValue ifNil: [
			isEndingWithPeriod := false.
			^ self ]. 
		
	"We use this explicit boolean comparison to filter other possible values expressed with string or others."
	isEndingWithPeriod := aConfigurationValue = true
		                      ifTrue: [ true ]
		                      ifFalse: [ false ]
]

{ #category : 'initialization' }
MicLastPeriodChecker >> initialize [ 
	super initialize. 
	isEndingWithPeriod := false
]

{ #category : 'testing' }
MicLastPeriodChecker >> isEndingWithPeriod [
	^ isEndingWithPeriod
]

{ #category : 'configuration' }
MicLastPeriodChecker >> shouldEndWithPeriod [

	isEndingWithPeriod := true 
]

{ #category : 'configuration' }
MicLastPeriodChecker >> shouldNotEndWithPeriod [

	isEndingWithPeriod := false
]
