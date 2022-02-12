Class {
	#name : #MicReferenceTestCase,
	#superclass : #TestCase,
	#instVars : [
		'resource'
	],
	#category : #'Microdown-Tests-Resources'
}

{ #category : #testing }
MicReferenceTestCase >> resourceReference [

	^ MicPharoResourceReference new uri: 'pharo:///OrderedCollection/add:'
]
