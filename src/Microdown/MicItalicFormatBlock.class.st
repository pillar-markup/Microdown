"
I represent an italic text section. I'm delimited using `_` as in `_italic_` to obtain _italic_.
"
Class {
	#name : 'MicItalicFormatBlock',
	#superclass : 'MicEvaluatedBlock',
	#category : 'Microdown-InlineParser',
	#package : 'Microdown',
	#tag : 'InlineParser'
}

{ #category : 'accessing' }
MicItalicFormatBlock class >> closingDelimiter [

 	^ ItalicMarkup
]

{ #category : 'accessing' }
MicItalicFormatBlock class >> openingDelimiter [

 	^ ItalicMarkup
]

{ #category : 'visiting' }
MicItalicFormatBlock >> accept: aVisitor [
	^ aVisitor visitItalic: self
]
