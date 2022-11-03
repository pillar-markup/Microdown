"
I represent a strike text section. I'm delimited using `~` as in `~strike~` to obtain ~strike~.
"
Class {
	#name : #MicStrikeFormatBlock2,
	#superclass : #MicEvaluatedBlock2,
	#category : #'Microdown-InlineParser'
}

{ #category : #accessing }
MicStrikeFormatBlock2 class >> closingDelimiter [

 	^ StrikeMarkup
]

{ #category : #accessing }
MicStrikeFormatBlock2 class >> openingDelimiter [

 	^ StrikeMarkup
]

{ #category : #visiting }
MicStrikeFormatBlock2 >> accept: aVisitor [
	^ aVisitor visitStrike: self
]
