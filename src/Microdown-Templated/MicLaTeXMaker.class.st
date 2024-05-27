Class {
	#name : 'MicLaTeXMaker',
	#superclass : 'MicAbstractOutputDocumentMaker',
	#category : 'Microdown-Templated',
	#package : 'Microdown-Templated'
}

{ #category : 'accessing' }
MicLaTeXMaker >> basicWriter [ 
	
	^ MicLaTeXWriter new
]

{ #category : 'accessing' }
MicLaTeXMaker >> extension [
	
	^ 'tex'
]
