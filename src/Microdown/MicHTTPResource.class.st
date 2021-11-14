Class {
	#name : #MicHTTPResource,
	#superclass : #MicAbsoluteResource,
	#category : #'Microdown-Core'
}

{ #category : #'accessing - resources' }
MicHTTPResource >> loadImage [
	"return an image form from my reference"
	[ ^ ZnEasy getPng: uri ]
		on: Error
		do: [ ^ nil ]
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
