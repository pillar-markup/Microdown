Class {
	#name : #MicFigureInlineBlock,
	#superclass : #MicAbstractInlineBlockWithUrl,
	#instVars : [
		'label',
		'parameters'
	],
	#category : #'Microdown-ModelInline'
}

{ #category : #accessing }
MicFigureInlineBlock >> label [
	^ label
]

{ #category : #accessing }
MicFigureInlineBlock >> label: aLabel [
	label := aLabel
]

{ #category : #accessing }
MicFigureInlineBlock >> parameters [
	^ parameters 
]

{ #category : #accessing }
MicFigureInlineBlock >> parameters: someParameters [
	parameters := someParameters
]
