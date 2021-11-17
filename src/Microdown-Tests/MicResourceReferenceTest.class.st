Class {
	#name : #MicResourceReferenceTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests-Resources'
}

{ #category : #helper }
MicResourceReferenceTest >> resourceClass [

	^ MicResourceReference
]

{ #category : #tests }
MicResourceReferenceTest >> testHttpRecognized [
	|uri ref|
	uri := 'https://raw.githubusercontent.com/pillar-markup/Microdown/dev/doc/testMicrodown/readme.md'.
	ref := self resourceClass fromUri: uri.
	self assert: ref isNotNil.
	self assert: ref class equals: MicHTTPResource.
]

{ #category : #tests }
MicResourceReferenceTest >> testIsFileOfNoUrlFile [

	| mf |
	mf := self resourceClass fromUri: 'server.org/figures/p.png'.
	self assert: mf isFile.
	mf := self resourceClass fromUri: '/server.org/figures/p.png'.
	self assert: mf isFile.
]

{ #category : #tests }
MicResourceReferenceTest >> testIsFileOfNoUrlFolder [

	| mf |
	mf := self resourceClass fromUri: 'server.org/figures/'.
	self deny: mf isFile.
	mf := self resourceClass fromUri: '/server.org/figures/'.
	self deny: mf isFile.
]

{ #category : #tests }
MicResourceReferenceTest >> testIsFileOfResolvedByNoUrlFile [

	| mf |
	mf := self resourceClass fromUri: 'server.org/figures/p.png'.
	mf := mf resolveWith:  self resourceClass workingDirectoryReference. 
	self assert: mf isFile.
	
	mf := self resourceClass fromUri: '/server.org/figures/p.png'.
	self assert: mf isFile.
]

{ #category : #tests }
MicResourceReferenceTest >> testIsFileOfResolvedByNoUrlFolder [

	| mf |
	mf := self resourceClass fromUri: 'server.org/figures/'.
	mf := mf resolveWith:  self resourceClass workingDirectoryReference.
	self deny: mf isFile.
	mf := self resourceClass fromUri: '/server.org/figures/'.
	self deny: mf isFile.
]

{ #category : #tests }
MicResourceReferenceTest >> testIsFileOfResolvedUrlFile [

	| mf |
	mf := self resourceClass fromUri: 'http://server/figures/m.png'.
	self assert: mf isFile.
	
]

{ #category : #tests }
MicResourceReferenceTest >> testIsFileOfUrlFile [

	| mf |
	mf := self resourceClass fromUri: 'http://server/figures/m.png'.
	self assert: mf isFile.
	
]

{ #category : #tests }
MicResourceReferenceTest >> testIsFileOfUrlFolder [

	| mf |
	mf := self resourceClass fromUri: 'http://server.org/figures/'.
	self deny: mf isFile.
	
]

{ #category : #tests }
MicResourceReferenceTest >> testIsFileOfUrlResolvedFolder [

	| mf |
	mf := self resourceClass fromUri: 'http://server.org/figures/'.
	self deny: mf isFile.
	
]

{ #category : #tests }
MicResourceReferenceTest >> testParseFullUrl [

	| mf |
	mf := self resourceClass fromUri: 'http://server/m.mic'.
	self assert: mf uri asString equals: 'http://server/m.mic'.

]

{ #category : #tests }
MicResourceReferenceTest >> testResolvedIsAbsoluteFile [
	
	| mf base|
	mf := self resourceClass fromUri: 'chapter1/figures/m.mic'.
	base := self resourceClass fromUri: 'file:///stuff'.
	mf := mf resolveWith: base.
	self assert: (mf isKindOf: MicFileResource).
	self assert: mf uri asString equals:  'file:///chapter1/figures/m.mic'. 
	
]

{ #category : #tests }
MicResourceReferenceTest >> testResolvedIsImageFile [
	
	| mf |
	mf := self resourceClass fromUri: 'http://foo.edu/chapter1/figures/m.png'.
	self assert: mf isImage.
	
]

{ #category : #tests }
MicResourceReferenceTest >> testUnResolvedIsRelativeFile [
	
	| mf |
	mf := self resourceClass fromUri: 'chapter1/figures/m.mic'.
	self assert: (mf isKindOf: MicRelativeResource).
	self assert: mf relativePath  equals: 'chapter1/figures/m.mic'.
	
]

{ #category : #'tests - file reference conversion' }
MicResourceReferenceTest >> testUnresolvedFileReferenceFromFile [
	"Resolution does not change the file reference conversion."
	
	| mf |
	mf := self resourceClass fromUri: '/chapter1/figures/m.mic'.
	self assert: mf path equals: '/chapter1/figures/m.mic'.
	
]

{ #category : #tests }
MicResourceReferenceTest >> testUnresolvedIsAbsoluteFile [
	
	| mf |
	mf := self resourceClass fromUri: '/chapter1/figures/m.mic'.
	self assert: (mf isKindOf: MicFileResource).
	self assert: mf path  equals: '/chapter1/figures/m.mic'.

	
]

{ #category : #tests }
MicResourceReferenceTest >> testUnresolvedIsImageFile [
	
	| mf |
	mf := self resourceClass fromUri: '/chapter1/figures/m.png'.
	self assert: mf isImage
	
]
