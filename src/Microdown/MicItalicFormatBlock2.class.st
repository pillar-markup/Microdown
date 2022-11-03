"
I represent an italic text section. I'm delimited using `_` as in `_italic_` to obtain _italic_.
"
Class {
	#name : #MicItalicFormatBlock2,
	#superclass : #MicEvaluatedBlock2,
	#category : #'Microdown-InlineParser'
}

{ #category : #accessing }
MicItalicFormatBlock2 class >> closingDelimiter [

 	^ ItalicMarkup
]

{ #category : #accessing }
MicItalicFormatBlock2 class >> openingDelimiter [

 	^ ItalicMarkup
]

{ #category : #visiting }
MicItalicFormatBlock2 >> accept: aVisitor [
	^ aVisitor visitItalic: self
]
