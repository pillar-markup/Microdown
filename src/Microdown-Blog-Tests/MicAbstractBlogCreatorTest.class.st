Class {
	#name : 'MicAbstractBlogCreatorTest',
	#superclass : 'TestCase',
	#instVars : [
		'abstractBlog'
	],
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

{ #category : 'running' }
MicAbstractBlogCreatorTest >> setUp [
	super setUp.

	"Put here a common initialization logic for tests"
	
   abstractBlog := MicAbstractBlogCreator new.
	abstractBlog root: MicFileTestResources new genericEmptyRootPath
]

{ #category : 'tests' }
MicAbstractBlogCreatorTest >> testMakeALinkTo [

	| link |
	link := abstractBlog makeALink: 'Pharo is cool' to: 'Test' asFileReference.

	self
		assert: (link isKindOf: MicLinkBlock);
		assert: link plainText equals: '[Pharo is cool](Test)'
]

{ #category : 'tests' }
MicAbstractBlogCreatorTest >> testMakeALinkToWithEmptyArguments [

	| link |
	link := abstractBlog makeALink: '' to: ''.

	self
		assert: (link isKindOf: MicLinkBlock);
		assert: link plainText equals: '[Undefined](Undefined)'
]

{ #category : 'tests' }
MicAbstractBlogCreatorTest >> testMakeALinkToWithNilArguments [

	| link |
	link := abstractBlog makeALink: nil to: nil.

	self
		assert: (link isKindOf: MicLinkBlock);
		assert: link plainText equals: '[Undefined](Undefined)'
]

{ #category : 'tests' }
MicAbstractBlogCreatorTest >> testMakeALinkToWithRootPath [

	| link ressources |
	ressources := MicFileTestResources new.
	abstractBlog root: ressources genericNonEmptyRootPath.
	link := abstractBlog makeALink: 'Pharo is cool' to: 'Test' asFileReference.

	self
		assert: (link isKindOf: MicLinkBlock);
		assert: link plainText equals: '[Pharo is cool](', ressources genericNonEmptyRootPath ,'Test)'
]

{ #category : 'tests' }
MicAbstractBlogCreatorTest >> testVerifyDateMetadata [

	| root metadata |
	root := MicRootBlock new.
	metadata := MicMetaDataBlock new.
	metadata body: Dictionary new.
	metadata atKey: #date put: '2021/05/21'.
	root addChild: metadata.

	root := abstractBlog verifyDateMetadata: root.

	self assert: (root isKindOf: MicRootBlock).
	metadata := root children first.
	self assert: (metadata atKey: #date) equals: '2021/05/21'
]

{ #category : 'tests' }
MicAbstractBlogCreatorTest >> testVerifyDateMetadataWithInvalidDate [

	| root metadata |
	root := MicRootBlock new.
	metadata := MicMetaDataBlock new.
	metadata body: Dictionary new.
	metadata atKey: #date put: '20215612345'.
	root addChild: metadata.

	root := abstractBlog verifyDateMetadata: root.

	self assert: (root isKindOf: MicRootBlock).
	metadata := root children first.
	self assert: (metadata atKey: #date) equals: abstractBlog replacementDate 
]

{ #category : 'tests' }
MicAbstractBlogCreatorTest >> testVerifyDateMetadataWithoutDate [

	| root metadata |
	root := MicRootBlock new.
	metadata := MicMetaDataBlock new.
	metadata body: Dictionary new.
	root addChild: metadata.

	root := abstractBlog verifyDateMetadata: root.

	self assert: (root isKindOf: MicRootBlock).
	metadata := root children first.
	self assert: (metadata atKey: #date) equals: abstractBlog replacementDate 
]

{ #category : 'tests' }
MicAbstractBlogCreatorTest >> testVerifyDateMetadataWithoutMetadata [

	| root metadata |
	root := MicRootBlock new.

	root := MicAbstractBlogCreator new verifyDateMetadata: root.

	self assert: (root isKindOf: MicRootBlock).
	metadata := root children first.
	self assert: (metadata atKey: #date) equals: abstractBlog replacementDate 
]
