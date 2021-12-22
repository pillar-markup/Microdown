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
	class := (self class environment at: uri segments first asSymbol)
		         class.
	selector := uri segments second asSymbol.
	args := (size := uri segments size) > 2
		        ifTrue: [ (uri segments copyFrom: 3 to: size) asArray ]
		        ifFalse: [ #(  ) ].
	^ class perform: selector withArguments: args
]

{ #category : #resolving }
MicPharoResourceReference >> resolveOnCurrentImage [
	
	"I assume the uri to have the form: 'pharo:///class/selector'"

	| class selector size args className theClass theMethod |
	
	className := uri segments first asSymbol.
	theClass := self class environment
		at: className
		ifAbsent: [ ^ MicNotFoundResource resource: self ].
	uri segments size = 1 ifTrue: [ 
		^ MicPharoClassResource on: theClass reference: self ].
	
	selector := uri segments second asSymbol.
	theMethod := (theClass includesSelector: selector)
		ifFalse: [ ^ MicNotFoundResource resource: self ]
		ifTrue: [ theClass >> selector ].
	uri segments size = 2 ifTrue: [ 
		^ MicPharoMethodResource on: theMethod reference: self ].


	"Evaluation of methods not implemented yet.
	Possible ideas to support it in a REST fashion are
	
	- support evaluation with receiver and arguments through query string
	pharo:///class/selector/evaluate?receiver=...&argument1=...
	
	- support senders/implementors queries
	
	pharo:///class/selector/senders
	pharo:///class/selector/implementors
	"
	self notYetImplemented.
		
	args := (size := uri segments size) > 2
		        ifTrue: [ (uri segments copyFrom: 3 to: size) asArray ]
		        ifFalse: [ #(  ) ].
		
	class := (self class environment at: uri segments first asSymbol)
		         class.
	selector := uri segments second asSymbol.
	args := (size := uri segments size) > 2
		        ifTrue: [ (uri segments copyFrom: 3 to: size) asArray ]
		        ifFalse: [ #(  ) ].
	^ class perform: selector withArguments: args
]

{ #category : #'accessing - resources' }
MicPharoResourceReference >> resolveResourceIn: aResolver [

	^ aResolver resolvePharoResource: self
]
