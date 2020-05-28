Extension { #name : #MicAbstractParser }

{ #category : #'*Microdown-RichTextComposer' }
MicAbstractParser class >> asRichText: aString [
	^PRRichTextComposer new start: (MicAbstractParser new parse: aString) asPillar
]

{ #category : #'*Microdown-RichTextComposer' }
MicAbstractParser class >> asText: aString [
	^ PRRichTextComposer new start: (self class new parse: aString) asPillar
]
