Class {
	#name : 'MicFirstLetterCapitalizeRule',
	#superclass : 'MicRule',
	#category : 'Microdown-Rules-BogusImplementation',
	#package : 'Microdown-Rules',
	#tag : 'BogusImplementation'
}

{ #category : 'action' }
MicFirstLetterCapitalizeRule >> matchingPattern: aWord [

	aWord ifEmpty: [ ^ false ].
	^ aWord first isUppercase
]
