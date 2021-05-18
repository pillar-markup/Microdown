"
I represent a strike text section. I'm delimited using `~` as in `~strike~` to obtain ~strike~.
"
Class {
	#name : #MicStrikeFormatBlock,
	#superclass : #MicInlineBlock,
	#category : #'Microdown-ModelInline'
}

{ #category : #accessing }
MicStrikeFormatBlock >> closingDelimiter [

 	^ MicStrikeDelimiter markup
]

{ #category : #accessing }
MicStrikeFormatBlock >> openingDelimiter [

 	^ MicStrikeDelimiter markup
]
