Extension { #name : #MicAbstractBlock }

{ #category : #'*Microdown-Pillar' }
MicAbstractBlock >> splitString: aString [
	"convenience method"
	^MicIntraBlockSplitter new pillarFrom: aString.
]
