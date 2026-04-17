Class {
	#name : 'MicLastPeriodInHeaderCheckerTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Tests',
	#package : 'Microdown-Tests'
}

{ #category : 'tests' }
MicLastPeriodInHeaderCheckerTest >> testDocumentChecking [
	| checker document4 document5 |
	checker := MicLastPeriodInHeaderChecker new.
	checker configureWith: { 'headerLevelThreshold' -> 5 } asDictionary.
	
	document4 := Microdown parse: '#### Titre niveau quatre'.
	checker visit: document4.
	self assert: checker results isEmpty.
	
	document5 := Microdown parse: '##### Titre niveau cinq'.
	checker visit: document5.
	self deny: checker results isEmpty.
]

{ #category : 'tests' }
MicLastPeriodInHeaderCheckerTest >> testRequiresPeriod [
	| checker header4 header5 |
	checker := MicLastPeriodInHeaderChecker new.
	checker configureWith: { 'headerLevelThreshold' -> 5 } asDictionary.
	
	header4 := MicHeaderBlock new level: 4.
	header5 := MicHeaderBlock new level: 5.
	
	self deny: (checker requiresPeriodFor: header4).
	self assert: (checker requiresPeriodFor: header5).
]
