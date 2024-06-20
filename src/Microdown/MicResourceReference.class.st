"
I represent a reference to binary or textual resources, primarily images and Microdown text.

References occur in Microdown in three different constructs:
- external links
- figures
- input files

I have subclasses to give access to files and http based resources, as well as access to resources already in the image.

## URI 
Resources are primarily referenced using **Uniform Resource Identifiers** (URI), and are created by my class method `fromUri:`, for example: `MicResourceReference fromUri: 'file:/path/to/mydocument.md'` or `MicResourceReference fromUri: 'https://host/path/to/myimage.png'`

## Special cases
As a special case `MicFileResourceReference` can be created from a regular pharo `FileReference`.

Besides the absolute resource references (file, http), `MicRelativeResourceReference` is a partial/relative reference, that must be resolved with respect to an absolute reference before the resource can be accessed. Resolution of relative references is done by `MicZincPathResolver`.

## Extension
It is possible to add new kinds of ResourceReferences. The idea is that each resource reference type uses its own schema name in the URI. For example, files are supported by the scheme `file://...`. Your new resource reference should:

- implement `handlesUriScheme:` on the class side, returning true if the given scheme is handled by your extension.
- maybe override `newFromUri:` on the class side if your reference type needs to handle the instantiation of reference objects.
"
Class {
	#name : 'MicResourceReference',
	#superclass : 'Object',
	#category : 'Microdown-Core',
	#package : 'Microdown',
	#tag : 'Core'
}

{ #category : 'instance creation' }
MicResourceReference class >> fromUri: aString [
	| uri refClass |
	(aString beginsWith: '/')
		ifTrue: [ ^ MicFileResourceReference new uri: (ZnUrl fromString: 'file://',aString) ].
	uri := ZnUrl fromString: aString.
	uri scheme
		ifNil: [ ^ MicRelativeResourceReference new relativePath: aString ].
	refClass := self allSubclasses 
		detect: [ :rc | rc handlesUriScheme: uri scheme ]
		ifNone: [ MicUnknownResourceUri ].
	^ refClass newFromUri: uri
	
]

{ #category : 'instance creation' }
MicResourceReference class >> handlesUriScheme: scheme [
	"Return true if this class can handle the scheme name. 
	Part of the extension mechanism for new ressource reference types"
	^ false
]

{ #category : 'instance creation' }
MicResourceReference class >> newFromUri: uri [
	"Default implementation"
	^ self new uri: uri; yourself
]

{ #category : 'converting' }
MicResourceReference >> asMicResourceReference [

	^ self 
]

{ #category : 'accessing' }
MicResourceReference >> fullName [
	"Returns the full name of the resources (without microdown arguments) i.e, http://pharo.org/community/foo.png"
	
	^ self uriString 
]

{ #category : 'testing' }
MicResourceReference >> isDirectory [ 
	^ false
]

{ #category : 'testing' }
MicResourceReference >> isRelative [
	^ false
]
