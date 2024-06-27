Class {
	#name : 'MicAbstractBlogCreatorTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Blog-Tests',
	#package : 'Microdown-Blog-Tests'
}

{ #category : 'tests' }
MicAbstractBlogCreatorTest class >> testMakeALinkTo [

	| link |
	link := MicInlineParser parse: '[Pharo is cool](Test)'.
	self
		assert:
		(MicAbstractBlogCreator new makeALink: 'Pharo is cool' to: 'Test')
		equals: link
]

{ #category : 'tests' }
MicAbstractBlogCreatorTest >> testMakeALinkTo [

	|  link |
	link := MicAbstractBlogCreator new makeALink: 'Pharo is cool' to: 'Test'.
	
	self
		assert: (link isKindOf: MicLinkBlock);
		assert: link plainText equals: '[Pharo is cool](Test)'
]

{ #category : 'tests' }
MicAbstractBlogCreatorTest >> testMakeALinkToWithEmptyArguments [

	| link |
	link := MicAbstractBlogCreator new makeALink: '' to: ''.

	self
		assert: (link isKindOf: MicLinkBlock);
		assert: link plainText equals: '[Undefined](Undefined)'
]

{ #category : 'tests' }
MicAbstractBlogCreatorTest >> testMakeALinkToWithNilArguments [

	| link |
	link := MicAbstractBlogCreator new makeALink: nil to: nil.

	self
		assert: (link isKindOf: MicLinkBlock);
		assert: link plainText equals: '[Undefined](Undefined)'
]
