Extension { #name : #GHMAbstractBlock }

{ #category : #'*Microdown-Pillar' }
GHMAbstractBlock >> splitString: aString [
	"convenience method"
	^GHMIntraBlockSplitter new pillarFrom: aString.
]
