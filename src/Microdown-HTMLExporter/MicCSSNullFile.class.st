"
A special type of Microdown CSS file with contents empty.
"
Class {
	#name : 'MicCSSNullFile',
	#superclass : 'MicCSSFile',
	#category : 'Microdown-HTMLExporter-CSS',
	#package : 'Microdown-HTMLExporter',
	#tag : 'CSS'
}

{ #category : 'accessing' }
MicCSSNullFile >> contents [
	"Answer a <String> with the receiver's source code"
	
	^ String empty
]
