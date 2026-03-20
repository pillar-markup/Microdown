Class {
	#name : 'MicFigSectTableResult',
	#superclass : 'MicAbstractResult',
	#instVars : [
		'detail'
	],
	#category : 'Microdown-Rules-References',
	#package : 'Microdown-Rules',
	#tag : 'References'
}

{ #category : 'accessing' }
MicFigSectTableResult >> detail [

	^ detail
]

{ #category : 'accessing' }
MicFigSectTableResult >> detail: anObject [

	detail := anObject
]

{ #category : 'accessing' }
MicFigSectTableResult >> explanation [ 
	^ 'Text: "' , micElement bodyString
	, '" in file' , fileReference fullName 
	, ' contains a mistake: ['
	, detail 
	, '] should be capitalized as ['
	, detail capitalized , '].'
]
