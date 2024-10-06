Class {
	#name : 'MicRawParagraphBlock',
	#superclass : 'MicStartStopMarkupBlock',
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
MicRawParagraphBlock >> bodyFromLine: line [

	(self doesLineStartWithStopMarkup: line)
		ifTrue: [ isClosed := true ]
		ifFalse: [ body := body ifNil: [ line ] ifNotNil: [ body , String cr , line ] ]
]

{ #category : 'handle' }
MicRawParagraphBlock >> extractFirstLineFrom: line [
	"we cannot know in advance the markup so we have to guess and store it for closing."

	label := line allButFirst copyUpToSubstring: '>'
	
]

{ #category : 'accessing' }
MicRawParagraphBlock >> label [
	^ label
]

{ #category : 'markups' }
MicRawParagraphBlock >> lineStopMarkup [

	^ '</', label, '>'
]
