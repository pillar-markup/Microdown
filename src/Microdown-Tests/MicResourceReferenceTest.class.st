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
	self assert: ref class equals: MicHTTPResourceReference.
]

{ #category : #tests }
MicResourceReferenceTest >> testParseFullUrl [

	| mf |
	mf := self resourceClass fromUri: 'http://server/m.mic'.
	self assert: mf uri asString equals: 'http://server/m.mic'.

]

{ #category : #tests }
MicResourceReferenceTest >> testUnResolvedIsRelativeFile [
	
	| mf |
	mf := self resourceClass fromUri: 'chapter1/figures/m.mic'.
	self assert: (mf isKindOf: MicRelativeResourceReference).
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
	self assert: (mf isKindOf: MicFileResourceReference).
	self assert: mf path  equals: '/chapter1/figures/m.mic'.

	
]
