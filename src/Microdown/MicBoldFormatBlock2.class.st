"
I represent a bold text section. I'm delimited using `**` as in `**bold**` to obtain **bold**.
"
Class {
	#name : #MicBoldFormatBlock2,
	#superclass : #MicEvaluatedBlock2,
	#category : #'Microdown-InlineParser'
}

{ #category : #accessing }
MicBoldFormatBlock2 class >> closingDelimiter [

 	^ BoldMarkup
]

{ #category : #accessing }
MicBoldFormatBlock2 class >> openingDelimiter [

 	^ BoldMarkup
]

{ #category : #visiting }
MicBoldFormatBlock2 >> accept: aVisitor [
	^ aVisitor visitBold: self
]
