Class {
	#name : #MicFigureInlineBlock,
	#superclass : #MicAbstractInlineBlockWithUrl,
	#instVars : [
		'parameters'
	],
	#category : #'Microdown-ModelInline'
}

{ #category : #converting }
MicFigureInlineBlock >> asPillar [
	| aPRFigure |
	aPRFigure := super asPillar.
	^ aPRFigure label: self substring; parameters: self parameters; yourself
]

{ #category : #accessing }
MicFigureInlineBlock >> parameters [
	^ parameters 
]

{ #category : #accessing }
MicFigureInlineBlock >> parameters: someParameters [
	parameters := someParameters
]

{ #category : #transformation }
MicFigureInlineBlock >> urlTransformation [
	| resultArray |
	resultArray := MicArgumentsSplitter findNameAndArguments: self url readStream.
	self url: (ZnUrl fromString: resultArray first).
	self parameters: resultArray second
]
