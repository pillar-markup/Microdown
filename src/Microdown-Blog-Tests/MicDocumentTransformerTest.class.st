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

{ #category : 'tests' }
MicDocumentTransformerTest >> testMakeALinkTo [

	| array link |
	array := MicDocumentTransformer makeALink: 'Pharo is cool' to: 'Test'.
	link := array at: 1.
	self
		assert: array size equals: 1;
		assert: (link isKindOf: MicLinkBlock) equals: true;
		assert: link plainText equals: '[Pharo is cool](Test)'
]

{ #category : 'tests' }
MicDocumentTransformerTest >> testMakeALinkToWithEmptyArguments [

	| array link |
	array := MicDocumentTransformer makeALink: '' to: ''.
	link := array at: 1.
	self
		assert: array size equals: 1;
		assert: (link isKindOf: MicLinkBlock) equals: true;
		assert: link plainText equals: '[Undefined](Undefined)'
]
