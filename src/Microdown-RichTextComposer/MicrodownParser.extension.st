Extension { #name : 'MicrodownParser' }

{ #category : '*Microdown-RichTextComposer' }
MicrodownParser classSide >> convertToRichText: aString [
	^ MicRichTextComposer new visit: (self new parse: aString)
]
