Extension { #name : 'Text' }

{ #category : '*Microdown-RichTextComposer' }
Text >> trim [
	| left right |
	left := 1.
	right := self size.
	
	[ left <= right and: [ (self at: left) isSeparator  ] ]
		whileTrue: [ left := left + 1 ].
		
	[ left <= right and: [ (self at: right) isSeparator ] ]
		whileTrue: [ right := right - 1 ].
		
	^ self copyFrom: left to: right
]
