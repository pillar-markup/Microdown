Class {
	#name : 'MicConventionCheckerTest',
	#superclass : 'TestCase',
	#category : 'Microdown-BookTester-Tests',
	#package : 'Microdown-BookTester-Tests'
}

{ #category : 'parsing' }
MicConventionCheckerTest >> parseAndTest: docText [

	| doc bTester |
	doc := Microdown parse: docText.
	bTester := MicConventionChecker new.
	bTester start: doc.
	^ bTester
]
