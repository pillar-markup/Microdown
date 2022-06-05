Class {
	#name : #MicMinimalConfigurationTest,
	#superclass : #TestCase,
	#instVars : [
		'config'
	],
	#category : #'Microdown-LaTeXExporter-Tests'
}

{ #category : #running }
MicMinimalConfigurationTest >> setUp [
	
	super setUp.
	config := MicMinimalConfiguration new.
]

{ #category : #tests }
MicMinimalConfigurationTest >> testCrAsNewLine [ 

	config crAsNewLine.
	self assert: config newLine equals: Character cr
]

{ #category : #tests }
MicMinimalConfigurationTest >> testCrlfAsNewLine [  

	config crlfAsNewLine.
	self assert: config newLine equals: String crlf
]

{ #category : #tests }
MicMinimalConfigurationTest >> testLfAsNewLine [  

	config lfAsNewLine.
	self assert: config newLine equals: Character lf
]
