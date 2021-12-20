Class {
	#name : #MicPharoResourceTest,
	#superclass : #TestCase,
	#instVars : [
		'resolver'
	],
	#category : #'Microdown-Tests-Resources'
}

{ #category : #initialization }
MicPharoResourceTest >> setUp [
	super setUp.
	resolver := MicUrlResolver new
]

{ #category : #tests }
MicPharoResourceTest >> testLoadClassResourceShowsDefinitionStringAsText [

	| uri classResource |
	uri := 'pharo:///Object' asMicResourceUri.
	classResource := uri resolveResourceIn: resolver.

	self assert: classResource asText equals: Object definitionString asText
]
