"
I am the delimiter for italic/emphasis format.
"
Class {
	#name : #MicItalicDelimiter,
	#superclass : #MicAbstractDelimiter,
	#category : #'Microdown-Model'
}

{ #category : #accessing }
MicItalicDelimiter class >> isCloser [
	^ true
]

{ #category : #accessing }
MicItalicDelimiter class >> markup [
	^ '_'
]

{ #category : #accessing }
MicItalicDelimiter >> isCloser [
	^ true
]

{ #category : #accessing }
MicItalicDelimiter >> isOpener [
	^ true
]

{ #category : #accessing }
MicItalicDelimiter >> markup [
	^ '_'
]

{ #category : #accessing }
MicItalicDelimiter >> type [
	^ #italic
]
