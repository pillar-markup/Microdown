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
	#superclass : #Object,
	#instVars : [
		'name',
		'mainUrl',
		'cssUrl',
		'minCssUrl',
		'themes',
		'normalizeUrl',
		'resetUrl',
		'fonts',
		'cssFile'
	],
	#category : #'Microdown-HTMLExporter-CSS'
}

{ #category : #accessing }
MicCSSFramework >> cssFile [

	^ cssFile
]

{ #category : #accessing }
MicCSSFramework >> cssFile: anObject [

	cssFile := anObject
]

{ #category : #accessing }
MicCSSFramework >> cssUrl [

	^ cssUrl
]

{ #category : #accessing }
MicCSSFramework >> cssUrl: anObject [

	cssUrl := anObject
]

{ #category : #accessing }
MicCSSFramework >> fonts [

	^ fonts
]

{ #category : #accessing }
MicCSSFramework >> fonts: anObject [

	fonts := anObject
]

{ #category : #accessing }
MicCSSFramework >> mainUrl [

	^ mainUrl
]

{ #category : #accessing }
MicCSSFramework >> mainUrl: anObject [

	mainUrl := anObject
]

{ #category : #accessing }
MicCSSFramework >> minCssUrl [

	^ minCssUrl
]

{ #category : #accessing }
MicCSSFramework >> minCssUrl: anObject [

	minCssUrl := anObject
]

{ #category : #accessing }
MicCSSFramework >> name [

	^ name
]

{ #category : #accessing }
MicCSSFramework >> name: anObject [

	name := anObject
]

{ #category : #accessing }
MicCSSFramework >> normalizeUrl [

	^ normalizeUrl
]

{ #category : #accessing }
MicCSSFramework >> normalizeUrl: anObject [

	normalizeUrl := anObject
]

{ #category : #accessing }
MicCSSFramework >> preferredCssFilename [
	"Answer a <String> representing the file name as obtained from the preferred URL"

	^ self preferredCssUrl pathSegments last.
	
]

{ #category : #accessing }
MicCSSFramework >> preferredCssUrl [
	"Answer a <String> representing the URL of the CSS resource prioritizing by preference"

	^ self minCssUrl 
		ifEmpty: [ self cssUrl
			ifEmpty: [ self error: 'Receiver must have at least a valid CSS url' ] ].
	
]

{ #category : #accessing }
MicCSSFramework >> resetUrl [

	^ resetUrl
]

{ #category : #accessing }
MicCSSFramework >> resetUrl: anObject [

	resetUrl := anObject
]

{ #category : #accessing }
MicCSSFramework >> themes [

	^ themes
]

{ #category : #accessing }
MicCSSFramework >> themes: anObject [

	themes := anObject
]
