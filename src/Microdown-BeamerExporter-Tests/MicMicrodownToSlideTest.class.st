Class {
	#name : 'MicMicrodownToSlideTest',
	#superclass : 'TestCase',
	#category : 'Microdown-BeamerExporter-Tests',
	#package : 'Microdown-BeamerExporter-Tests'
}

{ #category : 'tests' }
MicMicrodownToSlideTest >> testSectionLevelOneIsMapToSlide [

	| doc |
	doc := MicrodownParser new parse: '# Slide title

- item 1
- item 2
'.
	MicMicrodownToSlideVisitor new visit: doc. 
	self assert: doc children first class equals: MicSlideBlock.
	self assert: doc children second class equals: MicUnorderedListBlock.
		
	
]
