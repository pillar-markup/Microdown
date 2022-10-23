"
I represent an italic text section. I'm delimited using `_` as in `_italic_` to obtain _italic_.
"
Class {
	#name : #MicItalicFormatBlock,
	#superclass : #MicFormatBlock,
	#category : #'Microdown-ModelInline'
}

{ #category : #accessing }
MicItalicFormatBlock class >> closingDelimiter [

 	^ ItalicMarkup
]

{ #category : #accessing }
MicItalicFormatBlock class >> openingDelimiter [

 	^ ItalicMarkup
]

{ #category : #visiting }
MicItalicFormatBlock >> accept: aVisitor [
	^ aVisitor visitItalic: self
]

{ #category : #accessing }
MicItalicFormatBlock >> closingDelimiter [
	^ self class closingDelimiter
]

{ #category : #accessing }
MicItalicFormatBlock >> kind [

	^ #italic
]

{ #category : #accessing }
MicItalicFormatBlock >> openingDelimiter [
	^ self class openingDelimiter
]
