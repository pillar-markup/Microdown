"
A MicGitHubRessourceReferenceTest is a test class for testing the behavior of MicGitHubRessourceReference
"
Class {
	#name : #MicGitHubRessourceReferenceTest,
	#superclass : #TestCase,
	#instVars : [
		'savedCache'
	],
	#category : #'Microdown-DocumentBrowser-Tests-ResourceModel'
}

{ #category : #tests }
MicGitHubRessourceReferenceTest >> setUp [ 
	super setUp.
	savedCache := MicGitHubRessourceReference cache.
	
]

{ #category : #tests }
MicGitHubRessourceReferenceTest >> tearDown [ 
	MicGitHubRessourceReference cache: savedCache.
	super tearDown
	
]

{ #category : #tests }
MicGitHubRessourceReferenceTest >> testCache [
	MicGitHubRessourceReference reset.
	self assert: MicGitHubRessourceReference cache isEmpty.
]

{ #category : #tests }
MicGitHubRessourceReferenceTest >> testCache_storesNewInstances [
	|uri ref otherRef|
	MicGitHubRessourceReference reset.
	uri := 'github://pillar-markup/Microdown/doc/testMicrodown/readme.md'.
	ref := MicResourceReference fromUri: uri.
	self assert: (MicGitHubRessourceReference cache at: 'pillar-markup/Microdown') notNil.
	otherRef := MicResourceReference fromUri: 'github://pillar-markup/Microdown'.
	self assert: otherRef equals: ref
]

{ #category : #tests }
MicGitHubRessourceReferenceTest >> testCache_takesBranchIntoConsideration [
	|ref|
	MicGitHubRessourceReference reset.
	ref := MicResourceReference fromUri: 'github://pillar-markup/Microdown:aaa'.
	self deny: (MicResourceReference fromUri: 'github://pillar-markup/Microdown') equals: ref.
	self deny: (MicResourceReference fromUri: 'github://pillar-markup/Microdown:bbb') equals: ref
]

{ #category : #tests }
MicGitHubRessourceReferenceTest >> testContents [
	|uri ref contents|
	uri := 'github://pillar-markup/Microdown/doc/testMicrodown/readme.md'.
	ref := MicResourceReference fromUri: uri.
	contents := ref contents.
	self 
		assert: (contents beginsWith: '# Test documents' )
]

{ #category : #tests }
MicGitHubRessourceReferenceTest >> testGithubTreesApiRequest [
	|uri ref|
	uri := 'github://JohnDoe/Calculator:devBranch/path/to/docs'.
	ref := MicResourceReference fromUri: uri.
	self 
		assert: ref githubTreesApiRequest  
		equals: 'https://api.github.com/repos/johndoe/Calculator/git/trees/devBranch'.
]

{ #category : #tests }
MicGitHubRessourceReferenceTest >> testLoadChildren [
	|uri ref children|
	uri := 'github://pillar-markup/Microdown/doc/testMicrodown'.
	ref := MicResourceReference fromUri: uri.
	children := ref loadChildren.
	self 
		assert: children size 
		equals: 4.
	self assert: (children allSatisfy: [:child | child isKindOf: MicAbsoluteResourceReference ])
]

{ #category : #tests }
MicGitHubRessourceReferenceTest >> testUri [
	|uri ref|
	uri := 'github://JohnDoe/Calculator:devBranch/path/to/docs'.
	ref := MicResourceReference fromUri: uri.
	self assert: ref class equals: MicGitHubRessourceReference.
	self assert: ref user equals: 'johndoe'.
	self assert: ref project equals: 'Calculator'.
	self assert: ref branch equals: 'devBranch'.
	self assert: ref docFolder equals: { 'path'. 'to'. 'docs' }
]

{ #category : #tests }
MicGitHubRessourceReferenceTest >> testUri_defaultBranch [
	|uri ref|
	uri := 'github://JohnDoe/Calculator'.
	ref := MicResourceReference fromUri: uri.
	
	self assert: ref branch equals: 'main'
]

{ #category : #tests }
MicGitHubRessourceReferenceTest >> testUri_defaultBranch_Pharo [
	|uri ref|
	uri := 'github://pharo-project/pharo'.
	ref := MicResourceReference fromUri: uri.
	
	self assert: (ref branch beginsWith: 'Pharo')
]

{ #category : #tests }
MicGitHubRessourceReferenceTest >> testUri_defaultBranch_Pharo_withDoc [
	|uri ref|
	uri := 'github://pharo-project/pharo:dummyBranch/path/to/docs'.
	ref := MicResourceReference fromUri: uri.
	self assert: ref docFolder equals: { 'path'. 'to'. 'docs' }
]

{ #category : #tests }
MicGitHubRessourceReferenceTest >> testUri_defaultPath [
	|uri ref|
	uri := 'github://JohnDoe/Calculator:devBranch'.
	ref := MicResourceReference fromUri: uri.
	
	self assert: ref docFolder equals: #()
]
