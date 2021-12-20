"
I am a reference to a image or microdown ressource in the image.

I follow the url scheme `pharo:///class/selector/arg1/arg2`. My intended usage is to give access to the many icons in pharo using: `pharo:///Object/iconNamed:/nameOfIcon`.

Examples:
- abstract: ![](pharo:///Object/iconNamed:/abstract) 
- bitbucket: ![](pharo:///Object/iconNamed:/bitbucket)
- thumbsUp: ![](pharo:///Object/iconNamed:/thumbsUp)

## Restictions
- Only class side methods can be invoked
- Only string arguments can be passed
"
Class {
	#name : #MicPharoResourceReference,
	#superclass : #MicAbsoluteResourceReference,
	#category : #'Microdown-Core'
}

{ #category : #'accessing - resources' }
MicPharoResourceReference >> executeUri [
	"I assume the uri to have the form: 'pharo:///class/selector:/arg1/arg2"

	| class selector size args |
	class := (self class environment at: (uri segments first) asSymbol ) class.
	selector:= uri segments second asSymbol.
	args := ( (size :=uri segments size) > 2) 
		ifTrue: [ (uri segments copyFrom: 3 to: size) asArray ] 
		ifFalse: [ #() ].
	^ class perform: selector withArguments: args
]

{ #category : #'accessing - resources' }
MicPharoResourceReference >> loadMicrodown [
	"return an image form from my reference"
	^ self executeUri 
]

{ #category : #'accessing - resources' }
MicPharoResourceReference >> resolveResourceIn: aResolver [

	^ aResolver resolvePharoResource: self
]

{ #category : #accessing }
MicPharoResourceReference >> uri [
	^uri 
]

{ #category : #accessing }
MicPharoResourceReference >> uri: aUri [
	"ZnUrl stores the Class>>name in host"
	uri := aUri 
]
