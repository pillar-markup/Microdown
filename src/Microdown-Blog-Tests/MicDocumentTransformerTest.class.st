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
	self
		assert:
		(MicAbstractBlogCreator new makeALink: 'Pharo is cool' to: 'Test')
		equals: link
]

{ #category : 'tests' }
MicDocumentTransformerTest >> testMakeALinkTo [

	|  link |
	link := MicAbstractBlogCreator new makeALink: 'Pharo is cool' to: 'Test'.
	
	self
		assert: (link isKindOf: MicLinkBlock) equals: true;
		assert: link plainText equals: '[Pharo is cool](Test)'
]

{ #category : 'tests' }
MicDocumentTransformerTest >> testMakeALinkToWithEmptyArguments [

	| link |
	link := MicAbstractBlogCreator new makeALink: '' to: ''.
	
	self
		assert: (link isKindOf: MicLinkBlock) equals: true;
		assert: link plainText equals: '[Undefined](Undefined)'
]
