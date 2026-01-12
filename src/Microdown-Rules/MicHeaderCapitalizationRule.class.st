Class {
	#name : 'MicHeaderCapitalizationRule',
	#superclass : 'MicRule',
	#instVars : [
		'headersAreLowercase',
		'uncapitalizableText',
		'unlowercasableText',
		'ifAddDefaultNotCapitalized'
	],
	#category : 'Microdown-Rules-CapitalizationUnderway',
	#package : 'Microdown-Rules',
	#tag : 'CapitalizationUnderway'
}

{ #category : 'stop words' }
MicHeaderCapitalizationRule >> addDefaultTextThatShouldNotBeCapitalized [
	
	ifAddDefaultNotCapitalized 
		ifTrue: [ 
			uncapitalizableText addAll: self defaultTextThatShouldNotBeCapitalized ]
]

{ #category : 'stop words' }
MicHeaderCapitalizationRule >> defaultTextThatShouldNotBeCapitalized [

	^ #( 'a' 'an' 'both' 'the' 'and' 'as' 'at' 'but' 'by' 'down'
	     'for' 'from' 'if' 'in' 'into' 'like' 'near' 'nor' 'of' 'off'
	     'on' 'one' 'once' 'onto' 'or' 'over' 'past' 'so' 'than' 'that' 'to'
	     'upon' 'when' 'with' 'yet' ) 
]

{ #category : 'asserting' }
MicHeaderCapitalizationRule >> headersAreLowerCase [
	
	^ headersAreLowercase 
]

{ #category : 'stop words' }
MicHeaderCapitalizationRule >> ifAddDefaultNotCapitalized [

	^ ifAddDefaultNotCapitalized
]

{ #category : 'stop words' }
MicHeaderCapitalizationRule >> ifAddDefaultNotCapitalized: anObject [

	ifAddDefaultNotCapitalized := anObject
]

{ #category : 'initialization' }
MicHeaderCapitalizationRule >> initialize [

	super initialize.
	uncapitalizableText := OrderedCollection new.
	unlowercasableText := OrderedCollection new. 
	ifAddDefaultNotCapitalized := true
]

{ #category : 'asserting' }
MicHeaderCapitalizationRule >> shouldVerifyHeadersAreCapitalized [

	headersAreLowercase := false
]

{ #category : 'asserting' }
MicHeaderCapitalizationRule >> shouldVerifyHeadersAreLowercase [

	headersAreLowercase := true
]

{ #category : 'stop words' }
MicHeaderCapitalizationRule >> uncapitalizableText [
	
	^ uncapitalizableText 
	
]
