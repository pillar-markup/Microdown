"
I am the closer delimiter for URL.
"
Class {
	#name : #MicURLCloserDelimiter,
	#superclass : #MicAbstractDelimiter,
	#category : #'Microdown-Model'
}

{ #category : #testing }
MicURLCloserDelimiter class >> isActive [
	^ false
]

{ #category : #accessing }
MicURLCloserDelimiter class >> isCloser [
	^ true
]

{ #category : #accessing }
MicURLCloserDelimiter class >> isOpener [
	^ false
]

{ #category : #accessing }
MicURLCloserDelimiter class >> markup [
	^ ')'
]

{ #category : #accessing }
MicURLCloserDelimiter class >> type [
	^ #url
]
