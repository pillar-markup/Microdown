Extension { #name : 'MicParser' }

{ #category : '*Microdown-RichTextComposer' }
MicParser class >> convertToRichText: aString [
	^ MicRichTextComposer new visit: (self new parse: aString)
]
