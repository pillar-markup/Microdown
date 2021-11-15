"
I should not be necessary.
"
Class {
	#name : #MicBrokenResource,
	#superclass : #MicResourceReference,
	#category : #'Microdown-Core'
}

{ #category : #converting }
MicBrokenResource >> asFileReference [

	^ self error
]

{ #category : #testing }
MicBrokenResource >> isResolved [ 
	^ false
]

{ #category : #accessing }
MicBrokenResource >> path [
	^originalString  
]
