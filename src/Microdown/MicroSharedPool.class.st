"
I define all the constants for parsing Microdown blocks.
"
Class {
	#name : #MicroSharedPool,
	#superclass : #SharedPool,
	#classVars : [
		'AnchorMarkup'
	],
	#category : #'Microdown-Parser'
}

{ #category : #initialization }
MicroSharedPool class >> initialize [
	"self initialize"
	
	AnchorMarkup := '@'
]
