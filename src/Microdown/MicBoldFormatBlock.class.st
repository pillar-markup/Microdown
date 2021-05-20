"
I represent a bold text section. I'm delimited using `**` as in `**bold**` to obtain **bold**.
"
Class {
	#name : #MicBoldFormatBlock,
	#superclass : #MicInlineBlock,
	#category : #'Microdown-ModelInline'
}

{ #category : #visiting }
MicBoldFormatBlock >> accept: aVisitor [
	^ aVisitor visitBold: self
]

{ #category : #'as yet unclassified' }
MicBoldFormatBlock >> closingDelimiter [

 	^ MicBoldDelimiter markup
]

{ #category : #'as yet unclassified' }
MicBoldFormatBlock >> openingDelimiter [

 	^ MicBoldDelimiter markup
]
