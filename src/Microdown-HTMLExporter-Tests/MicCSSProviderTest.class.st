"
A MicCSSProviderTest is a test class for testing the behavior of MicCSSProvider
"
Class {
	#name : #MicCSSProviderTest,
	#superclass : #TestCase,
	#instVars : [
		'cssProvider'
	],
	#category : #'Microdown-HTMLExporter-Tests'
}

{ #category : #running }
MicCSSProviderTest >> setUp [

	super setUp.
	cssProvider := MicCSSProvider new.
]

{ #category : #tests }
MicCSSProviderTest >> testDefaultFramework [

	self assert: (cssProvider class defaultFramework isKindOf: String).
	self deny: cssProvider class defaultFramework isEmpty.
]

{ #category : #tests }
MicCSSProviderTest >> testDefaultFrameworks [

	self assert: (cssProvider frameworks isKindOf: Collection).
	self assert: (cssProvider frameworks allSatisfy: [ : frw | frw isKindOf: MicCSSFramework ])
]

{ #category : #tests }
MicCSSProviderTest >> testForCSSNamed [
	
	| tufte |
	self should: [ MicCSSProvider forCSSNamed: 'XXXXXXXX' ] raise: NotFound.
	tufte := MicCSSProvider forCSSNamed: 'Tufte'.

	self assert: (tufte isKindOf: MicCSSFramework)	.
	self assert: tufte name equals: 'Tufte'.

]
