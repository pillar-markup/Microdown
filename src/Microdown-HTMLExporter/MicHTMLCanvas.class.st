Class {
	#name : #MicHTMLCanvas,
	#superclass : #MicExportCanvas,
	#category : #'Microdown-HTMLExporter'
}

{ #category : #accessing }
MicHTMLCanvas >> tag [
	^ self brush: MicHTMLTag new
]
