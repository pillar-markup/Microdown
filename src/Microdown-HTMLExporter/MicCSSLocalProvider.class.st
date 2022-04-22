"
Includes behavior to download pre-defined CSS libraries in a local directory. Supported libraries are specified in a class protocol named ""libraries""

## Download CSS libraries

To download a set of pre-defined class-less CSS libraries, evaluate:

```
MicCSSLocalProvider downloadCssLibs.
```

See superclass comments to check how to add a CSS library.
"
Class {
	#name : #MicCSSLocalProvider,
	#superclass : #MicCSSProvider,
	#category : #'Microdown-HTMLExporter'
}

{ #category : #accessing }
MicCSSLocalProvider class >> assertNonBinaryResponse: response [ 
	
	response contentType isBinary 
		ifTrue: [ Error signal: 'Did not expect a binary response but got ', response contentType printString ].
]

{ #category : #accessing }
MicCSSLocalProvider class >> downloadCSSLibNamed: aString from: anURLString [ 

	| client |

	(client := self httpClient) get: anURLString.
	self assertNonBinaryResponse: client response.
	self 
		installCss: client response contents
		named: aString
]

{ #category : #accessing }
MicCSSLocalProvider class >> downloadCSSLibs [
	"Download CSS libraries specified in the class protocol of the receiver, and install them on disk.
	We download both minified and normal versions of the CSS, if possible. In any case, at leat one should be available"

	self librarySelectors 
		do: [ : cssLibSelector |
			| cssLibDict |
			cssLibDict := (self libAttributesFor: cssLibSelector).
			(cssLibDict includesKey: #minCss)
				ifTrue: [ self downloadCSSLibNamed: ((cssLibDict at: #name) , '.min') from: (cssLibDict at: #minCss) ].
			(cssLibDict includesKey: #css)
				ifTrue: [ self downloadCSSLibNamed: (cssLibDict at: #name) from: (cssLibDict at: #css) ] ]
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

	"Because we move the support folder into a folder called _support"
	(destination / cssLibName , 'css') asFileReference 
		ensureDelete;
		writeStreamDo: [ : writeStream | writeStream << cssString ].

]

{ #category : #accessing }
MicCSSLocalProvider class >> librariesDirectory [
	"Answer a <FileReference> containing CSS class-less libraries"

	^ 'support' asFileReference
]

{ #category : #accessing }
MicCSSLocalProvider class >> named: aString [
	"Answer a <String> representing a local relative path for CSS resource matching aString"

	| cssFilename |
	
	cssFilename := (super named: aString) asZnUrl pathSegments last.
	^ MicCSSFile new
		fileReference: (self librariesDirectory / cssFilename);
		yourself
		

]
