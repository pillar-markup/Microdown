"
I represent a strike text section. I'm delimited using `~` as in `~strike~` to obtain ~strike~.
"
Class {
	#name : #MicStrikeFormatBlock2,
	#superclass : #MicEvaluatedBlock2,
	#category : #'Microdown-InlineParser'
}

{ #category : #visiting }
MicStrikeFormatBlock2 >> accept: aVisitor [
	^ aVisitor visitStrike: self
]
