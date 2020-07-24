Extension { #name : #MicAbstractInlineBlock }

{ #category : #'*Microdown-Pillar' }
MicAbstractInlineBlock >> asPillar [

	| childrenAsPillar |
	childrenAsPillar := self isOnlyChild 
		ifTrue: [ {(PRText new text: self substring )} ] 
		ifFalse: [ children collect: [:e | e asPillar ] ].
	self class hasAssociatedPillarClass
		ifTrue: [ ^ self class associatedPillarClass new
				setChildren: childrenAsPillar;
				yourself]
]

{ #category : #'*Microdown-Pillar' }
MicAbstractInlineBlock class >> associatedPillarClass [
	"When the class has a direct associated pillar class,
	hasAssociatedPillarClass should return true and this 
	method should return the class."
	
	"This method is not defined as abstract because some classes do not have a direct class.
	and require. A solution would be to move this prototocol to instance side because 
	we have the information."
]

{ #category : #'*Microdown-Pillar' }
MicAbstractInlineBlock class >> hasAssociatedPillarClass [
	^ true
]
