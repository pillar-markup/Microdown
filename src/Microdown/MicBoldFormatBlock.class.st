"
I represent a bold text section. I'm delimited using `**` as in `**bold**` to obtain **bold**.
"
Class {
	#name : #MicBoldFormatBlock,
	#superclass : #MicFormatBlock,
	#category : #'Microdown-ModelInline'
}

{ #category : #accessing }
MicBoldFormatBlock class >> closingDelimiter [

 	^ BoldMarkup
]

{ #category : #accessing }
MicBoldFormatBlock class >> openingDelimiter [

 	^ BoldMarkup
]

{ #category : #utilities }
MicBoldFormatBlock >> accept: aVisitor [
	^ aVisitor visitBold: self
]

{ #category : #accessing }
MicBoldFormatBlock >> closingDelimiter [
	^ self class closingDelimiter
]

{ #category : #utilities }
MicBoldFormatBlock >> kind [
	^ #bold
]

{ #category : #accessing }
MicBoldFormatBlock >> openingDelimiter [
	^ self class openingDelimiter
]
