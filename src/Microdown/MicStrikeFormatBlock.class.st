"
I represent a strike text section. I'm delimited using `~` as in `~strike~` to obtain ~strike~.
"
Class {
	#name : 'MicStrikeFormatBlock',
	#superclass : 'MicEvaluatedBlock',
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'accessing' }
MicStrikeFormatBlock class >> closingDelimiter [

 	^ StrikeMarkup
]

{ #category : 'accessing' }
MicStrikeFormatBlock class >> openingDelimiter [

 	^ StrikeMarkup
]

{ #category : 'visiting' }
MicStrikeFormatBlock >> accept: aVisitor [
	^ aVisitor visitStrike: self
]
