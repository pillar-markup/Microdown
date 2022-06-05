Class {
	#name : #MicLinkNameDelimiter,
	#superclass : #MicAbstractDelimiter,
	#category : #'Microdown-Parser'
}

{ #category : #accessing }
MicLinkNameDelimiter class >> associatedTypes [

	^ {  
		self type.
		MicFigureNameOpenerDelimiter type.
	}
]

{ #category : #testing }
MicLinkNameDelimiter class >> isActive [

	^ self ~= MicLinkNameDelimiter
]

{ #category : #accessing }
MicLinkNameDelimiter class >> type [

	^ #linkName
]

{ #category : #dispatching }
MicLinkNameDelimiter >> addInlineBlock: anIndex to: inlineParser [

	inlineParser linkOrFigureProcess: anIndex
]
