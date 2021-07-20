"
This visitor do a reunbering of Header which can use to do LaTeX with Microdown
"
Class {
	#name : #MicHeaderRenunberer,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'configuration'
	],
	#category : #'Microdown-RenderingFeatures'
}

{ #category : #execution }
MicHeaderRenunberer class >> executeOn: aContext [

	self new
		configuration: aContext configuration;
		visit: aContext input.
	^ aContext
]

{ #category : #accessing }
MicHeaderRenunberer >> configuration [

	configuration
]

{ #category : #accessing }
MicHeaderRenunberer >> configuration: anObject [

	configuration := anObject.
]

{ #category : #visiting }
MicHeaderRenunberer >> visit: aMicRoot [

	| conf |
	conf := ConfigurationForMicrodown newFromDictionary: aMicRoot properties.
	conf parent: configuration.
	self configuration: conf.
	super visit: aMicRoot.
	^ aMicRoot
]

{ #category : #visiting }
MicHeaderRenunberer >> visitHeader: aHeader [

	aHeader level: aHeader level + configuration headingLevelOffset
]
