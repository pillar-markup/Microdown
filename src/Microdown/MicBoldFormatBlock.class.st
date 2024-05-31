"
I represent a bold text section. I'm delimited using `**` as in `**bold**` to obtain **bold**.
"
Class {
	#name : 'MicBoldFormatBlock',
	#superclass : 'MicEvaluatedBlock',
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'accessing' }
MicBoldFormatBlock class >> closingDelimiter [

 	^ BoldMarkup
]

{ #category : 'accessing' }
MicBoldFormatBlock class >> openingDelimiter [

 	^ BoldMarkup
]

{ #category : 'visiting' }
MicBoldFormatBlock >> accept: aVisitor [
	^ aVisitor visitBold: self
]
