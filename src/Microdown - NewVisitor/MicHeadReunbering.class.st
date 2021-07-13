"
This visitor do a reunbering of Header which can use to do LaTeX with Microdown
"
Class {
	#name : #MicHeadReunbering,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'configuration'
	],
	#category : #'Microdown - NewVisitor'
}

{ #category : #execution }
MicHeadReunbering class >> executeOn: aContext [

	self new
		configuration: aContext configuration;
		visit: aContext input.
	^ aContext
]

{ #category : #accessing }
MicHeadReunbering >> configuration [

	configuration
]

{ #category : #accessing }
MicHeadReunbering >> configuration: anObject [

	configuration := anObject.
]

{ #category : #visiting }
MicHeadReunbering >> visit: aMicRoot [

	| conf |
	conf := ConfigurationForMicrodown newFromDictionary: aMicRoot properties.
	conf parent: configuration.
	self configuration: conf.
	super visit: aMicRoot.
	^ aMicRoot
]

{ #category : #visiting }
MicHeadReunbering >> visitHeader: aHeader [

	aHeader level: aHeader level + configuration headingLevelOffset
]
