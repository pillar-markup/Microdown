Extension { #name : 'MicAbstractDelimiter' }

{ #category : '*Microdown-Macrodown' }
MicAbstractDelimiter classSide >> applyOn: inlineParser [

	self subclassResponsibility
]

{ #category : '*Microdown-Macrodown' }
MicAbstractDelimiter classSide >> matches: aString [

	^ false
]
