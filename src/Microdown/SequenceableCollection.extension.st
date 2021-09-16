Extension { #name : #SequenceableCollection }

{ #category : #'*Microdown' }
SequenceableCollection >> splitOnFirst: char [
	| indexOfChar |
	indexOfChar := self indexOf: char.
	indexOfChar = 0 ifTrue: [ ^{self. nil} ].
	^{self copyFrom: 1 to: indexOfChar -1. self copyFrom: indexOfChar +1 to: self size}  
	
]
