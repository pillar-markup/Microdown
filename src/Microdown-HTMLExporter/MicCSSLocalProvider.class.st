"
Includes behavior to download pre-defined CSS libraries in a local directory. Supported libraries are specified in a class protocol named ""libraries""

## Download CSS libraries

To download a set of pre-defined class-less CSS libraries, evaluate:

```
MicCSSLocalProvider getCSSLibs.
```

See superclass comments to check how to add a CSS library.

The destination folder where CSS libraries are downloaded can be configured with #destinationDir:

```
MicCSSLocalProvider destinationDir: 'css_libs';
```
"
Class {
	#name : #MicCSSLocalProvider,
	#superclass : #MicCSSProvider,
	#classInstVars : [
		'destinationDir'
	],
	#category : #'Microdown-HTMLExporter'
}

{ #category : #accessing }
MicCSSLocalProvider class >> assertNonBinaryResponse: response [ 
	
	response contentType isBinary 
		ifTrue: [ Error signal: 'Did not expect a binary response but got ', response contentType printString ].
]

{ #category : #accessing }
MicCSSLocalProvider class >> destinationDir [

	^ destinationDir
		ifNil: [ destinationDir := 'support' ]
]

{ #category : #accessing }
MicCSSLocalProvider class >> destinationDir: aPathname [

	destinationDir := aPathname
]

{ #category : #accessing }
MicCSSLocalProvider class >> getCSSLib: cssLibSelector [
	"Download a CSS library using information provided in cssLibSelector method. Prioritize minified versions."

	| cssLibDict |

	cssLibDict := self libAttributesFor: cssLibSelector.
	(cssLibDict includesKey: #minCss)
		ifTrue: [ self getCSSLibFrom: (cssLibDict at: #minCss) ]
		ifFalse: [ 
			(cssLibDict includesKey: #css)
				ifTrue: [ self getCSSLibFrom: (cssLibDict at: #css) ] ]
]

{ #category : #accessing }
MicCSSLocalProvider class >> getCSSLibFrom: anURLString [ 

	| client |

	(client := self httpClient) get: anURLString.
	self assertNonBinaryResponse: client response.
	self 
		installCss: client response contents
		named: client requestedResource
]

{ #category : #accessing }
MicCSSLocalProvider class >> getCSSLibs [
	"Download CSS libraries specified in the class protocol of the receiver, and install them on disk.
	We download both minified and normal versions of the CSS, if possible. In any case, at leat one should be available"

	self librarySelectors 
		do: [ : cssLibSelector | self getCSSLib: cssLibSelector ]
		displayingProgress: 'Downloading CSS libraries'
]

{ #category : #accessing }
MicCSSLocalProvider class >> httpClient [
	"Return a new, specifically configured instance of the HTTP client for internal use.
	Note how we request GZIP compression and will signal progress."

	^ ZnClient new
		systemPolicy;
		beOneShot;
		signalProgress: true;
		ifFail: [ :exception | self error: 'Could not load : ', exception printString ];
		yourself
]

{ #category : #accessing }
MicCSSLocalProvider class >> installCss: cssString named: cssLibName [
	"Install all CSS <String> in baseDirectory as cssLibName"

	| destination |
	destination := self librariesDirectory.
	destination 	ensureCreateDirectory.
	(destination / cssLibName) asFileReference 
		ensureDelete;
		writeStreamDo: [ : writeStream | writeStream << cssString ].

]

{ #category : #accessing }
MicCSSLocalProvider class >> librariesDirectory [
	"Answer a <FileReference> containing CSS class-less libraries"

	^ self destinationDir asFileReference
]

{ #category : #accessing }
MicCSSLocalProvider class >> named: aString [
	"Answer a <MicCSSFile> representing a CSS resource matching aString"

	| cssFilename |
	
	cssFilename := (super named: aString) asZnUrl pathSegments last.
	^ MicCSSFile new
		fileReference: (self librariesDirectory / cssFilename);
		yourself
		

]
