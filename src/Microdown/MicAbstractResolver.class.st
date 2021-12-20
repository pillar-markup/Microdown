Class {
	#name : #MicAbstractResolver,
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
MicAbstractResolver class >> cachedImageFromUrl: aUrl [
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
MicAbstractResolver class >> imageCache [
	ImageCache ifNil:[ImageCache := LRUCache new ].
	^ImageCache
]

{ #category : #images }
MicAbstractResolver class >> imageNotCachedBlock: aHandlerBlock [ 
	"If an image is not in the cache, execute this block get an image. 
	Do not store the produced image in the cache."
	ImageNotCachedBlock := aHandlerBlock
]

{ #category : #'class initialization' }
MicAbstractResolver class >> initialize [
	<script>
	ImageCache := nil.
	ImageNotCachedBlock := nil
]

{ #category : #images }
MicAbstractResolver class >> rawImageFrom: aURL [
	[ ^ ZnEasy getImageOfType: (ZnMimeType main: 'image' sub: '*') fromUrl: aURL ]
	on: Exception
	do: [ ^ nil ]
		
]

{ #category : #'accessing - resources' }
MicAbstractResolver >> basicResolveAbsoluteFilePath: anAbsoluteFileURL [

	self subclassResponsibility
]

{ #category : #'accessing - resources' }
MicAbstractResolver >> basicResolvePharoResource: aPharoResource [

	self halt.

	"return an image form from my reference"
	^ aPharoResource executeUri 
]

{ #category : #resolving }
MicAbstractResolver >> basicResolveRelativeReference: aMicRelativeResource [ 
	
	self subclassResponsibility
]

{ #category : #'accessing - resources' }
MicAbstractResolver >> basicResolveUrl: anAbsoluteFileURL [

	self subclassResponsibility
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
