Class {
	#name : 'MicFirstElementOfHeaderIsNotCapitalizedReport',
	#superclass : 'MicReport',
	#instVars : [
		'concern'
	],
	#category : 'Microdown-Rules-Capitalization',
	#package : 'Microdown-Rules',
	#tag : 'Capitalization'
}

{ #category : 'accessing' }
MicFirstElementOfHeaderIsNotCapitalizedReport >> concern [
	^ concern
]

{ #category : 'accessing' }
MicFirstElementOfHeaderIsNotCapitalizedReport >> concern: aString [ 
	concern := aString
]
