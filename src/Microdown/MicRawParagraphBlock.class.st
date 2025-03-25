Class {
	#name : 'MicRawParagraphBlock',
	#superclass : 'MicNestedMarkupBlock',
	#instVars : [
		'label',
		'argumentsString'
	],
	#category : 'Microdown-Extensions',
	#package : 'Microdown',
	#tag : 'Extensions'
}

{ #category : 'public' }
MicRawParagraphBlock class >> alternateBlockClassFor: aLine [
	"We do not want to have extention for MicRawParaphTag"
	
	^ self 
]

{ #category : 'visiting' }
MicRawParagraphBlock >> accept: aVisitor [

	aVisitor visitRawParagraph: self
]

{ #category : 'activation' }
MicRawParagraphBlock >> argumentString [
	^ argumentsString
]

{ #category : 'handle' }
MicRawParagraphBlock >> extractFirstLineFrom: aLine [
	"we got < tag ...x > foo bar or < tag ...x and we return tag ...x "
	
	| splits |
	firstLine := aLine copyFrom: self lineStartMarkup size to: aLine size.
	firstLine := firstLine trimBoth.
	firstLine := firstLine copyFrom: 1 to: firstLine size -1.
	splits := firstLine splitOnFirst: Character space.
	label := splits first.
	splits size = 2 
		ifTrue: [ argumentsString := splits second ].
	^ firstLine
	
	
]

{ #category : 'testing' }
MicRawParagraphBlock >> hasArguments [
	^ argumentsString isNotEmpty
]

{ #category : 'accessing' }
MicRawParagraphBlock >> label [
	^ label
]

{ #category : 'markups' }
MicRawParagraphBlock >> lineStopMarkup [

	^ '</', label, '>'
]

{ #category : 'printing' }
MicRawParagraphBlock >> printOn: aStream [ 

	super printOn: aStream.
	aStream << '(' ;
		<< label ;
		<< ')'
]
