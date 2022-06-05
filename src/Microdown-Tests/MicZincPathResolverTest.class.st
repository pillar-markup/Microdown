"
A MicZincPathResolverTest is a test class for testing the behavior of MicZincPathResolver
"
Class {
	#name : #MicZincPathResolverTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests-Resolution'
}

{ #category : #tests }
MicZincPathResolverTest >> testVisitFileImage [
	| doc imageNode absoluteFile |
	doc := Microdown parse: '![alttext](images/pharo.png)'.
	imageNode := doc children first children first.
	self assert: imageNode reference isRelative.
	self assert:  imageNode reference relativePath equals: 'images/pharo.png'.
	absoluteFile := (MicResourceReference fromUri: 'file:/my/deep/directory/sourceFile.md') 
		filesystem: #Bogus;
		yourself.
	
	MicZincPathResolver resolve: doc withBase: absoluteFile.
	self assert: imageNode reference isRelative not.
	self assert: imageNode reference uriString equals: 'file:///my/deep/directory/images/pharo.png'.
	self assert: imageNode reference filesystem equals: #Bogus
]

{ #category : #tests }
MicZincPathResolverTest >> testVisitHttpImage [
	| doc imageNode |
	doc := Microdown parse: '![alttext](images/pharo.png)'.
	imageNode := doc children first children first.
	self assert:  imageNode reference relativePath equals: 'images/pharo.png'.
	
	MicZincPathResolver
		resolve: doc 
		withBase: 'http://nowhere/my/deep/directory/sourceFile.md'.
	self assert:  imageNode reference uriString equals: 'http://nowhere/my/deep/directory/images/pharo.png'.
]

{ #category : #tests }
MicZincPathResolverTest >> testVisitHttpInput [
	| doc inputNode |
	doc := Microdown parse: '{!inputFile|path=otherFile.md!}'.
	inputNode := doc children first children first.
	self assert:  inputNode reference relativePath equals: 'otherFile.md'.
	
	MicZincPathResolver
		resolve: doc 
		withBase: 'http://nowhere/my/deep/directory/sourceFile.md'.
	self assert:  inputNode reference uriString equals: 'http://nowhere/my/deep/directory/otherFile.md'.
]

{ #category : #tests }
MicZincPathResolverTest >> testVisitHttpInput_WithReference [
	| doc inputNode |
	doc := Microdown parse: '{!inputFile|path=otherFile.md!}'.
	inputNode := doc children first children first.
	self assert:  inputNode reference relativePath equals: 'otherFile.md'.
	
	MicZincPathResolver
		resolve: doc 
		withBase: (MicResourceReference fromUri: 'http://nowhere/my/deep/directory/sourceFile.md').
	self assert:  inputNode reference uriString equals: 'http://nowhere/my/deep/directory/otherFile.md'.
]

{ #category : #tests }
MicZincPathResolverTest >> testVisitHttpLink [
	| doc linkNode |
	doc := Microdown parse: '[follow me](otherFile.md)'.
	linkNode := doc children first children first.
	self assert:  linkNode reference relativePath equals: 'otherFile.md'.
	
	MicZincPathResolver
		resolve: doc 
		withBase: 'http://nowhere/my/deep/directory/sourceFile.md'.
	self assert:  linkNode reference uriString equals: 'http://nowhere/my/deep/directory/otherFile.md'.
]
