"
A MicCSSProviderTest is a test class for testing the behavior of MicCSSProvider
"
Class {
	#name : #MicCSSProviderTest,
	#superclass : #TestCase,
	#category : #'Microdown-HTMLExporter-Tests'
}

{ #category : #tests }
MicCSSProviderTest >> testDefaultFrameworks [

	self assert: (MicCSSProvider frameworks isKindOf: Collection).
	self assert: (MicCSSProvider frameworks allSatisfy: [ : frw | frw isKindOf: MicCSSFramework ])
]

{ #category : #tests }
MicCSSProviderTest >> testForCSSFrameworkNamed [
	
	| tufte |
	self should: [ MicCSSProvider forCSSFrameworkNamed: 'XXXXXXXX' ] raise: NotFound.
	tufte := MicCSSProvider forCSSFrameworkNamed: 'Tufte'.

	self assert: (tufte isKindOf: String)	.
	self deny: tufte isEmpty.
	self assert: (tufte beginsWith: 'http').
	self assert: (tufte endsWith: 'css')
]
