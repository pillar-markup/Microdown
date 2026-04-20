Class {
	#name : 'MicLastPeriodCheckerTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Tests',
	#package : 'Microdown-Tests'
}

{ #category : 'tests' }
MicLastPeriodCheckerTest >> testInitialize [
	| checker |
	checker := MicLastPeriodChecker new.
	self deny: (checker instVarNamed: 'isEndingWithPeriod').
]
