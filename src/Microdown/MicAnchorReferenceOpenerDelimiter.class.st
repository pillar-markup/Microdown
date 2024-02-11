"
An anchor reference represents a reference to a section, figure, environment. It follows the pattern `*@`, label, `@*`

```
See *@fig1@*
```
"
Class {
	#name : 'MicAnchorReferenceOpenerDelimiter',
	#superclass : 'MicAbstractDelimiter',
	#category : 'Microdown-Parser',
	#package : 'Microdown',
	#tag : 'Parser'
}

{ #category : 'accessing' }
MicAnchorReferenceOpenerDelimiter class >> associatedInlineBlock [
	^ MicAnchorReferenceBlock 
]

{ #category : 'accessing' }
MicAnchorReferenceOpenerDelimiter class >> isCloser [
	^ false
]

{ #category : 'accessing' }
MicAnchorReferenceOpenerDelimiter class >> isOpener [
	^ true
]

{ #category : 'accessing' }
MicAnchorReferenceOpenerDelimiter class >> markup [
	^ AnchorReferenceOpenerMarkup
]

{ #category : 'accessing' }
MicAnchorReferenceOpenerDelimiter class >> type [
	^ #anchorReference
]
