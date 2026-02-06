Class {
	#name : 'MicTHTMLDocumentMaker',
	#superclass : 'MicAbstractOutputDocumentMaker',
	#category : 'Microdown-Templated',
	#package : 'Microdown-Templated'
}

{ #category : 'accessing' }
MicTHTMLDocumentMaker >> basicWriter [

	^ MicHTMLVisitor new
]

{ #category : 'accessing' }
MicTHTMLDocumentMaker >> extension [

	^ 'html'
]
