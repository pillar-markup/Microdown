"
A MicCSSProviderTest is a test class for testing the behavior of MicCSSProvider
"
Class {
	#name : #MicCSSProviderTest,
	#superclass : #TestCase,
	#category : #'Microdown-HTMLExporter-Tests'
}

{ #category : #test }
MicCSSProviderTest >> testLibraryNames [

	self assert: (MicCSSProvider libraryNames isKindOf: Collection).
	self assert: (MicCSSProvider libraryNames allSatisfy: #isString)
]

{ #category : #test }
MicCSSProviderTest >> testNamed [
	
	| tufte |
	self should: [ MicCSSProvider named: 'XXXXXXXX' ] raise: NotFound.
	tufte := MicCSSProvider named: 'Tufte'.

	self assert: (tufte isKindOf: String)	.
	self deny: tufte isEmpty.
	self assert: (tufte beginsWith: 'http').
	self assert: (tufte endsWith: 'css')
]
