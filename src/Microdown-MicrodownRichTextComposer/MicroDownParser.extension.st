Extension { #name : #MicroDownParser }

{ #category : #'*Microdown-MicrodownRichTextComposer' }
MicroDownParser class >> convertToRichText: aString [
	^ MicRichTextComposer new visit: (self new parse: aString)
]
