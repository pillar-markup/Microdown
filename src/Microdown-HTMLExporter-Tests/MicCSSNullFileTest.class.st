"
A MicCSSNullFileTest is a test class for testing the behavior of MicCSSNullFile
"
Class {
	#name : #MicCSSNullFileTest,
	#superclass : #MicCSSFileTest,
	#category : #'Microdown-HTMLExporter-Tests-CSS'
}

{ #category : #running }
MicCSSNullFileTest >> setUp [

	super setUp.
	fileRef := MicCSSNullFile new.
]

{ #category : #test }
MicCSSNullFileTest >> testContents [

	self assert: (fileRef contents isKindOf: String).
	self assert: fileRef contents isEmpty.
]
