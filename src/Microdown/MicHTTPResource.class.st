"
I am a http reference encapsulating a http uri (`http//host/path/to/some/file.md`).


"
Class {
	#name : #MicHTTPResource,
	#superclass : #MicAbsoluteResource,
	#classVars : [
		'ImageCache',
		'ImageNotCachedBlock'
	],
	#category : #'Microdown-Core'
}

{ #category : #images }
MicHTTPResource class >> cachedImageFromUrl: aUrl [
	"In case a url is not in the cache, it is either read from the net, or if the ImageNotCachedBlock
	is non nil, the image returned by ImageNotCachedBlock is returned, but not stored in the cache"
	
	(self imageCache includesKey: aUrl)
		ifTrue: [ ^ self imageCache at: aUrl ].
		
	ImageNotCachedBlock 
		ifNil: [
			^ self imageCache at: aUrl put: ((self rawImageFrom: aUrl) ifNil: [ ^nil ])]
		ifNotNil: [ 
			^ ImageNotCachedBlock value]
]

{ #category : #accessing }
MicHTTPResource class >> imageAt: urlString put: aForm [	
	"the cache contains results of for example ZnEasy getPng:, i.e., a form"
	
	ImageCache at: urlString put: aForm
]

{ #category : #images }
MicHTTPResource class >> imageCache [
	ImageCache ifNil:[ImageCache := LRUCache new ].
	^ImageCache
]

{ #category : #images }
MicHTTPResource class >> imageNotCachedBlock: aHandlerBlock [ 
	"If an image is not in the cache, execute this block get an image. 
	Do not store the produced image in the cache."
	ImageNotCachedBlock := aHandlerBlock
]

{ #category : #images }
MicHTTPResource class >> imageNotCachedValue [
	ImageNotCachedBlock ifNil: [ ^ nil ].
	^ ImageNotCachedBlock value
]

{ #category : #'class initialization' }
MicHTTPResource class >> initialize [
	<script>
	ImageCache := nil.
	ImageNotCachedBlock := nil
]

{ #category : #images }
MicHTTPResource class >> rawImageFrom: aURL [
	[ ^ ZnEasy getImageOfType: (ZnMimeType main: 'image' sub: '*') fromUrl: aURL ]
	on: Error
	do: [ ^nil ]
		
]

{ #category : #'accessing - resources' }
MicHTTPResource >> loadImage [
	"return an image form from my reference"
	^ self class cachedImageFromUrl: uri asString
]

{ #category : #'accessing - resources' }
MicHTTPResource >> loadMicrodown [
	"load, parse and resolve a microdown document"
	| docString doc |
	[ docString := (ZnEasy get: uri) contents.
	  doc := Microdown new parse: docString.
	  MicZinkPathResolver resolve: doc withBase: uri.
	  ^doc]
	on: Error
	do: [ ^ nil ]
]
