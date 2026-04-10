Class {
	#name : 'MicTextDocumentMaker',
	#superclass : 'MicAbstractOutputDocumentMaker',
	#category : 'Microdown-Templated',
	#package : 'Microdown-Templated'
}

{ #category : 'accessing' }
MicTextDocumentMaker class >> writerName [
	^ #micTemplatedText
]

{ #category : 'accessing' }
MicTextDocumentMaker >> basicWriter [

	^ MicTextualMicrodownExporter new
]

{ #category : 'accessing' }
MicTextDocumentMaker >> extension [

	^ 'md'
]
