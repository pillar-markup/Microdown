Class {
	#name : 'MicWrongReferenceToFigSectTableAnchorResult',
	#superclass : 'MicAbstractResult',
	#instVars : [
		'detail'
	],
	#category : 'Microdown-Rules-AnchoredReferences',
	#package : 'Microdown-Rules',
	#tag : 'AnchoredReferences'
}

{ #category : 'accessing' }
MicWrongReferenceToFigSectTableAnchorResult >> detail [

	^ detail
]

{ #category : 'accessing' }
MicWrongReferenceToFigSectTableAnchorResult >> detail: anObject [

	detail := anObject
]

{ #category : 'accessing' }
MicWrongReferenceToFigSectTableAnchorResult >> explanation [ 
	| words expected |
	words := detail substrings.
	
	expected := words size = 1 
		ifTrue: [ words first capitalized ]
		ifFalse: [ words first , ' ' , words last capitalized ].
		
	^ 'Text: "' , micElement bodyString
	, '" in file' , fileReference fullName 
	, ' contains a mistake: ['
	, detail 
	, '] should be capitalized as ['
	, expected , '].'
]
