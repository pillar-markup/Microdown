"
A code reference is a reference to a package, class, method in Pharo.
For example: **\@Point class >> #setX:setY\@**
"
Class {
	#name : #MicCodeReferenceDelimiter,
	#superclass : #MicAbstractDelimiter,
	#category : #'Microdown-ModelInline'
}

{ #category : #accessing }
MicCodeReferenceDelimiter class >> associatedInlineBlock [
	^ MicCodeReferenceInlineBlock
]

{ #category : #accessing }
MicCodeReferenceDelimiter class >> isCloser [
	^ true
]

{ #category : #accessing }
MicCodeReferenceDelimiter class >> isOpener [
	^ true
]

{ #category : #accessing }
MicCodeReferenceDelimiter class >> markup [
	^ '@'
]

{ #category : #accessing }
MicCodeReferenceDelimiter class >> type [
	^ #codeReference
]
