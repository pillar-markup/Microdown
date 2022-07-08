Class {
	#name : #MicScriptBlock,
	#superclass : #MicEnvironmentBlock,
	#category : #'Microdown-Extensions'
}

{ #category : #accessing }
MicScriptBlock class >> tag [

	^ #script
]

{ #category : #visiting }
MicScriptBlock >> accept: aVisitor [
	^ aVisitor visitScript: self
]

{ #category : #accessing }
MicScriptBlock >> title [
	^ arguments at: 'title' ifAbsent: [ '' ]
]
