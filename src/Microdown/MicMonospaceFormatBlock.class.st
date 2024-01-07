"
I represent a monospaced text section. I'm delimited using `\`` as in `\`monospace\`` to obtain `monospace`.
"
Class {
	#name : #MicMonospaceFormatBlock,
	#superclass : #MicUnEvaluatedBlock,
	#category : #'Microdown-InlineParser'
}

{ #category : #accessing }
MicMonospaceFormatBlock class >> blockName [
	^ (super blockName) withoutSuffix: 'Format'
]

{ #category : #accessing }
MicMonospaceFormatBlock class >> closingDelimiter [

 	^ MonospaceMarkup
]

{ #category : #accessing }
MicMonospaceFormatBlock class >> openingDelimiter [

 	^ MonospaceMarkup
]

{ #category : #visiting }
MicMonospaceFormatBlock >> accept: aVisitor [
	^ aVisitor visitMonospace: self
]

{ #category : #accessing }
MicMonospaceFormatBlock >> children [
	"should be deprecated"
	^ Array with: (MicTextBlock new bodystring: self bodystring)
]

{ #category : #accessing }
MicMonospaceFormatBlock >> text [
	"should be deprecated "
	^ self bodystring 
]
