Extension { #name : #BaselineOf }

{ #category : #'*Microdown' }
BaselineOf class >> asMicrodown: aBuilder [
 
	^ String streamContents: [:s |
		s nextPutAll: aBuilder headerMarkup; cr.
		s nextPutAll: aBuilder codeblockMarkup; cr.
		"this is not good, this should be encapsulated"
		s nextPutAll: (self sourceCodeAt: #baseline:); cr.
		s nextPutAll: aBuilder codeblockMarkup; cr.]
]
