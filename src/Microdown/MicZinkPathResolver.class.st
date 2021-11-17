Class {
	#name : #MicZinkPathResolver,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'baseUri'
	],
	#category : #'Microdown-Core'
}

{ #category : #'instance creation' }
MicZinkPathResolver class >> resolve: document withBase: aZnUrl [
	"Assumes aZnUrl to be an absolute uri. Converts all relative references to absolute references in document"
	self new
		baseUri: aZnUrl;
		visit: document
		
]

{ #category : #accessing }
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
