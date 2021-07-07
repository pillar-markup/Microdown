Class {
	#name : #ChrysalMicrodownConfiguration,
	#superclass : #ChrysalConfiguration,
	#instVars : [
		'printer'
	],
	#category : #'Microdown - HeadReunbering'
}

{ #category : #accessing }
ChrysalMicrodownConfiguration >> initialize [
	"This is a hack waiting for a better management of the printer for NodeTransformer."
	super initialize. 
	printer := MicTitlePrinter new.
]

{ #category : #'backward compatibility' }
ChrysalMicrodownConfiguration >> levelConfigurationFor: aHeader [
	"I return a PRNumberingConfiguration corresponding for a Header."

	^ self printer perform: ('level' , aHeader level asString) asSymbol
]

{ #category : #'post hooks' }
ChrysalMicrodownConfiguration >> postTreat [

	(self propertyAt: #levels ifAbsent: [^ self ]) do: [ 
			:levelSpec |
			| instance |
			instance := (self printer printerSpecFor: levelSpec renderAs).
			instance fillFromAnother: levelSpec. 
			self printer level: instance n: levelSpec level. 
			 ]
]

{ #category : #accessing }
ChrysalMicrodownConfiguration >> printer [

	^ printer
]
