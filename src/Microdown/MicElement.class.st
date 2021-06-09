Class {
	#name : #MicElement,
	#superclass : #Object,
	#category : #'Microdown-Model'
}

{ #category : #converting }
MicElement >> asPillar [ 
	self deprecated: 'Use accept: MicPillarConverter instead' transformWith: '`@receiver asPillar' -> '`@receiver accept: MicPillarConverter new'.
	^ self accept: MicPillarConverter new
]

{ #category : #public }
MicElement >> inlineParse: aString [

	^ MicInlineParser new parse: aString

]
