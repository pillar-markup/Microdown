"
Command and environment LaTeX brushes common superclass.
"
Class {
	#name : #MicLaTeXBrush,
	#superclass : #MicExportBrush,
	#category : #'Microdown-LaTeXExporter'
}

{ #category : #accessing }
MicLaTeXBrush >> optParameter: aString [ 
	stream
		<< $[
		<< aString
		<< $]
]

{ #category : #accessing }
MicLaTeXBrush >> parameter: aString [ 
	stream
		<< ${
		<< aString
		<< $}
]
