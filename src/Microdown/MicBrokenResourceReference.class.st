"
I should not be necessary.
"
Class {
	#name : #MicBrokenResourceReference,
	#superclass : #MicResourceReference,
	#category : #'Microdown-Core'
}

{ #category : #converting }
MicBrokenResourceReference >> asFileReference [

	^ self error
]

{ #category : #testing }
MicBrokenResourceReference >> isResolved [ 
	^ false
]

{ #category : #accessing }
MicBrokenResourceReference >> path [
	^originalString  
]
