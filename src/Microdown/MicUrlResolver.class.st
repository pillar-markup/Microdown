Class {
	#name : #MicUrlResolver,
	#superclass : #MicAbstractResolver,
	#instVars : [
		'currentWorkingDirectory',
		'baseUrl'
	],
	#category : #'Microdown-Core'
}

{ #category : #accessing }
MicUrlResolver >> baseUrl [

	^ baseUrl
]

{ #category : #accessing }
MicUrlResolver >> baseUrlString: anObject [

	baseUrl := anObject
]

{ #category : #'accessing - resources' }
MicUrlResolver >> basicResolveAbsoluteFilePath: anAbsoluteMicFileReference [ 

	| fileReference |
	fileReference := currentWorkingDirectory resolvePath: anAbsoluteMicFileReference path.
	fileReference exists 	
		ifFalse: [ ^ MicNotFoundResource resource: anAbsoluteMicFileReference ].
	^ MicFileResource on: fileReference reference: anAbsoluteMicFileReference
]

{ #category : #resolving }
MicUrlResolver >> basicResolveRelativeReference: aMicRelativeReference [ 
	
	| fileReference |
	(fileReference := currentWorkingDirectory / aMicRelativeReference originalString)
		exists ifTrue: [ 
			^ MicFileResource on: fileReference reference: aMicRelativeReference
		 ].
	
	^ self basicResolveUrl: (MicResourceReference fromUri: (baseUrl, aMicRelativeReference originalString))
]

{ #category : #resolving }
MicUrlResolver >> basicResolveUrl: anAbsoluteFileURL [
	"Returns a resolved resources that will be later be rendered by a canvas such as the rich text composer by extracting a form for example from the resources."
	
	| url |
	url := anAbsoluteFileURL uri asZnUrl.
	self isCachingResources ifTrue: [ 
		^ self resourcesCache at: url ifAbsentPut: [ self rawResourceFromUrl: anAbsoluteFileURL ] ].
	^ self rawResourceFromUrl: anAbsoluteFileURL
	
	
]

{ #category : #accessing }
MicUrlResolver >> currentWorkingDirectory [

	^ currentWorkingDirectory
]

{ #category : #accessing }
MicUrlResolver >> currentWorkingDirectory: anObject [

	currentWorkingDirectory := anObject
]

{ #category : #resolving }
MicUrlResolver >> initialize [

	super initialize.
	"Use by default an empty url, it should fail all requests by default"
	baseUrl := ''.
	"Use an empty in-memory file system that will contain no files"
	currentWorkingDirectory := FileSystem memory root.
]

{ #category : #resolving }
MicUrlResolver >> rawResourceFromUrl: anAbsoluteFileURL [

	| client |
	self isOffline 
		ifTrue: [ ^ MicNotFoundResource resource: anAbsoluteFileURL ].
	[	
	(anAbsoluteFileURL uri asZnUrl asZnUrlWithDefaults)
		hasHost ifFalse: [ ZnMissingHost signal: 'Invalid Url: ', anAbsoluteFileURL uri ].

	(client := ZnEasy client)
		beBinary; "Let decoding to the user, this is just a file"
		url: anAbsoluteFileURL uri;
		enforceHttpSuccess: true;
		get ] on: ZnHttpUnsuccessful, ZnMissingHost do: [ :error |
			^ MicNotFoundResource resource: anAbsoluteFileURL error: error ].
	^ MicHttpResource on: client entity reference: anAbsoluteFileURL
]
