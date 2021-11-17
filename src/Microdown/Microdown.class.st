"
I'm the favored entry point to use microdown. I'm a kind of facade to steer Microdown services.
In particular I invoke a resolver for paths after parsing documents.
 
"
Class {
	#name : #Microdown,
	#superclass : #Object,
	#instVars : [
		'parser'
	],
	#category : #'Microdown-Core'
}

{ #category : #parsing }
Microdown >> builder [

	^ parser builder
]

{ #category : #parsing }
Microdown >> initialize [ 
	super initialize.
	parser := MicroDownParser new.
	 
]

{ #category : #parsing }
Microdown >> parse: aStreamOrString [

	^ parser parse: aStreamOrString
]

{ #category : #parsing }
Microdown >> resolve: document fromUri: uri [
	"resolve all relative urls in document with respect to the absolute uri (aString|aZnUrl)"
	|baseUri|
	baseUri := uri.
	(uri isString | uri isText)
		ifTrue: [ baseUri := uri asString asUrl ].
	baseUri isRelative 
		ifTrue: [ ^ self error: 'can only resolve with absolute uri as base' ].
	MicZinkPathResolver resolve: document  withBase: baseUri.
	^ document 
]
