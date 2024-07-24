Class {
	#name : 'MicMicrodownToSlideTest',
	#superclass : 'TestCase',
	#category : 'Microdown-BeamerExporter-Tests-Slide as header',
	#package : 'Microdown-BeamerExporter-Tests',
	#tag : 'Slide as header'
}

{ #category : 'tests' }
MicMicrodownToSlideTest >> testSectionLevelOneIsMapToSlide [

	| doc slide |
	doc := MicrodownParser new parse: '# Slide title

- item 1
- item 2
'.
	MicMicrodownToSlideVisitor new visit: doc. 
	slide := doc children first.
	self assert: slide class equals: MicSlideBlock.
	self assert:  slide title equals: 'Slide title'.
	self assert: doc children second class equals: MicUnorderedListBlock.
		
	
]

{ #category : 'tests' }
MicMicrodownToSlideTest >> testSlideGotCorrectParent [

	| doc slide |
	doc := MicrodownParser new parse: '# Slide title

- item 1
- item 2
'.
   self assert: doc children size equals: 2.
	MicMicrodownToSlideVisitor new visit: doc. 
	slide := doc children first.
	self assert: slide parent equals: doc.
	self assert: doc children size equals: 2
	
]

{ #category : 'tests' }
MicMicrodownToSlideTest >> testSlideMetaData [

	| doc |
	doc := MicrodownParser new parse: '
{
	"title":"Essence of Dispatch",
	"subtitle":"Taking Pharo Booleans as example",
	"slidesid" : "M1S1"
}

# Slide title

- item 1
- item 2
'.
   self assert: doc children size equals: 3.
	MicMicrodownToSlideVisitor new visit: doc. 
	self assert: doc children first class equals: MicMetaDataBlock.
	self assert: doc children second class equals: MicSlideBlock 
	
]

{ #category : 'tests' }
MicMicrodownToSlideTest >> testSlideShouldContainFollowingElement [

	| doc |
	doc := MicrodownParser new parse: '# Title 1

Textouille 2 ici 

- item 1
- item 2

# Title 2

textouille ici 
- item 3
- item 4

'.
 
	MicMicrodownToSlideVisitor new visit: doc. 
	
	self assert: doc children size equals: 6.
	self assert: doc children first class equals: MicSlideBlock 
	
]
