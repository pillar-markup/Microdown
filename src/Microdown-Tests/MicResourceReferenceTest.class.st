Class {
	#name : 'MicResourceReferenceTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Tests-Resolution',
	#package : 'Microdown-Tests',
	#tag : 'Resolution'
}

{ #category : 'helper' }
MicResourceReferenceTest >> resourceClass [

	^ MicResourceReference
]

{ #category : 'tests' }
MicResourceReferenceTest >> testHttpRecognized [
	|uri ref|
	uri := 'https://raw.githubusercontent.com/pillar-markup/Microdown/dev/doc/testMicrodown/readme.md'.
	ref := self resourceClass fromUri: uri.
	self assert: ref isNotNil.
	self assert: ref class equals: MicHTTPResourceReference.
]

{ #category : 'tests' }
MicResourceReferenceTest >> testIsDirectory [
	| ref |
	
	ref := 'https://pharo.org' asMicResourceReference.
	self deny: ref isDirectory 
]

{ #category : 'tests' }
MicResourceReferenceTest >> testParseFullUrl [

	| mf |
	mf := self resourceClass fromUri: 'http://server/m.md'.
	self assert: mf uriString equals: 'http://server/m.md'.

]

{ #category : 'tests - file reference conversion' }
MicResourceReferenceTest >> testPurePathInterpretedAsFile [
	| mf |
	mf := self resourceClass fromUri: '/chapter1/figures/m.md'.
	self assert: mf isMicrodownResourceFileReference.
	self assert: mf fullName equals: '/chapter1/figures/m.md'.
	
]

{ #category : 'tests' }
MicResourceReferenceTest >> testPurePathIsRelativeFile [
	
	| mf |
	mf := self resourceClass fromUri: 'chapter1/figures/m.md'.
	self assert: mf isRelative.
	self assert: mf relativePath equals: 'chapter1/figures/m.md'.
	
]

{ #category : 'tests' }
MicResourceReferenceTest >> testRelativeFileRecognized [
	
	| mf |
	mf := self resourceClass fromUri: 'chapter1/figures/m.md'.
	self assert: mf isRelative.
	self assert: mf relativePath equals: 'chapter1/figures/m.md'.
	
]

{ #category : 'tests' }
MicResourceReferenceTest >> testStringExtensionMethod [
	| ref |
	ref := 'http://somewhere.org/path/to/image.png' asMicResourceReference.
	self assert: ref class equals: MicHTTPResourceReference.
	self assert: ref path equals: '/path/to/image.png'
]
