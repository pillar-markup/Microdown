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

{ #category : 'handle' }
MicRawParagraphBlock >> bodyFromLine: line [

	(line beginsWith: '<\', label)	
		ifTrue: [ isClosed := true ]
		ifFalse: [ body := body ifNil: [ line ] ifNotNil: [ body , String cr , line ] ]
]

{ #category : 'handle' }
MicRawParagraphBlock >> doesLineStartWithStopMarkup: line [

	"return if the line starts with a stop markup"
	^ line beginsWith: '</', label, '>'
]

{ #category : 'handle' }
MicRawParagraphBlock >> extractFirstLineFrom: line [
	label := line allButFirst copyUpToSubstring: '>'
	
]

{ #category : 'accessing' }
MicRawParagraphBlock >> label [
	^ label
]
