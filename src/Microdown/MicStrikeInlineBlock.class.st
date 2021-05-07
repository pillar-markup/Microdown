"
I represent a strike text section. I'm delimited using `~` as in `~strike~` to obtain ~strike~.
"
Class {
	#name : #MicStrikeInlineBlock,
	#superclass : #MicAbstractInlineBlock,
	#category : #'Microdown-ModelInline'
}

{ #category : #accessing }
MicStrikeInlineBlock >> closingDelimiter [

 	^ MicStrikeDelimiter markup
]

{ #category : #accessing }
MicStrikeInlineBlock >> openingDelimiter [

 	^ MicStrikeDelimiter markup
]
