"
I am an experiment in making a multi line comment with the body preserved.
"
Class {
	#name : #MicMultilineComment,
	#superclass : #MicMathBlock,
	#category : #'Microdown-DocumentBrowser-BlockModel'
}

{ #category : #accessing }
MicMultilineComment class >> tag [
	^#comment
]

{ #category : #visiting }
MicMultilineComment >> accept: vistitor [
]
