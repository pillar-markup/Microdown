"
I'm an abstract brush dedicated to HTML documents. As of today, the only subclass is the tag brush but we can imagine others (e.g., to write HTML comments).
"
Class {
	#name : #MicHTMLBrush,
	#superclass : #MicExportBrush,
	#instVars : [
		'name'
	],
	#category : #'Microdown-HTMLExporter'
}

{ #category : #accessing }
MicHTMLBrush >> name [
	"Answer a <String> with the receiver's name"
	
	^ name
]

{ #category : #accessing }
MicHTMLBrush >> name: aString [
	name := aString.
	stream nextPut: $<; << aString
]
