Class {
	#name : #MicHTTPResource,
	#superclass : #MicResourceReference,
	#category : #'Microdown-Core'
}

{ #category : #converting }
MicHTTPResource >> asFileReference [

	^ urlOrFileReference asFileReference
]

{ #category : #converting }
MicHTTPResource >> fullName [

	^ urlOrFileReference printString
]

{ #category : #querying }
MicHTTPResource >> query [
	^ urlOrFileReference query
]

{ #category : #resolving }
MicHTTPResource >> resolvedBy: aRoot [

	^ self
]

{ #category : #resolving }
MicHTTPResource >> resolvedBy: aRoot withResolver: aResolver [
	"I'm url resource so I do not care about a root"
	self halt.
	^ (aResolver root isKindOf: ZnUrl)
			ifTrue: [
				"we want to resolve over for example http://github.com/pharo-project...."
				MicHTTPResource new 
								originalString: originalString; 
								url: (aResolver root withRelativeReference: self path) ]
			ifFalse: [ 
				"Now I resolve again a file system... well this is http so I do not care about the resolver"
				self				
				]


]

{ #category : #converting }
MicHTTPResource >> string: aString [

	super string: aString.
	urlOrFileReference := ZnUrlCopy fromString: originalString.
]
