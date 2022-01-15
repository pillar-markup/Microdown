Extension { #name : #MicroDownParser }

{ #category : #'*Microdown-RichTextComposer' }
MicroDownParser classSide >> convertToRichText: aString [
	^ MicRichTextComposer new visit: (self new parse: aString)
]
