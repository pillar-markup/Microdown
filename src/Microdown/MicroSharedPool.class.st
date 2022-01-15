"
I define all the constants for parsing Microdown blocks.
"
Class {
	#name : #MicroSharedPool,
	#superclass : #SharedPool,
	#classVars : [
		'AnchorMarkup',
		'AnnotatedParagraphMarkup',
		'CodeblockMarkup',
		'CommentedLineMarkup',
		'HeaderMarkup'
	],
	#category : #'Microdown-Parser'
}

{ #category : #initialization }
MicroSharedPool class >> initialize [
	"self initialize"
	
	AnchorMarkup := '@'.
	AnnotatedParagraphMarkup := '!!'.
	CodeblockMarkup := '```'.
	CommentedLineMarkup := '%'.
	HeaderMarkup := '#'
]
