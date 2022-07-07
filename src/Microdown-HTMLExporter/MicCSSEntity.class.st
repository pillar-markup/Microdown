Class {
	#name : #MicCSSEntity,
	#superclass : #Object,
	#instVars : [
		'name',
		'cssUrl',
		'cssFile',
		'basePath'
	],
	#category : #'Microdown-HTMLExporter-CSS'
}

{ #category : #accessing }
MicCSSEntity >> basePath [
	"Answer a <String> representing the receciver's path without its file name"

	^ basePath
		ifNil: [ basePath := self defaultBasePath ]
]

{ #category : #accessing }
MicCSSEntity >> basePath: anObject [

	basePath := anObject
]

{ #category : #accessing }
MicCSSEntity >> cssFile [
	"Answer the receiver's <MicCSSFile>"

	^ cssFile
]

{ #category : #accessing }
MicCSSEntity >> cssFile: anObject [

	cssFile := anObject
]

{ #category : #accessing }
MicCSSEntity >> cssPath [
	"Answer a <String> describing the location path for the receiver"
	
	^ String streamContents: [ : stream |
		stream 
			<< self basePath;
			<< self cssFile basename ]
]

{ #category : #accessing }
MicCSSEntity >> cssUrl [
	"Answer a <String> representing the receiver's human-readable CSS URL"

	^ cssUrl
]

{ #category : #accessing }
MicCSSEntity >> cssUrl: anObject [

	cssUrl := anObject
]

{ #category : #defaults }
MicCSSEntity >> defaultBasePath [
	"Answer a default <String> describing the location where receiver's CSS files are stored"
	
	^ 'css/'
]

{ #category : #accessing }
MicCSSEntity >> name [

	^ name
]

{ #category : #accessing }
MicCSSEntity >> name: anObject [

	name := anObject
]

{ #category : #accessing }
MicCSSEntity >> sourceCode [
	"Answer a <String> representing the receiver's CSS source"
	
	^ self cssFile contents
]
