"
I am the opener delimiter for link name.
"
Class {
	#name : #MicLinkNameOpenerDelimiter,
	#superclass : #MicLinkNameDelimiter,
	#category : #'Microdown-Parser'
}

{ #category : #accessing }
MicLinkNameOpenerDelimiter class >> associatedInlineBlock [
	^ MicLinkBlock 
]

{ #category : #accessing }
MicLinkNameOpenerDelimiter class >> isCloser [
	^ false
]

{ #category : #accessing }
MicLinkNameOpenerDelimiter class >> isOpener [
	^ true
]

{ #category : #accessing }
MicLinkNameOpenerDelimiter class >> markup [
	^ LinkNameOpenerMarkup
]
