"
I'm the opener delimiter for URL.
"
Class {
	#name : #MicURLOpenerDelimiter,
	#superclass : #MicAbstractDelimiter,
	#category : #'Microdown-Model'
}

{ #category : #testing }
MicURLOpenerDelimiter class >> isActive [
	^ false
]

{ #category : #accessing }
MicURLOpenerDelimiter class >> isCloser [
	^ false
]

{ #category : #accessing }
MicURLOpenerDelimiter class >> markup [
	^ '('
]

{ #category : #testing }
MicURLOpenerDelimiter >> isActive [
	^ false
]

{ #category : #accessing }
MicURLOpenerDelimiter >> isCloser [
	^ false
]

{ #category : #accessing }
MicURLOpenerDelimiter >> isOpener [
	^ true
]

{ #category : #accessing }
MicURLOpenerDelimiter >> markup [
	self flag: #fixme. "do we need it on instance side?"
	^ '('
]

{ #category : #accessing }
MicURLOpenerDelimiter >> type [
	^ #url
]
