Class {
	#name : 'MicHeaderCapitalizationRule',
	#superclass : 'MicRule',
	#instVars : [
		'headersAreLowercase',
		'uncapitalizableText',
		'unlowercasableText',
		'ifAddDefaultNotCapitalized'
	],
	#category : 'Microdown-Rules-Capitalization',
	#package : 'Microdown-Rules',
	#tag : 'Capitalization'
}

{ #category : 'stop words' }
MicHeaderCapitalizationRule >> addDefaultTextThatShouldNotBeCapitalized [
	
	ifAddDefaultNotCapitalized 
		ifTrue: [ 
	uncapitalizableText addAll: #('to' 'as' 'in' 'of' 'a' 'an' 'one' 'both' 'the') ]
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
