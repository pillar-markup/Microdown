"
I am the opener delimiter for raw.
"
Class {
	#name : #MicRawOpenerDelimiter,
	#superclass : #MicAbstractDelimiter,
	#category : #'Microdown-Model'
}

{ #category : #accessing }
MicRawOpenerDelimiter class >> isCloser [
	^ false
]

{ #category : #accessing }
MicRawOpenerDelimiter class >> isOpener [
	^ true
]

{ #category : #accessing }
MicRawOpenerDelimiter class >> markup [
	^ '{{'
]

{ #category : #accessing }
MicRawOpenerDelimiter class >> type [
	^ #raw
]
