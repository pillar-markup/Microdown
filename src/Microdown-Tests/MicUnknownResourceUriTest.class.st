"
A MicUnknownResourceUriTest is a test class for testing the behavior of MicUnknownResourceUri
"
Class {
	#name : 'MicUnknownResourceUriTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Tests-Resolution',
	#package : 'Microdown-Tests',
	#tag : 'Resolution'
}

{ #category : 'tests' }
MicUnknownResourceUriTest >> testBinaryStream [
	| ref errorUri |
	errorUri := 'sqaf://foo/bar'.
	ref := MicResourceReference fromUri: errorUri.
	"Just test that this does not fail"
	self assert: ref loadImage class equals: Form
]

{ #category : 'tests' }
MicUnknownResourceUriTest >> testContents [
	| ref errorUri |
	errorUri := 'sqaf://foo/bar'.
	ref := MicResourceReference fromUri: errorUri.
	self assert: (ref contents includesSubstring:  errorUri)
]

{ #category : 'tests' }
MicUnknownResourceUriTest >> testIsCatchAll [
	| ref |
	ref := MicResourceReference fromUri: 'sqaf://foo/bar'.
	self assert: ref class equals: MicUnknownResourceUri 
]
