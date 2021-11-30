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
Microdown class >> asRichText: aStringOrDoc [
	"Facade method to render a microdown document or string to Text"
	^ MicRichTextComposer asRichText:
		(aStringOrDoc isString 
			ifTrue: [  self parse: aStringOrDoc ]
			ifFalse: [ aStringOrDoc   ])
	
]

{ #category : #parsing }
Microdown class >> parse: aStreamOrString [

	^ MicroDownParser parse: aStreamOrString
]

{ #category : #parsing }
Microdown class >> resolve: document fromUri: uri [
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

	^ self class parse: aStreamOrString
]

{ #category : #rendering }
Microdown >> render: aStringOrDoc [
	"Facade method to render a microdown string to Text"
	^ self class render: aStringOrDoc 
	
]

{ #category : #parsing }
Microdown >> resolve: document fromUri: uri [
	"resolve all relative urls in document with respect to the absolute uri (aString|aZnUrl)"
	^ self class resolve: document fromUri: uri
]
