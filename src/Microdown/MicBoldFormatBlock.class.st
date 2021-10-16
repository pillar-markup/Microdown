"
I represent a bold text section. I'm delimited using `**` as in `**bold**` to obtain **bold**.
"
Class {
	#name : #MicBoldFormatBlock,
	#superclass : #MicFormatBlock,
	#category : #'Microdown-ModelInline'
}

{ #category : #visiting }
MicBoldFormatBlock >> accept: aVisitor [
	^ aVisitor visitBold: self
]

{ #category : #utils }
MicBoldFormatBlock >> closingDelimiter [

 	^ MicBoldDelimiter markup
]

{ #category : #utils }
MicBoldFormatBlock >> kind [
	^ #bold
]

{ #category : #utils }
MicBoldFormatBlock >> openingDelimiter [

 	^ MicBoldDelimiter markup
]
