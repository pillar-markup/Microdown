Class {
	#name : #MicFullResolver,
	#superclass : #Object,
	#instVars : [
		'nextResolver'
	],
	#classVars : [
		'ImageCache',
		'ImageNotCachedBlock'
	],
	#category : #'Microdown-Core'
}

{ #category : #images }
MicFullResolver class >> cachedImageFromUrl: aUrl [
	"In case a url is not in the cache, it is either read from the net, or if the ImageNotCachedBlock
	is non nil, the image returned by ImageNotCachedBlock is returned, but not stored in the cache"
	
	(self imageCache includesKey: aUrl)
		ifTrue: [ ^ self imageCache at: aUrl ].
	
	^ ImageNotCachedBlock 
		ifNil: [ |image|
			image := self rawImageFrom: aUrl.
			image ifNil: [ ^ nil ].
			"at: aUrl put: image retuns image!"
			self imageCache at: aUrl put: image]
		ifNotNil: [ 
			ImageNotCachedBlock value: aUrl]
]

{ #category : #images }
MicFullResolver class >> imageCache [
	ImageCache ifNil:[ImageCache := LRUCache new ].
	^ImageCache
]

{ #category : #images }
MicFullResolver class >> imageNotCachedBlock: aHandlerBlock [ 
	"If an image is not in the cache, execute this block get an image. 
	Do not store the produced image in the cache."
	ImageNotCachedBlock := aHandlerBlock
]

{ #category : #'class initialization' }
MicFullResolver class >> initialize [
	<script>
	ImageCache := nil.
	ImageNotCachedBlock := nil
]

{ #category : #images }
MicFullResolver class >> rawImageFrom: aURL [
	[ ^ ZnEasy getImageOfType: (ZnMimeType main: 'image' sub: '*') fromUrl: aURL ]
	on: Exception
	do: [ ^ nil ]
		
]

{ #category : #'accessing - resources' }
MicFullResolver >> basicResolveAbsoluteFilePath: anAbsoluteFileURL [

	self halt.
]

{ #category : #'accessing - resources' }
MicFullResolver >> basicResolvePharoResource: aPharoResource [

	self halt.

	"return an image form from my reference"
	^ aPharoResource executeUri 
]

{ #category : #resolving }
MicFullResolver >> basicResolveRelativeUrl: aMicRelativeResource [ 
	
	self subclassResponsibility
]

{ #category : #'accessing - resources' }
MicFullResolver >> basicResolveUrl: anAbsoluteFileURL [

	self subclassResponsibility
]

{ #category : #accessing }
MicFullResolver >> nextResolver: aMicDefaultResolver [ 
	
	nextResolver := aMicDefaultResolver
]

{ #category : #'accessing - resources' }
MicFullResolver >> resolveAbsoluteFilePath: anAbsoluteFileURL [

	^ (self basicResolveAbsoluteFilePath: anAbsoluteFileURL)
		ifNil: [ nextResolver resolveAbsoluteFilePath: anAbsoluteFileURL ]
]

{ #category : #'accessing - resources' }
MicFullResolver >> resolvePharoResource: aPharoResource [

	^ (self basicResolvePharoResource: aPharoResource)
		ifNil: [ nextResolver resolvePharoResource: aPharoResource ]
]

{ #category : #'accessing - resources' }
MicFullResolver >> resolveRelativeUrl: anAbsoluteFileURL [

	^ (self basicResolveRelativeUrl: anAbsoluteFileURL)
		ifNil: [ nextResolver resolveRelativeUrl: anAbsoluteFileURL ]
]

{ #category : #'accessing - resources' }
MicFullResolver >> resolveUrl: anAbsoluteFileURL [

	^ (self basicResolveUrl: anAbsoluteFileURL)
		ifNil: [ nextResolver resolveUrl: anAbsoluteFileURL ]
]
