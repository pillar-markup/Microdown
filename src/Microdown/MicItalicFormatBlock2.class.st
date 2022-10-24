"
I represent an italic text section. I'm delimited using `_` as in `_italic_` to obtain _italic_.
"
Class {
	#name : #MicItalicFormatBlock2,
	#superclass : #MicEvaluatedBlock2,
	#category : #'Microdown-InlineParser'
}

{ #category : #visiting }
MicItalicFormatBlock2 >> accept: aVisitor [
	^ aVisitor visitItalic: self
]
