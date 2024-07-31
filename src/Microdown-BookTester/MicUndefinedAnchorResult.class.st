Class {
	#name : 'MicUndefinedAnchorResult',
	#superclass : 'MicResult',
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'accessing' }
MicUndefinedAnchorResult >> explanation [

	^ 'In file: ', source, ' the anchor ', anchorLabel, 'is undefined.' 
	
]
