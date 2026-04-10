Class {
	#name : 'MicHeaderRenumberer',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'configuration'
	],
	#category : 'Microdown-RenderingFeatures',
	#package : 'Microdown-RenderingFeatures'
}

{ #category : 'execution' }
MicHeaderRenumberer class >> executeOn: aContext [

	self new
		configuration: aContext configuration;
		visit: aContext input.
	^ aContext
]

{ #category : 'accessing' }
MicHeaderRenumberer >> configuration [

	configuration
]

{ #category : 'accessing' }
MicHeaderRenumberer >> configuration: anObject [

	configuration := anObject.
]

{ #category : 'visiting' }
MicHeaderRenumberer >> initialize [ 

	configuration := MicMinimalConfiguration new.
	
]

{ #category : 'visiting' }
MicHeaderRenumberer >> visitHeader: aHeader [

	aHeader level: aHeader level + configuration headingLevelOffset
]
