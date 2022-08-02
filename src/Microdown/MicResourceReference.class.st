"
I represent a reference to binary or textual ressources, primarily images and microdown text.

References occour in microdown in three different constructs:
- external links
- figures
- inputfiles

I have subclasses to give access to files and http bases resources, as well as access to resources already in the image.

## URI 
Resources are primarily referenced using **Uniform Resource Identifiers** (uri), and are created by my class side method `fromUri:` - for example: `MicResourceReference fromUri: 'file:/path/to/mydocument.md'` or `MicResourceReference fromUri: 'https://host/path/to/myimage.png'`

## Special cases
As a special case `MicFileResourceReference` can be created from a regular pharo `FileReference`.

Besides the absolute resource references (file, http), `MicRelativeResourceReference` is a partial/relative reference, which must be resolved with respect to an absolute reference before the resource can be accessed. Resolution of relative references is done by `MicZincPathResolver`.

## Extension
It is possible to add new kinds of ResourceReferences. The idea is each ressource reference type uses its own schema name in the uri - for example files are supported by the scheme `file://....`. Your new resource reference should:

- implement `handlesUriScheme:` on the class side returning true if the passes scheme is handled by your extension
- maybe override `newFromUri:` on the class side if your reference type need to handle the instantiation of reference objects



"
Class {
	#name : #MicResourceReference,
	#superclass : #Object,
	#category : #'Microdown-Core'
}

{ #category : #'instance creation' }
MicResourceReference class >> fromUri: aString [
	| uri refClass |
	(aString beginsWith: '/')
		ifTrue: [ ^ MicFileResourceReference new uri: (ZnUrl fromString: aString) ].
	uri := ZnUrl fromString: aString.
	uri scheme
		ifNil: [ ^ MicRelativeResourceReference new relativePath: aString ].
	refClass := self allSubclasses 
		detect: [ :rc | rc handlesUriScheme: uri scheme ]
		ifNone: [ MicResourceReferenceError signal: 'Unknown uri scheme: ', uri scheme ].
	^ refClass newFromUri: uri
	
]

{ #category : #'instance creation' }
MicResourceReference class >> handlesUriScheme: scheme [
	"Return true if this class can handle the scheme name. 
	Part of the extension mechanism for new ressource reference types"
	^ false
]

{ #category : #'instance creation' }
MicResourceReference class >> newFromUri: uri [
	"Default implementation"
	^ self new uri: uri; yourself
]

{ #category : #testing }
MicResourceReference >> isDirectory [ 
	^ false
]

{ #category : #testing }
MicResourceReference >> isRelative [
	^ false
]
