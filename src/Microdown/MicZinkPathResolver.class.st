Class {
	#name : #MicZinkPathResolver,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'baseUri'
	],
	#category : #'Microdown-Core'
}

{ #category : #'as yet unclassified' }
MicZinkPathResolver class >> resolve: document withBase: aZnUrl [
	self new
		baseUri: aZnUrl;
		visit: document
		
]

{ #category : #'as yet unclassified' }
MicZinkPathResolver >> baseUri: aZnUrl [
	baseUri := aZnUrl
]

{ #category : #visiting }
MicZinkPathResolver >> visitFigure: aFigure [
	| resolvedUri |
	aFigure reference isResolved 
		ifTrue: [ ^self ].
	resolvedUri := baseUri withRelativeReference: aFigure reference relativePath.
	aFigure reference: (MicResourceReference fromUri: (resolvedUri printString))
	
]

{ #category : #visiting }
MicZinkPathResolver >> visitInputFile: anInputFile [
]

{ #category : #visiting }
MicZinkPathResolver >> visitLink: aLink [
]
