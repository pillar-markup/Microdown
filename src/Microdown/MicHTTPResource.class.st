"
I am a http reference encapsulating a http uri (`http//host/path/to/some/file.md`).


"
Class {
	#name : #MicHTTPResource,
	#superclass : #MicAbsoluteResource,
	#classVars : [
		'ImageCache'
	],
	#category : #'Microdown-Core'
}

{ #category : #images }
MicHTTPResource class >> cachedImageFromUrl: aUrl [
	
	^ self imageCache 
		at: aUrl
		ifAbsentPut: [ (self rawImageFrom: aUrl) ifNil: [ ^ nil ] ] 
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
MicHTTPResource class >> initialize [
	<script>
	ImageCache := nil
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
