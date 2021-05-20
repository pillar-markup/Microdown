"
I represent a monospaced text section. I'm delimited using `\`` as in `\`monospace\`` to obtain `monospace`.
"
Class {
	#name : #MicMonospaceFormatBlock,
	#superclass : #MicInlineBlock,
	#category : #'Microdown-ModelInline'
}

{ #category : #testing }
MicMonospaceFormatBlock class >> isEvaluated [
	^ false
]

{ #category : #visiting }
MicMonospaceFormatBlock >> accept: aVisitor [
	^ aVisitor visitMonospace: self
]

{ #category : #'as yet unclassified' }
MicMonospaceFormatBlock >> closingDelimiter [

 	^ MicMonospaceDelimiter markup
]

{ #category : #'as yet unclassified' }
MicMonospaceFormatBlock >> openingDelimiter [

 	^ MicMonospaceDelimiter markup
]
