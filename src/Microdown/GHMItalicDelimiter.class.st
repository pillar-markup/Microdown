"
I am the delimiter for italic/emphasis format.
"
Class {
	#name : #GHMItalicDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'Microdown-Model - inline'
}

{ #category : #accessing }
GHMItalicDelimiter >> isCloser [
	^ true
]

{ #category : #accessing }
GHMItalicDelimiter >> isOpener [
	^ true
]

{ #category : #accessing }
GHMItalicDelimiter >> markup [
	^ '_'
]

{ #category : #accessing }
GHMItalicDelimiter >> type [
	^ #italic
]
