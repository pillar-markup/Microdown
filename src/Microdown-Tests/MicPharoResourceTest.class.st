Class {
	#name : #MicPharoResourceTest,
	#superclass : #TestCase,
	#instVars : [
		'resolver'
	],
	#category : #'Microdown-Tests-Resources'
}

{ #category : #tests }
MicPharoResourceTest >> assertNotFoundText: aResource [

	self assert: aResource asText equals: 'Resource not found'
]

{ #category : #running }
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

{ #category : #tests }
MicPharoResourceTest >> testLoadMethodResourceShowsDefinitionStringAsText [

	| uri methodResource |
	uri := 'pharo:///Object/yourself' asMicResourceUri.
	methodResource := uri resolveResourceIn: resolver.

	self assert: methodResource asText equals: (Object >> #yourself) definitionString asText
]

{ #category : #tests }
MicPharoResourceTest >> testLoadNonExistingClassResourceShowsError [

	| uri classResource |
	uri := 'pharo:///WhatObjectNotExisssst' asMicResourceUri.
	classResource := uri resolveResourceIn: resolver.

	self assertNotFoundText: classResource
]

{ #category : #tests }
MicPharoResourceTest >> testLoadNonExistingMethodResourceShowsError [

	| uri methodResource |
	uri := 'pharo:///Object/notyourselfbla' asMicResourceUri.
	methodResource := uri resolveResourceIn: resolver.

	self assertNotFoundText: methodResource
]
