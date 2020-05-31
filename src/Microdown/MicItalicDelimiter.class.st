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
	self flag: #fixme. "do we need it on instance side?"
	^ self class markup
]

{ #category : #accessing }
MicItalicDelimiter >> type [
	^ #italic
]
