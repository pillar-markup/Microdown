"
A MicZincPathResolverTest is a test class for testing the behavior of MicZincPathResolver
"
Class {
	#name : #MicZincPathResolverTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests-Resources'
}

{ #category : #tests }
MicZincPathResolverTest >> testVisitFileImage [
	| doc imageNode absoluteFile |
	doc := Microdown parse: '![alttext](images/pharo.png)'.
	imageNode := doc children first children first.
	self assert:  imageNode reference originalString equals: 'images/pharo.png'.
	absoluteFile := (MicResourceReference fromUri: 'file:/my/deep/directory/sourceFile.md') 
		fileSystem: #Bogus;
		yourself.
	
	MicZincPathResolver new 
		absoluteReference: absoluteFile;
		resolveDocument: doc.
	self assert: imageNode reference originalString equals: 'file:///my/deep/directory/images/pharo.png'.
	self assert: imageNode reference fileSystem equals: #Bogus
]

{ #category : #tests }
MicZincPathResolverTest >> testVisitHttpImage [
	| doc imageNode |
	doc := Microdown parse: '![alttext](images/pharo.png)'.
	imageNode := doc children first children first.
	self assert:  imageNode reference originalString equals: 'images/pharo.png'.
	
	MicZincPathResolver new 
		absoluteReference: 'http://nowhere/my/deep/directory/sourceFile.md';
		resolveDocument: doc.
	self assert:  imageNode reference originalString equals: 'http://nowhere/my/deep/directory/images/pharo.png'.
]

{ #category : #tests }
MicZincPathResolverTest >> testVisitHttpInput [
	| doc inputNode |
	doc := Microdown parse: '{!inputFile|path=otherFile.md!}'.
	inputNode := doc children first children first.
	self assert:  inputNode reference originalString equals: 'otherFile.md'.
	
	MicZincPathResolver new 
		absoluteReference: 'http://nowhere/my/deep/directory/sourceFile.md';
		resolveDocument: doc.
	self assert:  inputNode reference originalString equals: 'http://nowhere/my/deep/directory/otherFile.md'.
]

{ #category : #tests }
MicZincPathResolverTest >> testVisitHttpInput_WithReference [
	| doc inputNode |
	doc := Microdown parse: '{!inputFile|path=otherFile.md!}'.
	inputNode := doc children first children first.
	self assert:  inputNode reference originalString equals: 'otherFile.md'.
	
	MicZincPathResolver new 
		absoluteReference: (MicResourceReference fromUri: 'http://nowhere/my/deep/directory/sourceFile.md');
		resolveDocument: doc.
	self assert:  inputNode reference originalString equals: 'http://nowhere/my/deep/directory/otherFile.md'.
]

{ #category : #tests }
MicZincPathResolverTest >> testVisitHttpLink [
	| doc linkNode |
	doc := Microdown parse: '[follow me](otherFile.md)'.
	linkNode := doc children first children first.
	self assert:  linkNode reference originalString equals: 'otherFile.md'.
	
	MicZincPathResolver new 
		absoluteReference: 'http://nowhere/my/deep/directory/sourceFile.md';
		resolveDocument: doc.
	self assert:  linkNode reference originalString equals: 'http://nowhere/my/deep/directory/otherFile.md'.
]
