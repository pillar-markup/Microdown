Class {
	#name : #MicElement,
	#superclass : #Object,
	#category : #'Microdown-Model'
}

{ #category : #converting }
MicElement >> asPillar [ 
	^ self accept: MicPillarConverter new
]

{ #category : #public }
MicElement >> inlineParse: aString [

	^ MicInlineParser new parse: aString

]
