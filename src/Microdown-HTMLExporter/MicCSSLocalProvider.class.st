"
Includes behavior to install CSS libraries in a directory used as a base.

## Download CSS libraries

To download a set of pre-defined class-less CSS libraries, evaluate:

```
MicCSSProvider downloadCssLibs.
```

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
MicCSSLocalProvider class >> downloadCssLibs [

	self librarySelectors 
		do: [ : libAssoc |
			| client |
			(client := self httpClient) get: libAssoc value.
			self assertNonBinaryResponse: client response.
			self installCss: client response named: libAssoc key	 ]
		displayingProgress: 'Downloading CSS libraries'.

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
MicCSSLocalProvider class >> installCss: cssContent named: cssLibName [
	"Install all CSS libraries in baseDirectory"

	| destination |
	destination := self librariesDirectory.
	destination 	ensureCreateDirectory.

	"Because we move the support folder into a folder called _support"
	(destination / cssLibName , 'css') asFileReference 
		ensureDelete;
		writeStreamDo: [ : writeStream | writeStream << cssContent contents ].

]

{ #category : #accessing }
MicCSSLocalProvider class >> librariesDirectory [
	"Answer a <FileReference> containing CSS class-less libraries"

	^ self baseDirectory / 'support'.
]

{ #category : #accessing }
MicCSSLocalProvider class >> named: aString [
	"Answer a <String> representing a local path for CSS resource matching aString"

	^ (self librariesDirectory / (super named: aString) asZnUrl pathSegments last) fullName
		

]
