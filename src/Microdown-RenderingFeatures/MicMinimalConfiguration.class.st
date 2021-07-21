"
I'm a super simple configuration object. I exposed a subset of the configuration of Pillar configuration objects.
I'm a kind of configuration mock for aspects that are tested.

When Microdown is used in Pillar, the PRConfiguration will be used instead of this one. 

"
Class {
	#name : #MicMinimalConfiguration,
	#superclass : #Object,
	#instVars : [
		'newLine'
	],
	#category : #'Microdown-RenderingFeatures'
}

{ #category : #initialization }
MicMinimalConfiguration >> initialize [ 
	super initialize.
	newLine := String cr
]

{ #category : #accessing }
MicMinimalConfiguration >> newLine [
	^ newLine
]

{ #category : #accessing }
MicMinimalConfiguration >> newLine: aString [
	newLine := aString
]
