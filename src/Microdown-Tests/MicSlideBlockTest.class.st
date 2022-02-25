Class {
	#name : #MicSlideBlockTest,
	#superclass : #MicBlockTest,
	#category : #'Microdown-Tests-Parser'
}

{ #category : #tests }
MicSlideBlockTest >> testSlideBloc [

	| doc |
	doc := Microdown parse: 

'<!slide|title=This is a cool title&tag=nh5p

- a list of bullet
- bullet 2
- bullet 3
!>'.
	self assert: doc children first title equals: 'This is a cool title'
]

{ #category : #tests }
MicSlideBlockTest >> testSlideBlocIsParsed [

	| doc |
	doc := Microdown parse: 

'<!slide|title=This is a cool title&tag=nh5p

- a list of bullet
- bullet 2
- bullet 3
!>'.
	self assert: doc children first class equals: MicSlideBlock
]

{ #category : #tests }
MicSlideBlockTest >> testedClass [ 
	^ MicSlideBlock 
]
