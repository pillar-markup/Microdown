Class {
	#name : #MicResourceReferenceTest2,
	#superclass : #TestCase,
	#instVars : [
		'subject'
	],
	#category : #'Microdown-Tests-Resources'
}

{ #category : #running }
MicResourceReferenceTest2 >> setUp [
	super setUp.
	
	subject := MicResourceReference
]

{ #category : #tests }
MicResourceReferenceTest2 >> testHttpRecognized [
	|uri ref|
	uri := 'https://raw.githubusercontent.com/pillar-markup/Microdown/dev/doc/testMicrodown/readme.md'.
	ref := subject fromUri: uri.
	self assert: ref isNotNil.
	self assert: ref class equals: MicHTTPResource.
]

{ #category : #tests }
MicResourceReferenceTest2 >> testZinkResolve [
	| abs rel combo |
	abs := ZnUrl fromString: 'https://some/where/xx.md'.
	rel := '../body.png'.
	combo := abs withRelativeReference: rel.
	
	self assert: combo printString equals: 'https://some/body.png'.
]
