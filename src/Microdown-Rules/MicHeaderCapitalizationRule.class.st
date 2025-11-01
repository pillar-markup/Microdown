Class {
	#name : 'MicHeaderCapitalizationRule',
	#superclass : 'MicRule',
	#instVars : [
		'shouldVerifyHeadersAreNotCapitilized'
	],
	#category : 'Microdown-Rules-Capitalization',
	#package : 'Microdown-Rules',
	#tag : 'Capitalization'
}

{ #category : 'asserting' }
MicHeaderCapitalizationRule >> shouldVerifyHeadersAreNotCapitilized [
	
	shouldVerifyHeadersAreNotCapitilized := true
]
