"
I represent a monospaced text section. I'm delimited using `\`` as in `\`monospace\`` to obtain `monospace`.
"
Class {
	#name : #MicMonospaceFormatBlock2,
	#superclass : #MicUnEvaluatedBlock2,
	#category : #'Microdown-InlineParser'
}

{ #category : #'as yet unclassified' }
MicMonospaceFormatBlock2 class >> blockName [
	^ (super blockName) withoutSuffix: 'Format'
]

{ #category : #visiting }
MicMonospaceFormatBlock2 >> accept: aVisitor [
	^ aVisitor visitMonospace: self
]

{ #category : #accessing }
MicMonospaceFormatBlock2 >> children [
	"should be deprecated"
	^ Array with: (MicTextBlock2 new bodystring: self bodystring)
]

{ #category : #accessing }
MicMonospaceFormatBlock2 >> text [
	"should be deprecated "
	^ self bodystring 
]
