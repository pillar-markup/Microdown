Class {
	#name : 'MicCodeSecondLineRule',
	#superclass : 'MicRule',
	#category : 'Microdown-Rules-Code',
	#package : 'Microdown-Rules',
	#tag : 'Code'
}

{ #category : 'asserting' }
MicCodeSecondLineRule >> shouldInsertEmptyLineAfterFirstLine: firstLine rest: restOfString [

	| trimmed |
	(restOfString beginsWith: Character cr asString) ifTrue: [ ^ false ].

	trimmed := restOfString trimLeft.

	((trimmed beginsWith: '!') or: [ trimmed beginsWith: '"' ]) ifTrue: [
		^ false ].

	^ true
]
