"
Provides common support for CSS artifacts, such as frameworks (a.k.a. libraries) or themes.

A CSS entity provides:

  - A ""base path"" location.
  - The CSS file, which is an instance of `MicCSSFile`
  - The CSS URL.
  - Its source code String.

The basePath defaults to the value in #defaultBasePath (commonly ""css/""), however, the location of css files could be changed using the setter #basePath: and a folder `String` as parameter.
"
Class {
	#name : #MicCSSEntity,
	#superclass : #Object,
	#instVars : [
		'name',
		'cssUrl',
		'minCssUrl',
		'cssFile',
		'minCssFile',
		'destinationPath'
	],
	#category : #'Microdown-HTMLExporter-CSS'
}

{ #category : #accessing }
MicCSSEntity >> cssFile [
	"Answer the receiver's <MicCSSFile>"

	^ cssFile contents
		ifEmpty: [ minCssFile ]
		ifNotEmpty: [ cssFile ]
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
			<< self destinationPath;
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
MicCSSEntity >> destinationPath [
	"Answer a <String> representing the receciver's path without its file name"

	^ destinationPath
		ifNil: [ destinationPath := self defaultBasePath ]
]

{ #category : #accessing }
MicCSSEntity >> destinationPath: anObject [

	destinationPath := anObject
]

{ #category : #accessing }
MicCSSEntity >> minCssFile [

	^ minCssFile
]

{ #category : #accessing }
MicCSSEntity >> minCssFile: anObject [

	minCssFile := anObject
]

{ #category : #accessing }
MicCSSEntity >> minCssUrl [
	"Answer a <String> with the URL endpoint of the minified source code, or empty if it is not present"

	^ minCssUrl
		ifNil: [ minCssUrl := String empty ]
]

{ #category : #accessing }
MicCSSEntity >> minCssUrl: anObject [

	minCssUrl := anObject
]

{ #category : #accessing }
MicCSSEntity >> minifiedSourceCode [
	"Answer a <String> representing the receiver's minified CSS source version"

	^ self minCssFile contents
]

{ #category : #accessing }
MicCSSEntity >> name [

	^ name
]

{ #category : #accessing }
MicCSSEntity >> name: anObject [

	name := anObject
]

{ #category : #printing }
MicCSSEntity >> printOn: aStream [

	super printOn: aStream.
	aStream 
		<< ': ';
		<< self name.
]

{ #category : #accessing }
MicCSSEntity >> sourceCode [
	"Answer a <String> representing the receiver's CSS source"
	
	^ self cssFile contents
]
