"
Constants to be used on the extended parser.
"
Class {
	#name : #MacConstants,
	#superclass : #SharedPool,
	#classVars : [
		'InlineParagraphDelimiter'
	],
	#category : #'Microdown-Macrodown'
}

{ #category : #initialization }
MacConstants class >> initialize [

	InlineParagraphDelimiter := '  '
]
