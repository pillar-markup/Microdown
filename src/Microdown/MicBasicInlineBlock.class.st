Class {
	#name : #MicBasicInlineBlock,
	#superclass : #MicAbstractInlineBlock,
	#category : #'Microdown-ModelInline'
}

{ #category : #'pillar conversion' }
MicBasicInlineBlock class >> associatedPRClass [
	"special case"
]

{ #category : #converting }
MicBasicInlineBlock >> asPillar [
	^ PRText new text: self substring
]
