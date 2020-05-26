Extension { #name : #MicAbstractBlock }

{ #category : #'*Microdown-Pillar' }
MicAbstractBlock >> splitString: aString [
	"convenience method"
	^GHMIntraBlockSplitter new pillarFrom: aString.
]
