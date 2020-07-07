Extension { #name : #MicAbstractBlock }

{ #category : #'*Microdown-Pillar' }
MicAbstractBlock >> pillarFromString: aString [
	
	^ MicInlineSplitterOld new pillarFrom: aString
]
