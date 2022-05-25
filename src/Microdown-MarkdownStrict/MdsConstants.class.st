"
Constants to be used on the extended parser.
"
Class {
	#name : #MdsConstants,
	#superclass : #SharedPool,
	#classVars : [
		'InlineParagraphDelimiter'
	],
	#category : #'Microdown-MarkdownStrict'
}

{ #category : #initialization }
MdsConstants class >> initialize [

	InlineParagraphDelimiter := '  '
]
