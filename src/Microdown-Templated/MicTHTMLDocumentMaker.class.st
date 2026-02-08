Class {
	#name : 'MicTHTMLDocumentMaker',
	#superclass : 'MicAbstractOutputDocumentMaker',
	#category : 'Microdown-Templated',
	#package : 'Microdown-Templated'
}

{ #category : 'accessing' }
MicTHTMLDocumentMaker class >> writerName [
	^ #micTemplatedHtml
]

{ #category : 'accessing' }
MicTHTMLDocumentMaker >> basicWriter [

	^ MicHTMLVisitor new
]

{ #category : 'accessing' }
MicTHTMLDocumentMaker >> extension [

	^ 'html'
]

{ #category : 'accessing' }
MicTHTMLDocumentMaker >> folderName [
	
	^ 'html'
]

{ #category : 'writing' }
MicTHTMLDocumentMaker >> write: aDocument [
	"Pillar API Let talk to the templatedWriter"
	
	| templatedWriter |
	templatedWriter := self writer.
	templatedWriter write: aDocument.
	^ templatedWriter contents
]
