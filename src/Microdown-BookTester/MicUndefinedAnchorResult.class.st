Class {
	#name : 'MicUndefinedAnchorResult',
	#superclass : 'MicAnchorResult',
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'accessing' }
MicUndefinedAnchorResult >> explanation [

	^ 'In file: ', source, ' the anchor ', anchorLabel, 'is undefined.' 
	
]
