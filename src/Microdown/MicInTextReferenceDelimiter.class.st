"
A in text reference is a reference that you can add to element of your text to refer to another elements. In Pillar it was `\*\@label\*`. 
In Microdown, we have `@label@`.
"
Class {
	#name : #MicInTextReferenceDelimiter,
	#superclass : #MicAbstractDelimiter,
	#category : #'Microdown-ModelInline'
}

{ #category : #accessing }
MicInTextReferenceDelimiter class >> associatedInlineBlock [
	^ MicCodeReferenceInlineBlock
]

{ #category : #accessing }
MicInTextReferenceDelimiter class >> isCloser [
	^ true
]

{ #category : #accessing }
MicInTextReferenceDelimiter class >> isOpener [
	^ true
]

{ #category : #accessing }
MicInTextReferenceDelimiter class >> markup [
	^ '@'
]

{ #category : #accessing }
MicInTextReferenceDelimiter class >> type [
	^ #codeReference
]
