Extension { #name : 'MicAbstractBlock' }

{ #category : '*Microdown-Pillar' }
MicAbstractBlock >> pillarFrom: aCollectionOfMicElements [
	
	^ aCollectionOfMicElements collect: [ :e | e accept: MicMicrodownObjectToPillarObjectConverter new ]
]

{ #category : '*Microdown-Pillar' }
MicAbstractBlock >> pillarFromString: aString [
	
	^ MicInlineParser new pillarFrom: aString
]
