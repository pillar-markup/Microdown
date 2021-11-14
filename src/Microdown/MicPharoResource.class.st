Class {
	#name : #MicPharoResource,
	#superclass : #MicAbsoluteResource,
	#category : #'Microdown-Core'
}

{ #category : #'accessing - resources' }
MicPharoResource >> executeUri [

	"return the result of executing my uri"

	| class selector size args |
	class := (self class environment at: (uri segments first) asSymbol ) class.
	selector:= uri segments second asSymbol.
	args := ( (size :=uri segments size) > 2) 
		ifTrue: [ (uri segments copyFrom: 3 to: size) asArray ] 
		ifFalse: [ #() ].
	^ (class compiledMethodAt: selector) valueWithReceiver: class arguments: args
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
