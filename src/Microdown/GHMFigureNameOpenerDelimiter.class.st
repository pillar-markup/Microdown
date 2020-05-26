"
I am the opener delimiter for figure name.
"
Class {
	#name : #GHMFigureNameOpenerDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'Microdown-Model - inline'
}

{ #category : #accessing }
GHMFigureNameOpenerDelimiter >> isCloser [
	^ false
]

{ #category : #accessing }
GHMFigureNameOpenerDelimiter >> isOpener [
	^ true
]

{ #category : #accessing }
GHMFigureNameOpenerDelimiter >> markup [
	^ '!['
]

{ #category : #accessing }
GHMFigureNameOpenerDelimiter >> type [
	^ #figure
]
