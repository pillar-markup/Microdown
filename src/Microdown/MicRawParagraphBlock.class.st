Class {
	#name : 'MicRawParagraphBlock',
	#superclass : 'MicNestedMarkupBlock',
	#instVars : [
		'label'
	],
	#category : 'Microdown-Extensions',
	#package : 'Microdown',
	#tag : 'Extensions'
}

{ #category : 'visiting' }
MicRawParagraphBlock >> accept: aVisitor [

	aVisitor visitRawParagraph: self
]

{ #category : 'handle' }
MicRawParagraphBlock >> closeMe [

	"this is a temporary solution because normally the parser should populate body with MicBlocks.
	Right now just make sure that we have structured text = inline elements. "
	"body ifNotNil: [ 
		body :=  self inlineParse: body ].
	children := body"
	
	"Pay attention closeMe is invoked during parse time and some conversions are creating environment without going over the parser
	For example the # Header to Slide is a typically case. "
	| args |
	args := (firstLine allButFirst: label size).
	args last = $> ifTrue: [ args := args copyFrom: 1 to: args size - 1 ].
	arguments := MicArgumentList 
		split: args
		defaultArg: #environmentName
		defaultValue: ''.
]

{ #category : 'handle' }
MicRawParagraphBlock >> extractFirstLineFrom: aLine [
	"we got < tag ...x > foo bar or < tag ...x and we return tag ...x "
	
	firstLine := aLine copyFrom: self lineStartMarkup size to: aLine size.
	firstLine := firstLine trimBoth.
	label := firstLine copyUpToSubstring: Character space asString.
	"we could do here a split on first space and get the label and the optional args.
	and treat here the arguments instead of doing it in the closeMe."
	
	label last = $> ifTrue: [ label := label allButLast ].
	self halt.
	^ firstLine
	
	
]

{ #category : 'accessing' }
MicRawParagraphBlock >> label [
	^ firstLine
]

{ #category : 'markups' }
MicRawParagraphBlock >> lineStopMarkup [

	^ '</', self label, '>'
]
