"
I am a http reference encapsulating a http uri (`http//host/path/to/some/file.md`).


"
Class {
	#name : #MicHTTPResourceReference,
	#superclass : #MicAbsoluteResourceReference,
	#classVars : [
		'ResourcesCache'
	],
	#category : #'Microdown-Core'
}

{ #category : #accessing }
MicHTTPResourceReference class >> bytesForUrl: url [
	"I do the offline and isCachingResources logic
	In particular notice that #getBytesByHttp: throws an 
	exeption (MicHttpReferenceError) if fetchin is not successful"
	self offline
		ifTrue: [ ^ self resourcesCache in: [:cache | 
				(cache includesKey: url) 
					ifTrue: [ cache at: url ] 
					ifFalse: [(MicResourceReferenceError new messageText: 'Could not access ', url printString) signal]]].
	self isCachingResources 
		ifTrue: [ ^ self resourcesCache at: url ifAbsentPut: [ self getBytesByHttp: url ] ]
		ifFalse: [ ^ self getBytesByHttp: url ]
]

{ #category : #'as yet unclassified' }
MicHTTPResourceReference class >> getBytesByHttp: uri [
	| client |
	[(client := ZnEasy client)
		beBinary;
		url: uri;
		enforceHttpSuccess: true;
		get ] 
	on: ZnHttpUnsuccessful 
	do: [ :error | 
			error resignalAs: (MicResourceReferenceError new messageText: 'Could not access ', uri printString)  ].
	^ client entity bytes
]

{ #category : #testing }
MicHTTPResourceReference class >> initialize [
	"self initialize"
	
	<script>
	self resetResourcesCache 
]

{ #category : #testing }
MicHTTPResourceReference class >> isCachingResources [

	^ Microdown isCachingResources 
]

{ #category : #testing }
MicHTTPResourceReference class >> offline [
	^ Microdown offline
]

{ #category : #testing }
MicHTTPResourceReference class >> resetResourcesCache [ 

	ResourcesCache := nil 
]

{ #category : #testing }
MicHTTPResourceReference class >> resourcesCache [

	ResourcesCache ifNil: [ ResourcesCache := LRUCache new ].
	^ ResourcesCache
]

{ #category : #streams }
MicHTTPResourceReference >> binaryReadStream [
	^ self bytes readStream 
]

{ #category : #'as yet unclassified' }
MicHTTPResourceReference >> bytes [
	^ self class bytesForUrl: self uri
]

{ #category : #accessing }
MicHTTPResourceReference >> contents [
	^ self bytes utf8Decoded.
]
