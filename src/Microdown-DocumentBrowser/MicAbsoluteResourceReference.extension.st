Extension { #name : #MicAbsoluteResourceReference }

{ #category : #'*Microdown-DocumentBrowser' }
MicAbsoluteResourceReference >> browserIcon [
	^ self iconNamed: #book
]

{ #category : #'*Microdown-DocumentBrowser' }
MicAbsoluteResourceReference >> browserTitle [
	^ self uri segments 
		ifNotNil:[:seg | (seg last: (seg size min: 3)) joinUsing: '/']
		ifNil: [ self uri printString ]
]
