"
I represent an italic text section. I'm delimited using `_` as in `_italic_` to obtain _italic_.
"
Class {
	#name : #MicItalicInlineBlock,
	#superclass : #MicAbstractInlineBlock,
	#category : #'Microdown-ModelInline'
}

{ #category : #'as yet unclassified' }
MicItalicInlineBlock >> closingDelimiter [

	^ MicItalicDelimiter markup
]

{ #category : #'as yet unclassified' }
MicItalicInlineBlock >> openingDelimiter [

	^ MicItalicDelimiter markup
]
