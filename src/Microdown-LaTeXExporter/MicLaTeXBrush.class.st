"
Command and environment LaTeX brushes common superclass.
"
Class {
	#name : 'MicLaTeXBrush',
	#superclass : 'MicExportBrush',
	#category : 'Microdown-LaTeXExporter',
	#package : 'Microdown-LaTeXExporter'
}

{ #category : 'accessing' }
MicLaTeXBrush >> optParameter: aStringOrBlock [
	stream
		<< $[
		<< aStringOrBlock
		<< $]
]

{ #category : 'accessing' }
MicLaTeXBrush >> parameter: aStringOrBlock [
	stream
		<< ${
		<< aStringOrBlock
		<< $}
]
