"
templater := MicTemplatedWriter new 
	outputDocument: (MicHTMLMaker new
		baseDirectory: FileSystem workingDirectory; yourself).
templater visit: (Microdown parse: '**BOLD BOLD**') children first children first.
templater 
"
Class {
	#name : #MicHTMLMaker,
	#superclass : #MicAbstractOutputDocumentMaker,
	#category : #'Microdown-Templated'
}

{ #category : #accessing }
MicHTMLMaker >> basicWriter [ 
	
	^ MicHTMLVisitor new
]

{ #category : #accessing }
MicHTMLMaker >> extension [
	
	^ 'html'
]
