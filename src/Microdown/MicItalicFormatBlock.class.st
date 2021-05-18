"
I represent an italic text section. I'm delimited using `_` as in `_italic_` to obtain _italic_.
"
Class {
	#name : #MicItalicFormatBlock,
	#superclass : #MicInlineBlock,
	#category : #'Microdown-ModelInline'
}

{ #category : #'as yet unclassified' }
MicItalicFormatBlock >> closingDelimiter [

 	^ MicItalicDelimiter markup
]

{ #category : #'as yet unclassified' }
MicItalicFormatBlock >> openingDelimiter [

 	^ MicItalicDelimiter markup
]
