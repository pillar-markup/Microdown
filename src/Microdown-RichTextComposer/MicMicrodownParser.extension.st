Extension { #name : #MicMicrodownParser }

{ #category : #'*Microdown-RichTextComposer' }
MicMicrodownParser class >> asRichText: aString [
	^PRRichTextComposer new start: (MicMicrodownParser new parse: aString) asPillar
]

{ #category : #'*Microdown-RichTextComposer' }
MicMicrodownParser class >> asText: aString [
	^ PRRichTextComposer new start: (self new parse: aString) asPillar
]
