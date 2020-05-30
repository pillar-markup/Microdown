"
I am the opener delimiter for figure name.
"
Class {
	#name : #MicFigureNameOpenerDelimiter,
	#superclass : #MicAbstractDelimiter,
	#category : #'Microdown-Model'
}

{ #category : #accessing }
MicFigureNameOpenerDelimiter class >> isCloser [
	^ false
]

{ #category : #accessing }
MicFigureNameOpenerDelimiter class >> markup [
	^ '!['
]

{ #category : #accessing }
MicFigureNameOpenerDelimiter >> isCloser [
	^ false
]

{ #category : #accessing }
MicFigureNameOpenerDelimiter >> isOpener [
	^ true
]

{ #category : #accessing }
MicFigureNameOpenerDelimiter >> markup [
	^ '!['
]

{ #category : #accessing }
MicFigureNameOpenerDelimiter >> type [
	^ #figure
]
