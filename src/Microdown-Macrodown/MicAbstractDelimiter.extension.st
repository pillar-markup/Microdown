Extension { #name : 'MicAbstractDelimiter' }

{ #category : '*Microdown-Macrodown' }
MicAbstractDelimiter class >> applyOn: inlineParser [

	self subclassResponsibility
]

{ #category : '*Microdown-Macrodown' }
MicAbstractDelimiter class >> matches: aString [

	^ false
]
