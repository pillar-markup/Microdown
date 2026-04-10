Class {
	#name : 'MicSlideBlockTest',
	#superclass : 'MicBlockTest',
	#category : 'Microdown-Tests-Extensions',
	#package : 'Microdown-Tests',
	#tag : 'Extensions'
}

{ #category : 'tests' }
MicSlideBlockTest >> subjectClass [ 
	^ MicSlideBlock 
]

{ #category : 'tests' }
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

{ #category : 'tests' }
MicSlideBlockTest >> testSlideBlocTitleIsNotReified [
	"For now there is no simple way to know which arguments should be reified
	in extension contrary to figure or math equation."
	
	| doc |
	doc := Microdown parse: 

'<!slide|title=This is a cool title&tag=nh5p

- a list of bullet
- bullet 2
- bullet 3
!>'.
	self assert: doc children first title equals: 'This is a cool title'
]
