Class {
	#name : #MicResourceReferenceTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests-Resources'
}

{ #category : #helper }
MicResourceReferenceTest >> fileReferenceClass [

	^ MicResourceReference
]

{ #category : #tests }
MicResourceReferenceTest >> testIsAbsoluteFile [
	
	| mf |
	mf := self fileReferenceClass fromString: '/chapter1/figures/m.mic'.
	self assert: mf isFile.
	self assert: mf isAbsolute.
	self deny: mf isRelative
	
]

{ #category : #'tests unsupported features' }
MicResourceReferenceTest >> testIsFile [

	| mf |
	"we should not support this form of file declaration because file:///chapter1/figures/m.mic is relative while file://chapter1/figures/m.mic absolute from 
	an url point of view"
	mf := self fileReferenceClass fromString: 'file:///chapter1/figures/m.mic'.
	self assert: mf isFile.
	"we do not want to have file:/// to express relative paths."
	
]

{ #category : #tests }
MicResourceReferenceTest >> testIsRelativeFile [
	
	| mf |
	mf := self fileReferenceClass fromString: 'chapter1/figures/m.mic'.
	self assert: mf isFile.
	self assert: mf isRelative.
	self deny: mf isAbsolute
	
]

{ #category : #tests }
MicResourceReferenceTest >> testParseFullUrl [

	| mf |
	mf := self fileReferenceClass fromString: 'http://server/m.mic'.
	self assert: mf url asString equals: 'http://server/m.mic'
]
