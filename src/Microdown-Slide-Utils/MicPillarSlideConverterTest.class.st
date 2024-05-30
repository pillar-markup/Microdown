Class {
	#name : 'MicPillarSlideConverterTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Slide-Utils',
	#package : 'Microdown-Slide-Utils'
}

{ #category : 'parsing' }
MicPillarSlideConverterTest >> parse: aString [

	^ PRPillarParser parse: aString
]

{ #category : 'parsing' }
MicPillarSlideConverterTest >> testConvertParagraphSlide [

	| converter res |
	converter := MicPillarSlideConverter new.
	res := converter convert: '${slide:title=Goal}$

This is a paragraph.
'.
	self assert: res children first class equals: MicSlideBlock 
]

{ #category : 'parsing' }
MicPillarSlideConverterTest >> testConvertSlide [

	| converter res |
	converter := MicPillarSlideConverter new.
	res := converter convert: '${slide:title=Goal}$

- How can we navigate an instance tree?
- With optional states that can be skipped?
'.
	self assert: res children first class equals: MicSlideBlock 
]
