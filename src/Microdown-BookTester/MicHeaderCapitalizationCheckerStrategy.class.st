Class {
	#name : 'MicHeaderCapitalizationCheckerStrategy',
	#superclass : 'Object',
	#instVars : [
		'checker'
	],
	#category : 'Microdown-BookTester-Checker-Capitalization',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-Capitalization'
}

{ #category : 'checking' }
MicHeaderCapitalizationCheckerStrategy >> checkColonCapitalizationIn: words of: aMicHeader [

	| size current next |
	size := words size.
	1 to: size - 1 do: [ :i |
			current := words at: i.
			(current endsWith: ':') ifTrue: [
					next := words at: i + 1.
					next notEmpty ifTrue: [
						next first isLowercase
								ifTrue: [
									checker addResult:
										(MicElementAfterColonIsNotCapitalizedResult new
											 micElement: aMicHeader;
											 detail: next ;
											 inFile: aMicHeader fromFile) ] ] ] ]
]

{ #category : 'accessing' }
MicHeaderCapitalizationCheckerStrategy >> checker [

	^ checker
]

{ #category : 'accessing' }
MicHeaderCapitalizationCheckerStrategy >> checker: anObject [

	checker := anObject
]
