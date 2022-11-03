Extension { #name : #MicInlineBlockWithUrl2 }

{ #category : #'*Microdown-LaTeXExporter' }
MicInlineBlockWithUrl2 >> fileStringWithoutHostFile [
	| urlString localFileIndicator |
	urlString := url asString.
	localFileIndicator := 'file://'.
	^ (urlString beginsWith: localFileIndicator)
			ifTrue: [ urlString allButFirst: localFileIndicator size ]
			ifFalse: [ urlString ]
]

{ #category : #'*Microdown-LaTeXExporter' }
MicInlineBlockWithUrl2 >> fullName [

	^ reference fullName
]

{ #category : #'*Microdown-LaTeXExporter' }
MicInlineBlockWithUrl2 >> hasCaption [

	^ children notEmpty
]
