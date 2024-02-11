"
A Cascading Style Sheets (CSS) **framework** is a library of prepared and ready-to-use standards-compliant CSS rules which implements cross-browser functionality. A Microdown CSS framework represents a library intended to be used as part of setting up a `MicHTMLDoc`. It contains CSS artifacts such as helper classes, typography, structures, equalizers (to create equivalent height content) and reset (browser normalization) resources.

It also could have:
  - A minified version (usually named as .min.css) where extra comments and white space were removed.
  - A normalized URL to apply browser default styling.
  - A Collection of fonts URL's. _These should be downloaded manually for now_
  - A Collection of themes URL's, which could be minified or normal (human-readable).

# Usage

To include a Microdown CSS Framework, send the message #addCSSNamed: with a String representing the name of the framework.

```language=Pharo
MicHTMLDoc new
	addCSSNamed: 'AwsmCSS';
	fromMicrodown: 'Your Microdown document';
	writeToFile.
```

To query the name of the available frameworks, open the Microdown HTML Styler application, or evaluate:

```language=pharo
MicCSSProvider new frameworks.
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
	#name : 'MicCSSFramework',
	#superclass : 'MicCSSEntity',
	#instVars : [
		'normalizeUrl',
		'resetUrl',
		'fonts',
		'themes',
		'projectUrl'
	],
	#category : 'Microdown-HTMLExporter-CSS',
	#package : 'Microdown-HTMLExporter',
	#tag : 'CSS'
}

{ #category : 'adding' }
MicCSSFramework >> addTheme: aMicCSSTheme [
	"Add aMicCSSTheme to the receiver themes. Answer the receiver"
	
	self themes add: aMicCSSTheme
]

{ #category : 'accessing' }
MicCSSFramework >> fonts [
	"Answer a <Collection> of receiver's typographies"

	^ fonts
		ifNil: [ fonts := OrderedCollection new ]
]

{ #category : 'accessing' }
MicCSSFramework >> fonts: anObject [

	fonts := anObject
]

{ #category : 'testing' }
MicCSSFramework >> hasMinifiedThemes [
	"Answer <true> if the receiver has any minified themes"
	
	^ self themes anySatisfy: #hasMinifiedVersion
]

{ #category : 'testing' }
MicCSSFramework >> hasNormalThemes [
	"Answer <true> if the receiver has any human-readable themes"
	
	^ self themes anySatisfy: #hasNormalVersion
]

{ #category : 'testing' }
MicCSSFramework >> hasThemes [
	"Answer <true> if the receiver has themes"

	^ self themes notEmpty
]

{ #category : 'private' }
MicCSSFramework >> newCssTheme: themeInfoDict [ 
	"Answer a new <MicCSSTheme> configured with values in aMicCSSTheme"

	^ MicCSSTheme new
			name: (themeInfoDict at: #name);
			newCssFiles: themeInfoDict;
			framework: self;
			cssUrl: (themeInfoDict at: #css ifAbsent: [ String empty ]);
			minCssUrl: (themeInfoDict at: #minCss ifAbsent: [ String empty ]);
			yourself
]

{ #category : 'accessing' }
MicCSSFramework >> normalizeUrl [
	"Answer a <String> with the URL endpoint of the Normalize library source code, or empty if it is not present"
	
	^ normalizeUrl
		ifNil: [ normalizeUrl := String empty ]
]

{ #category : 'accessing' }
MicCSSFramework >> normalizeUrl: anObject [

	normalizeUrl := anObject
]

{ #category : 'accessing' }
MicCSSFramework >> projectUrl [
	"Answer a <String> representing the receiver's minified CSS URL"
	
	^ projectUrl
		ifNil: [ projectUrl := String empty ]
]

{ #category : 'accessing' }
MicCSSFramework >> projectUrl: anObject [

	projectUrl := anObject
]

{ #category : 'accessing' }
MicCSSFramework >> resetUrl [
	"Answer a <String> with the URL endpoint of a Reset library source code, or empty if it is not present"

	^ resetUrl
		ifNil: [ resetUrl := String empty ]
]

{ #category : 'accessing' }
MicCSSFramework >> resetUrl: anObject [

	resetUrl := anObject
]

{ #category : 'accessing' }
MicCSSFramework >> themes [
	"Answer a <Collection> of <MicCSSTheme>"

	^ themes
		ifNil: [ themes := OrderedCollection new ]
]

{ #category : 'accessing' }
MicCSSFramework >> themes: aDictionary [
	"Set the receiver's normal themes according to aDictionary"

	themes := OrderedCollection new.
	aDictionary associationsDo: [ : themeInfoDict |
		themes add: (self newCssTheme: themeInfoDict) ]
]
