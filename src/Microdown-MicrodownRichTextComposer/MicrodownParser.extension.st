Extension { #name : #MicrodownParser }

{ #category : #'*Microdown-MicrodownRichTextComposer' }
MicrodownParser class >> convertToRichText: aString [
	^ MicRichTextComposer new visit: (self new parse: aString)
]
