Extension { #name : #MicFileResourceReference }

{ #category : #'*Microdown-DocumentBrowser' }
MicFileResourceReference >> browserIcon [ 
	^ self isDirectory 
		ifTrue: [ self iconNamed: #packageColored]
		ifFalse: [ self iconNamed: #smallLeftFlush ]
]
