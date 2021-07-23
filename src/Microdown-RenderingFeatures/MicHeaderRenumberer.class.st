Class {
	#name : #MicHeaderRenumberer,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'configuration'
	],
	#category : #'Microdown-RenderingFeatures'
}

{ #category : #execution }
MicHeaderRenumberer class >> executeOn: aContext [

	self new
		configuration: aContext configuration;
		visit: aContext input.
	^ aContext
]

{ #category : #accessing }
MicHeaderRenumberer >> configuration [

	configuration
]

{ #category : #accessing }
MicHeaderRenumberer >> configuration: anObject [

	configuration := anObject.
]

{ #category : #visiting }
MicHeaderRenumberer >> visit: aMicRoot [

	| conf |
	"conf := ConfigurationForMicrodown newFromDictionary: aMicRoot properties."
	conf := MicMinimalConfiguration new.
	conf parent: configuration.
	self configuration: conf.
	super visit: aMicRoot.
	
	^ aMicRoot
]

{ #category : #visiting }
MicHeaderRenumberer >> visitHeader: aHeader [

	aHeader level: aHeader level + configuration headingLevelOffset
]
