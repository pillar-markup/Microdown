Extension { #name : #GHMIntraBlockSplitter }

{ #category : #'*Microdown-Pillar' }
GHMIntraBlockSplitter >> pillarFrom: aString [
	"return a collection of pillar nodes which can be used in setChildren: of the owner of aString"
	^ (self splitString: aString) collect: [ :node | node asPillar ]
]
