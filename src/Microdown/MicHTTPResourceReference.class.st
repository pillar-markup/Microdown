"
I am a HTTP reference encapsulating a HTTP URI (`http://host/path/to/some/file.md`).
"
Class {
	#name : 'MicHTTPResourceReference',
	#superclass : 'MicAbsoluteResourceReference',
	#classVars : [
		'ResourcesCache'
	],
	#category : 'Microdown-Core',
	#package : 'Microdown',
	#tag : 'Core'
}

{ #category : 'private' }
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

{ #category : 'private' }
MicHTTPResourceReference class >> getBytesByHttp: uri [
	| client |
	[(client := ZnEasy client)
		beBinary;
		url: uri;
		enforceHttpSuccess: true;
		get.
		^ client entity bytes ] 
	on: ZnHttpUnsuccessful, NetworkError, MessageNotUnderstood
	do: [ :error | 
			error resignalAs: (MicResourceReferenceError new messageText: 'Could not access ', uri printString)  ].
]

{ #category : 'instance creation' }
MicHTTPResourceReference class >> handlesUriScheme: scheme [
	^ scheme beginsWith: 'http'
]

{ #category : 'class initialization' }
MicHTTPResourceReference class >> initialize [
	"self initialize"

	<script>
	self resetResourcesCache
]

{ #category : 'testing' }
MicHTTPResourceReference class >> isCachingResources [

	^ Microdown isCachingResources 
]

{ #category : 'testing' }
MicHTTPResourceReference class >> offline [
	^ Microdown offline
]

{ #category : 'testing' }
MicHTTPResourceReference class >> resetResourcesCache [ 

	ResourcesCache := nil 
]

{ #category : 'testing' }
MicHTTPResourceReference class >> resourcesCache [

	ResourcesCache ifNil: [ ResourcesCache := LRUCache new ].
	^ ResourcesCache
]

{ #category : 'streams' }
MicHTTPResourceReference >> binaryReadStream [
	^ (self class bytesForUrl: self uri) readStream 
]

{ #category : 'accessing' }
MicHTTPResourceReference >> contents [
	^ (self class bytesForUrl: self uri) utf8Decoded.
]
