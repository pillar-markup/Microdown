Class {
	#name : 'MicBlockLevelRawBlock',
	#superclass : 'MicStartStopMarkupBlock',
	#category : 'Microdown',
	#package : 'Microdown'
}

{ #category : 'visiting' }
MicBlockLevelRawBlock >> accept: aVisitor [
	^ aVisitor visitBlockLevelRaw: self
]

{ #category : 'markups' }
MicBlockLevelRawBlock >> lineStartMarkup [

	^ BlockLevelRawOpenerMarkup 
]

{ #category : 'markups' }
MicBlockLevelRawBlock >> lineStopMarkup [

	^ MetaDataClosingBlockMarkup 
]

{ #category : 'printing' }
MicBlockLevelRawBlock >> printOn: aStream [

	aStream nextPutAll: '{{{'.
	aStream nextPutAll: self body.
	aStream nextPutAll: '}}}'
]
