Extension { #name : #MicInlineBlockWithUrl }

{ #category : #'*Microdown-LaTeXExporter' }
MicInlineBlockWithUrl >> fileStringWithoutHostFile [
	| urlString localFileIndicator |
	urlString := url asString.
	localFileIndicator := 'file://'.
	^ (urlString beginsWith: localFileIndicator)
			ifTrue: [ urlString allButFirst: localFileIndicator size ]
			ifFalse: [ urlString ]
]

{ #category : #'*Microdown-LaTeXExporter' }
MicInlineBlockWithUrl >> fullName [

	^ reference fullName
]

{ #category : #'*Microdown-LaTeXExporter' }
MicInlineBlockWithUrl >> hasCaption [

	^ children notEmpty
]
