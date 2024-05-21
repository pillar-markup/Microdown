Class {
	#name : 'MicDocumentTransformerTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Blog-Tests',
	#package : 'Microdown-Blog-Tests'
}

{ #category : 'tests' }
MicDocumentTransformerTest class >> testMakeALinkTo [

	| link |
	
	link := MicInlineParser parse: '[Pharo is cool](Test)'.
	self assert: (MicDocumentTransformer makeALink: 'Pharo is cool' to: 'Test' ) equals: link.
]
