"
I am a path resolver for microdown.
References in microdown (currently (2021-11-19) links, images and inputfiles) can be either absolute references to a specific file or http address, or relative to an absolute reference.

I am a visitor which is given a `MicAbsoluteResourceReference`, and traverses a document and **resolves** all relative references with respect to the base reference. Resolution is to replace the relative reference with an absolute.

The mention of `Zink` in my name is a credit to the zink library ZnUrl which does the underlying resolution.
"
Class {
	#name : #MicZincPathResolver,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'absoluteReference'
	],
	#category : #'Microdown-Core'
}

{ #category : #'instance creation' }
MicZincPathResolver class >> resolve: document withBase: aZnUrl [
	"Assumes aZnUrl to be an absolute uri. Converts all relative references to absolute references in document"
	self error: 'Do not use me - make instance'.
	self new
		baseUri: aZnUrl;
		visit: document
		
]

{ #category : #accessing }
MicZincPathResolver >> absoluteReference: aReferenceOrString [
	absoluteReference := aReferenceOrString isString
		ifTrue: [ MicResourceReference fromUri: aReferenceOrString ]
		ifFalse: [ aReferenceOrString ]
]

{ #category : #visiting }
MicZincPathResolver >> resolveDocument: document [
	self visit: document
]

{ #category : #private }
MicZincPathResolver >> resolveReferenceIn: aNode [
	"currently links, figures and input nodes need to be resolved"
	| resolvedUri resolvedReference |
	aNode reference isRelative ifFalse: [ ^ self ].
	resolvedUri := absoluteReference uri withRelativeReference: aNode reference relativePath.
	resolvedReference := MicResourceReference fromUri: resolvedUri printString.
	resolvedReference isFileReference ifTrue: [ resolvedReference filesystem: absoluteReference filesystem ].
	aNode reference: resolvedReference
]

{ #category : #visiting }
MicZincPathResolver >> visitFigure: aFigure [

	self resolveReferenceIn: aFigure
]

{ #category : #visiting }
MicZincPathResolver >> visitInputFile: anInputFile [
	self resolveReferenceIn: anInputFile 
]

{ #category : #visiting }
MicZincPathResolver >> visitLink: aLink [
	self resolveReferenceIn: aLink
]
