"
I am the closer delimiter for link name.
"
Class {
	#name : 'MicLinkNameCloserDelimiter',
	#superclass : 'MicLinkNameDelimiter',
	#category : 'Microdown-Parser',
	#package : 'Microdown',
	#tag : 'Parser'
}

{ #category : 'accessing' }
MicLinkNameCloserDelimiter class >> associatedInlineBlock [
	^ nil
]

{ #category : 'accessing' }
MicLinkNameCloserDelimiter class >> isCloser [
	^ true
]

{ #category : 'accessing' }
MicLinkNameCloserDelimiter class >> isOpener [
	^ false
]

{ #category : 'accessing' }
MicLinkNameCloserDelimiter class >> markup [
	^ LinkNameCloserMarkup
]
