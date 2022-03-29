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



"
Class {
	#name : #MicResourceReference,
	#superclass : #Object,
	#category : #'Microdown-Core'
}

{ #category : #'instance creation' }
MicResourceReference class >> fromUri: aString [
	| uri |
	(aString beginsWith: '/')
		ifTrue: [ ^ MicFileResourceReference new uri: (ZnUrl fromString: 'file://',aString) ].
	uri := ZnUrl fromString: aString.
	uri scheme
		ifNil: [ ^ MicRelativeResourceReference new relativePath: aString ].
	(uri scheme beginsWith: 'http')
		ifTrue: [ ^ MicHTTPResourceReference new uri: uri ].
	uri scheme = 'file'
		ifTrue: [ ^ MicFileResourceReference new uri: uri ].
	uri scheme = 'pharo'
		ifTrue: [ ^ MicPharoResourceReference new uri: uri ].
	uri scheme = 'comment'
		ifTrue: [ ^ MicPharoCommentResourceReference newFromUri: uri ].
	^uri
	
]

{ #category : #testing }
MicResourceReference >> isDirectory [ 
	^ false
]

{ #category : #testing }
MicResourceReference >> isRelative [
	^ false
]
