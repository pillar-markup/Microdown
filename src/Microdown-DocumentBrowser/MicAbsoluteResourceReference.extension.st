Extension { #name : #MicAbsoluteResourceReference }

{ #category : #'*Microdown-DocumentBrowser' }
MicAbsoluteResourceReference >> browserIcon [
	^ self iconNamed: #book
]

{ #category : #'*Microdown-DocumentBrowser' }
MicAbsoluteResourceReference >> browserTitle [
	| title slashes |
	title := self uriString.
	slashes := title allRangesOfSubstring: '/'.
	slashes size <= 3 ifTrue: [ ^ title ].
	^ '...', (title 
		copyFrom: (slashes at: (slashes size - 2)) first
		to: title size)
]
