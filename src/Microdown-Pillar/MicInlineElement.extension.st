Extension { #name : #MicInlineElement }

{ #category : #'*Microdown-Pillar' }
MicInlineElement >> asPillar [

	| childrenAsPillar |
	childrenAsPillar := self isOnlyChild 
		ifTrue: [ {(PRText new text: self substring )} ] 
		ifFalse: [ children collect: [:e | e asPillar ] ].
	 ^ self associatedPillarClass new
				setChildren: childrenAsPillar;
				yourself
]

{ #category : #'*Microdown-Pillar' }
MicInlineElement >> associatedPillarClass [
	^ self subclassResponsibility
]
