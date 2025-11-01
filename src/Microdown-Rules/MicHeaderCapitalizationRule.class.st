Class {
	#name : 'MicHeaderCapitalizationRule',
	#superclass : 'MicRule',
	#instVars : [
		'headersAreLowercase'
	],
	#category : 'Microdown-Rules-Capitalization',
	#package : 'Microdown-Rules',
	#tag : 'Capitalization'
}

{ #category : 'asserting' }
MicHeaderCapitalizationRule >> headersAreLowerCase [
	
	^ headersAreLowercase 
]

{ #category : 'asserting' }
MicHeaderCapitalizationRule >> shouldVerifyHeadersAreCapitalized [

	headersAreLowercase := false
]

{ #category : 'asserting' }
MicHeaderCapitalizationRule >> shouldVerifyHeadersAreLowercase [

	headersAreLowercase := true
]
