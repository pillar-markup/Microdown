Class {
	#name : #MicPillarSlideConverter,
	#superclass : #Object,
	#category : #'Microdown-Slide-Utils'
}

{ #category : #operations }
MicPillarSlideConverter >> convert: aString [ 
	
	| pillar mic |
	pillar := self parse: aString.
	mic := MicSlideConverter new visit: pillar.
	"but we already did a PRMicrodownWriter and we should better extend it."
	"then should use MicTextualMicrodownExporter"
	^ mic
]

{ #category : #parsing }
MicPillarSlideConverter >> parse: aString [

	^ PRPillarParser parse: aString
]
