Extension { #name : 'MicAnchorBlock' }

{ #category : '*Microdown-ReferenceChecker' }
MicAnchorBlock >> isAnchor [
    "Check if this node is a kind of MicAnchorBlock"
    ^ self isKindOf: MicAnchorBlock
]
