"
I represent a bold text section. I'm delimited using `**` as in `**bold**` to obtain **bold**.
"
Class {
	#name : 'MicBoldFormatBlock',
	#superclass : 'MicFormatBlock',
	#category : 'Microdown-ModelInline',
	#package : 'Microdown',
	#tag : 'ModelInline'
}

{ #category : 'utilities' }
MicBoldFormatBlock >> accept: aVisitor [
	^ aVisitor visitBold: self
]

{ #category : 'utilities' }
MicBoldFormatBlock >> closingDelimiter [

 	^ BoldMarkup
]

{ #category : 'utilities' }
MicBoldFormatBlock >> kind [
	^ #bold
]

{ #category : 'utilities' }
MicBoldFormatBlock >> openingDelimiter [

 	^ BoldMarkup
]
