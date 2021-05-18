Extension { #name : #MicInlineBlock }

{ #category : #'*Microdown-Pillar' }
MicInlineBlock >> asPillar [

	| childrenAsPillar |
	childrenAsPillar := self isOnlyChild 
		ifTrue: [ {(PRText new text: self substring )} ] 
		ifFalse: [ children collect: [:e | e asPillar ] ].
	 ^ self associatedPillarClass new
				setChildren: childrenAsPillar;
				yourself
]

{ #category : #'*Microdown-Pillar' }
MicInlineBlock >> associatedPillarClass [
	^ self subclassResponsibility
]
