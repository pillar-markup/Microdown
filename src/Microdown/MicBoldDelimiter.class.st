"
I am the delimiter for bold/strong format.
"
Class {
	#name : #MicBoldDelimiter,
	#superclass : #MicAbstractDelimiter,
	#category : #'Microdown-Model'
}

{ #category : #accessing }
MicBoldDelimiter class >> isCloser [
	^ true
]

{ #category : #accessing }
MicBoldDelimiter class >> markup [
	^ '**'
]

{ #category : #accessing }
MicBoldDelimiter >> isCloser [
	^ true
]

{ #category : #accessing }
MicBoldDelimiter >> isOpener [
	^ true
]

{ #category : #accessing }
MicBoldDelimiter >> markup [
	^ '**'
]

{ #category : #accessing }
MicBoldDelimiter >> type [
	^ #bold
]
