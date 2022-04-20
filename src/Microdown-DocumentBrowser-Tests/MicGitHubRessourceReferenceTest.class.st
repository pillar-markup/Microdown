"
A MicGitHubRessourceReferenceTest is a test class for testing the behavior of MicGitHubRessourceReference
"
Class {
	#name : #MicGitHubRessourceReferenceTest,
	#superclass : #TestCase,
	#category : #'Microdown-DocumentBrowser-Tests-ResourceModel'
}

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
	
	self assert: ref docFolder equals: { 'docs' }
]
