"
A Cascading Style Sheets (CSS) framework is a library of prepared and ready-to-use standards-compliant CSS rules which implements cross-browser functionality. A Microdown CSS framework represents a library intended to be used as part of setting up a `MicHTMLDoc`. It contains CSS helper classes, typography, structures, equalizers (to create equivalent height content), reset (browser normalization).

It also could have:
  - A minified version (usually named as .min.css) where extra comments and white space were removed.
  - A normalized URL to apply browser default styling.
  - A Collection of fonts URL's. _These should be downloaded manually for now_
  - A Collection of themes URL's.

# Usage

To include a Microdown CSS Framework, send the message #addCSSFrameworkNamed: with a String representing the name of the framework.

```language=Pharo
MMicHTMLDoc new
	addCSSFrameworkNamed: 'Tufte';
	fromMicrodown: 'Your Microdown document';
	writeToFile.
```

# Internal Representation and Key Implementation Points.

Instance Variables
	cssFile: 			<MicCSSFile>
	cssUrl:			<String>
	fonts:				<Collection>
	mainUrl:			<String>
	minCssUrl:		<String>
	name:				<String>
	normalizeUrl:	<String>
	resetUrl:			<String>
	themes:			<Collection>

"
Class {
	#name : #MicCSSFramework,
	#superclass : #MicCSSEntity,
	#instVars : [
		'mainUrl',
		'minCssUrl',
		'normalizeUrl',
		'resetUrl',
		'fonts',
		'normalThemes',
		'minThemes'
	],
	#category : #'Microdown-HTMLExporter-CSS'
}

{ #category : #accessing }
MicCSSFramework >> fonts [
	"Answer a <Collection> of receiver's typographies"

	^ fonts
]

{ #category : #accessing }
MicCSSFramework >> fonts: anObject [

	fonts := anObject
]

{ #category : #testing }
MicCSSFramework >> hasCDN [
	"Answer <true> if the receiver is provided through a CDN URL"
	
	self halt.
	^ self minCssUrl isCDN or: [ self cssUrl isCDN ]
]

{ #category : #testing }
MicCSSFramework >> hasMinifiedVersion [
	"Anwswer <true> if the receiver contains a minified version"
	
	^ self minCssUrl notEmpty
]

{ #category : #testing }
MicCSSFramework >> hasThemes [
	"Answer <true> if the receiver has themes"

	^ self normalThemes notEmpty or: [ self minThemes notEmpty ]
]

{ #category : #accessing }
MicCSSFramework >> mainUrl [
	"Answer a <String> representing the receiver's minified CSS URL"
	
	^ mainUrl
]

{ #category : #accessing }
MicCSSFramework >> mainUrl: anObject [

	mainUrl := anObject
]

{ #category : #accessing }
MicCSSFramework >> minCssUrl [
	"Answer a <String> with the URL endpoint of the minified source code, or empty if it is not present"

	^ minCssUrl
		ifNil: [ minCssUrl := String empty ]
]

{ #category : #accessing }
MicCSSFramework >> minCssUrl: anObject [

	minCssUrl := anObject
]

{ #category : #accessing }
MicCSSFramework >> minThemes [

	^ minThemes
]

{ #category : #accessing }
MicCSSFramework >> minThemes: aDictionary [
	"Set the receiver's minified themes according to aDictionary"

	minThemes := OrderedCollection new.
	aDictionary associationsDo: [ : assoc |
		minThemes add: (MicCSSTheme new 
			name: assoc key;
			framework: self;
			cssUrl: assoc value;
			beMinified;
			yourself)  ]
]

{ #category : #accessing }
MicCSSFramework >> normalThemes [
	"Answer a <Collection> of receiver's themes"

	^ normalThemes
]

{ #category : #accessing }
MicCSSFramework >> normalThemes: aDictionary [
	"Set the receiver's normal themes according to aDictionary"

	normalThemes := OrderedCollection new.
	aDictionary associationsDo: [ : assoc |
		normalThemes add: (MicCSSTheme new 
			name: assoc key;
			framework: self;
			cssUrl: assoc value;
			yourself)  ]
]

{ #category : #accessing }
MicCSSFramework >> normalizeUrl [
	"Answer a <String> with the URL endpoint of the Normalize library source code, or empty if it is not present"
	
	^ normalizeUrl
		ifNil: [ normalizeUrl := String empty ]
]

{ #category : #accessing }
MicCSSFramework >> normalizeUrl: anObject [

	normalizeUrl := anObject
]

{ #category : #printing }
MicCSSFramework >> printOn: aStream [

	super printOn: aStream.
	aStream 
		<< ': ';
		<< self name.
]

{ #category : #accessing }
MicCSSFramework >> resetUrl [
	"Answer a <String> with the URL endpoint of a Reset library source code, or empty if it is not present"

	^ resetUrl
]

{ #category : #accessing }
MicCSSFramework >> resetUrl: anObject [

	resetUrl := anObject
]

{ #category : #private }
MicCSSFramework >> writeTo: destDirFileRef [
	"Private - Write receiver's CSS resource into destDirFileRef"

	| fullOutputDir |
	fullOutputDir := (destDirFileRef ensureCreateDirectory / self basePath) ensureCreateDirectory.
	self cssFile copyTo: fullOutputDir / self cssFile basename.

]
