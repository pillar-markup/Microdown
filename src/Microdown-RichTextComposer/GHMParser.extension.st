Extension { #name : #GHMParser }

{ #category : #'*Microdown-RichTextComposer' }
GHMParser class >> asRichText: aString [
	^PRRichTextComposer new start: (GHMParser new parse: aString) asPillar
]

{ #category : #'*Microdown-RichTextComposer' }
GHMParser class >> asText: aString [
	^PRRichTextComposer new start: (GHMParser new parse: aString) asPillar
]
