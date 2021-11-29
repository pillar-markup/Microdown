"
I am a reference to a image or microdown ressource in the image.

I follow the url scheme `pharo:///class/selector/arg1/arg2`. My intended usage is to give access to the many icons in pharo using: `pharo:///SpPresenter/iconNamed:/nameOfIcon`.

Examples:
- abstract: ![](pharo:///SpPresenter/iconNamed:/abstract) 
- bitbucket: ![](pharo:///SpPresenter/iconNamed:/bitbucket)
- thumbsUp: ![](pharo:///SpPresenter/iconNamed:/thumbsUp)

## Restictions
- Only class side methods can be invoked
- Only string arguments can be passed
"
Class {
	#name : #MicPharoResource,
	#superclass : #MicAbsoluteResource,
	#category : #'Microdown-Core'
}

{ #category : #'accessing - resources' }
MicPharoResource >> executeUri [
	"I assume the uri to have the form: 'pharo:///class/selector:/arg1/arg2"

	| class selector size args |
	class := (self class environment at: (uri segments first) asSymbol ) class.
	selector:= uri segments second asSymbol.
	args := ( (size :=uri segments size) > 2) 
		ifTrue: [ (uri segments copyFrom: 3 to: size) asArray ] 
		ifFalse: [ #() ].
	^ (class lookupSelector:  selector) valueWithReceiver: class arguments: args
]

{ #category : #'accessing - resources' }
MicPharoResource >> loadImage [
	"return an image form from my reference"
	^ self executeUri 
]

{ #category : #'accessing - resources' }
MicPharoResource >> loadMicrodown [
	"return an image form from my reference"
	^ self executeUri 
]

{ #category : #accessing }
MicPharoResource >> uri [
	^uri 
]

{ #category : #accessing }
MicPharoResource >> uri: aUri [
	"ZnUrl stores the Class>>name in host"
	uri := aUri 
]
