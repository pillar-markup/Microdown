Extension { #name : #MicrodownParser }

{ #category : #'*Microdown-RichTextComposer' }
MicrodownParser class >> convertToRichText: aString [
	^ MicRichTextComposer new visit: (self new parse: aString)
]
