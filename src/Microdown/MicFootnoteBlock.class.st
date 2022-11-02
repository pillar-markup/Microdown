"
I'm an inline element that represents a footnote as in LaTeX for example. The bibliography will be able to extract its entries from the reference in the citation.

this is a text with a `{!footnote|note=Here is a nice footenote.!}`
"
Class {
	#name : #MicFootnoteBlock,
	#superclass : #MicAnnotationBlock2,
	#category : #'Microdown-Extensions'
}

{ #category : #accessing }
MicFootnoteBlock class >> tag [

	^ #footnote
]

{ #category : #visiting }
MicFootnoteBlock >> accept: aVisitor [
	aVisitor visitFootnote: self
]

{ #category : #accessing }
MicFootnoteBlock >> note [
	arguments ifNotEmpty: [ 
		^ arguments at: #note ifAbsent: [ '' ] ]
]
