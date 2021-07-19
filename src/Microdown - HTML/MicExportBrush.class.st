Class {
	#name : #MicExportBrush,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'Microdown - HTML'
}

{ #category : #initialization }
MicExportBrush >> setStream: aStream [
	stream := aStream
]
