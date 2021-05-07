"
I represent a bold text section. I'm delimited using `**` as in `**bold**` to obtain **bold**.
"
Class {
	#name : #MicBoldInlineBlock,
	#superclass : #MicAbstractInlineBlock,
	#category : #'Microdown-ModelInline'
}

{ #category : #'as yet unclassified' }
MicBoldInlineBlock >> closingDelimiter [

 	^ MicBoldDelimiter markup
]

{ #category : #'as yet unclassified' }
MicBoldInlineBlock >> openingDelimiter [

 	^ MicBoldDelimiter markup
]
