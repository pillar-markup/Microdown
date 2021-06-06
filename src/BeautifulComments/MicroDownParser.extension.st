Extension { #name : #MicroDownParser }

{ #category : #'*BeautifulComments' }
MicroDownParser class >> convertToRichText: aString [
	^ BCRichTextComposer new visit: (self new parse: aString)
]
