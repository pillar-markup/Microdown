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
		'destinationPath',
		'basePath'
	],
	#category : #'Microdown-HTMLExporter-CSS'
}

{ #category : #defaults }
MicCSSEntity >> basePath [
	"Answer a <String> with the location where the receiver will be installed"
	
	^ basePath
		ifNil: [ basePath := self defaultBasePath ]
]

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

	^ 'css/'
]

{ #category : #defaults }
MicCSSEntity >> defaultDestinationPath [
	"Answer a default <String> describing the location where receiver's CSS files are stored"
	
	^ 'support/'
]

{ #category : #accessing }
MicCSSEntity >> destinationPath [
	"Answer a <String> representing the location used to store the receiver"

	^ destinationPath
		ifNil: [ destinationPath := self defaultDestinationPath ]
]

{ #category : #accessing }
MicCSSEntity >> destinationPath: anObject [

	destinationPath := anObject
]

{ #category : #testing }
MicCSSEntity >> hasMinifiedVersion [
	"Anwswer <true> if the receiver contains a minified version"
	
	^ self minCssUrl notEmpty
]

{ #category : #testing }
MicCSSEntity >> hasNormalVersion [
	"Anwswer <true> if the receiver contains a normal (human-legible) version"
	
	^ self cssUrl notEmpty
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

{ #category : #'accessing - source code' }
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

{ #category : #'instance creation' }
MicCSSEntity >> newCssFile: frwSpec version: versionSymbol [
	"Private - Answer a new valid <MicCSSFile> configured with the minified CSS URL if present, if not try to resolve a normal CSS URL. Raise an <Error> if frwSpec does not have a CSS URL"

	^ frwSpec 
		at: versionSymbol
		ifPresent: [ : frwSpecCssUrl | self newCssFileFor: frwSpecCssUrl ]
		ifAbsent: [ MicCSSNullFile new  ].

]

{ #category : #accessing }
MicCSSEntity >> newCssFileFor: aCssUrl [

	^ MicCSSFile new
		fileReference: (self destinationPath asFileReference / aCssUrl asZnUrl filename);
		yourself
]

{ #category : #'instance creation' }
MicCSSEntity >> newCssFiles: frwSpec [
	"Answer a new valid <MicCSSFile> configured with the minified CSS URL if present, if not try to resolve a normal CSS URL. Raise an <Error> if frwSpec does not have a CSS URL"

	self cssFile: (self newCssFile: frwSpec version: #css).
	self minCssFile: (self newCssFile: frwSpec version: #minCss)
]

{ #category : #printing }
MicCSSEntity >> printOn: aStream [

	super printOn: aStream.
	aStream 
		<< ': ';
		<< self name.
]

{ #category : #'accessing - source code' }
MicCSSEntity >> sourceCode [
	"Answer a <String> representing the receiver's CSS source"
	
	^ self cssFile contents
]

{ #category : #accessing }
MicCSSEntity >> writeTo: destDirFileRef [
	"Private - Write receiver's CSS resource into destDirFileRef"

	| fullOutputDir |
	fullOutputDir := (destDirFileRef ensureCreateDirectory / self basePath) ensureCreateDirectory.
	self cssFile copyTo: fullOutputDir / self cssFile basename.
]
