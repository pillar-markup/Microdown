Class {
	#name : 'MicRawParagraphBlock',
	#superclass : 'MicNestedMarkupBlock',
	#category : 'Microdown-Extensions',
	#package : 'Microdown',
	#tag : 'Extensions'
}

{ #category : 'visiting' }
MicRawParagraphBlock >> accept: aVisitor [

	aVisitor visitRawParagraph: self
]

{ #category : 'handle' }
MicRawParagraphBlock >> extractFirstLineFrom: aLine [
	"we got < tag ...x > foo bar or < tag ...x and we return tag ...x "
	
	| extract |
	firstLine := aLine copyFrom: self lineStartMarkup size to: aLine size.
	firstLine := firstLine trimBoth.
	extract := firstLine copyUpToSubstring: '>'.
	"we can just trimboth and avoid this test"
	^ extract size < firstLine size 
		ifTrue: [ 
			extract trimRight ]
		ifFalse: [ firstLine ]
]

{ #category : 'accessing' }
MicRawParagraphBlock >> label [
	^ firstLine
]

{ #category : 'markups' }
MicRawParagraphBlock >> lineStopMarkup [

	^ '</', self label, '>'
]
