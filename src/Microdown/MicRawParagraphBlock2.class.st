Class {
	#name : 'MicRawParagraphBlock2',
	#superclass : 'MicStartStopMarkupBlock',
	#instVars : [
		'label'
	],
	#category : 'Microdown-Extensions',
	#package : 'Microdown',
	#tag : 'Extensions'
}

{ #category : 'visiting' }
MicRawParagraphBlock2 >> accept: aVisitor [

	aVisitor visitRawParagraph: self
]

{ #category : 'handle' }
MicRawParagraphBlock2 >> bodyFromLine: line [

	(self doesLineStartWithStopMarkup: line)
		ifTrue: [ isClosed := true ]
		ifFalse: [ body := body ifNil: [ line ] ifNotNil: [ 
				body , String cr , line ] ]
]

{ #category : 'handle' }
MicRawParagraphBlock2 >> extractFirstLineFrom: line [
	"we cannot know in advance the markup so we have to guess and store it for closing."

	label := line allButFirst copyUpToSubstring: '>'
	
]

{ #category : 'accessing' }
MicRawParagraphBlock2 >> label [
	^ label
]

{ #category : 'markups' }
MicRawParagraphBlock2 >> lineStopMarkup [

	^ '</', label, '>'
]
