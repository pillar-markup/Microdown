"
I represent a strike text section. I'm delimited using `~` as in `~strike~` to obtain ~strike~.
"
Class {
	#name : #MicStrikeFormatBlock,
	#superclass : #MicFormatBlock,
	#category : #'Microdown-ModelInline'
}

{ #category : #accessing }
MicStrikeFormatBlock class >> closingDelimiter [

 	^ StrikeMarkup
]

{ #category : #accessing }
MicStrikeFormatBlock class >> openingDelimiter [

 	^ StrikeMarkup
]

{ #category : #visiting }
MicStrikeFormatBlock >> accept: aVisitor [
	^ aVisitor visitStrike: self
]

{ #category : #accessing }
MicStrikeFormatBlock >> closingDelimiter [
	^ self class closingDelimiter
]

{ #category : #accessing }
MicStrikeFormatBlock >> kind [ 
	^ #strike
]

{ #category : #accessing }
MicStrikeFormatBlock >> openingDelimiter [
	^ self class openingDelimiter
]
