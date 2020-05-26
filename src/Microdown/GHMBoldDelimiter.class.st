"
I am the delimiter for bold/strong format.
"
Class {
	#name : #GHMBoldDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'Microdown-Model - inline'
}

{ #category : #accessing }
GHMBoldDelimiter >> isCloser [
	^ true
]

{ #category : #accessing }
GHMBoldDelimiter >> isOpener [
	^ true
]

{ #category : #accessing }
GHMBoldDelimiter >> markup [
	^ '**'
]

{ #category : #accessing }
GHMBoldDelimiter >> type [
	^ #bold
]
