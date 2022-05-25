Extension { #name : #MicAbstractDelimiter }

{ #category : #'*Microdown-MarkdownStrict' }
MicAbstractDelimiter class >> applyOn: inlineParser [

	self subclassResponsibility
]

{ #category : #'*Microdown-MarkdownStrict' }
MicAbstractDelimiter class >> matches: aString [

	^ false
]
