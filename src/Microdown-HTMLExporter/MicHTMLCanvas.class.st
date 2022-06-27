Class {
	#name : #MicHTMLCanvas,
	#superclass : #MicExportCanvas,
	#category : #'Microdown-HTMLExporter-Core'
}

{ #category : #accessing }
MicHTMLCanvas >> tag [
	^ self brush: MicHTMLTag new
]
