Class {
	#name : 'MicFirstLetterCapitalizeRule',
	#superclass : 'MicRule',
	#category : 'Microdown-Rules-Capitalization',
	#package : 'Microdown-Rules',
	#tag : 'Capitalization'
}

{ #category : 'action' }
MicFirstLetterCapitalizeRule >> matchingPattern: aWord [

	aWord ifEmpty: [ ^ false ].
	^ aWord first isUppercase
]
