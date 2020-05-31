"
I'm the delimiter for strikethrough format.
"
Class {
	#name : #MicStrikeDelimiter,
	#superclass : #MicAbstractDelimiter,
	#category : #'Microdown-Model'
}

{ #category : #accessing }
MicStrikeDelimiter class >> isCloser [
	^ true
]

{ #category : #accessing }
MicStrikeDelimiter class >> markup [
	^ '~'
]

{ #category : #accessing }
MicStrikeDelimiter >> isCloser [
	^ true
]

{ #category : #accessing }
MicStrikeDelimiter >> isOpener [
	^ true
]

{ #category : #accessing }
MicStrikeDelimiter >> markup [
	self flag: #fixme. "do we need it on instance side?"
	^ '~'
]

{ #category : #accessing }
MicStrikeDelimiter >> type [
	^ #strike
]
