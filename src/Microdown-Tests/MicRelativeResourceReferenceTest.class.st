"
A MicRelativeResourceReferenceTest is a test class for testing the behavior of MicRelativeResourceReference
"
Class {
	#name : #MicRelativeResourceReferenceTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests-Core'
}

{ #category : #tests }
MicRelativeResourceReferenceTest >> testIsRelative [
	| mic ref |
	mic := Microdown parse: '[look here](../images/rudolf.png)'.
	ref := mic children first children first.
	self assert: ref reference isRelative
]

{ #category : #tests }
MicRelativeResourceReferenceTest >> testPrintOn [
	| mic ref print |
	mic := Microdown parse: '[look here](../images/rudolf.png)'.
	ref := mic children first children first reference.
	print := String new writeStreamDo: [ :stream |ref  printOn: stream. stream contents ].
	self assert: print equals: 'a MicRelativeResourceReference(../images/rudolf.png)'
]

{ #category : #tests }
MicRelativeResourceReferenceTest >> testRelativePath [
	| mic ref print |
	mic := Microdown parse: '[look here](../images/rudolf.png)'.
	ref := mic children first children first reference.
	self assert: ref relativePath equals: '../images/rudolf.png'
]
