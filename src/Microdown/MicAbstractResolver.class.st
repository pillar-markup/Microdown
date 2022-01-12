"
I'm an alternate version of resource resolution. 
Contrary to MicZincPathResolver I do not expand once for all the relative paths.
"
Class {
	#name : #MicAbstractResolver,
	#superclass : #Object,
	#instVars : [
		'nextResolver'
	],
	#classVars : [
		'ResourcesCache'
	],
	#category : #'Microdown-Core'
}

{ #category : #'class initialization' }
MicAbstractResolver class >> initialize [
	"self initialize"
	
	<script>
	self resetResourcesCache 
]

{ #category : #resources }
MicAbstractResolver class >> isCachingResources [

	^ Microdown isCachingResources 
]

{ #category : #resources }
MicAbstractResolver class >> offline [
	^ Microdown offline
]

{ #category : #resources }
MicAbstractResolver class >> resetResourcesCache [ 

	ResourcesCache := nil 
]

{ #category : #resources }
MicAbstractResolver class >> resourcesCache [

	ResourcesCache ifNil: [ ResourcesCache := LRUCache new ].
	^ ResourcesCache
]

{ #category : #'accessing - resources' }
MicAbstractResolver >> basicResolveAbsoluteFilePath: anAbsoluteFileURL [

	self subclassResponsibility
]

{ #category : #'accessing - resources' }
MicAbstractResolver >> basicResolvePharoResource: aPharoResource [

	^ aPharoResource resolveOnCurrentImage 
]

{ #category : #resolving }
MicAbstractResolver >> basicResolveRelativeReference: aMicRelativeResource [ 
	
	self subclassResponsibility
]

{ #category : #'accessing - resources' }
MicAbstractResolver >> basicResolveUrl: anAbsoluteFileURL [

	self subclassResponsibility
]

{ #category : #testing }
MicAbstractResolver >> isCachingResources [ 
	^ self class isCachingResources
]

{ #category : #testing }
MicAbstractResolver >> isOffLine [ 
	^ Microdown offline
]

{ #category : #accessing }
MicAbstractResolver >> nextResolver: aMicDefaultResolver [ 
	
	nextResolver := aMicDefaultResolver
]

{ #category : #'accessing - resources' }
MicAbstractResolver >> resolveAbsoluteFilePath: anAbsoluteFileURL [

	^ (self basicResolveAbsoluteFilePath: anAbsoluteFileURL)
		ifNil: [ nextResolver resolveAbsoluteFilePath: anAbsoluteFileURL ]
]

{ #category : #'accessing - resources' }
MicAbstractResolver >> resolvePharoResource: aPharoResource [

	^ (self basicResolvePharoResource: aPharoResource)
		ifNil: [ nextResolver resolvePharoResource: aPharoResource ]
]

{ #category : #'accessing - resources' }
MicAbstractResolver >> resolveRelativeUrl: anAbsoluteFileURL [

	^ (self basicResolveRelativeReference: anAbsoluteFileURL)
		ifNil: [ nextResolver resolveRelativeUrl: anAbsoluteFileURL ]
]

{ #category : #'accessing - resources' }
MicAbstractResolver >> resolveUrl: anAbsoluteFileURL [

	^ (self basicResolveUrl: anAbsoluteFileURL)
		ifNil: [ nextResolver resolveUrl: anAbsoluteFileURL ]
]

{ #category : #accessing }
MicAbstractResolver >> resourcesCache [ 
	^ self class resourcesCache
]
