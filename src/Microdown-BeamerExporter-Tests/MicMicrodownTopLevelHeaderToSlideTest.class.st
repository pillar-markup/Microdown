Class {
	#name : 'MicMicrodownTopLevelHeaderToSlideTest',
	#superclass : 'TestCase',
	#category : 'Microdown-BeamerExporter-Tests-Slide as header',
	#package : 'Microdown-BeamerExporter-Tests',
	#tag : 'Slide as header'
}

{ #category : 'tests' }
MicMicrodownTopLevelHeaderToSlideTest >> testSectionLevelOneIsMapToSlide [

	| doc slide |
	doc := MicrodownParser new parse: '# Slide title

- item 1
- item 2
'.
	MicMicrodownTopLevelHeaderToSlide new visit: doc. 
	slide := doc children first.
	self assert: slide class equals: MicSlideBlock.
	self assert:  slide title equals: 'Slide title'.
	self assert: doc children second class equals: MicUnorderedListBlock.
		
	
]

{ #category : 'tests' }
MicMicrodownTopLevelHeaderToSlideTest >> testSlideGotCorrectParent [

	| doc slide |
	doc := MicrodownParser new parse: '# Slide title

- item 1
- item 2
'.
   self assert: doc children size equals: 2.
	MicMicrodownTopLevelHeaderToSlide new visit: doc. 
	slide := doc children first.
	self assert: slide parent equals: doc.
	self assert: doc children size equals: 2
	
]

{ #category : 'tests' }
MicMicrodownTopLevelHeaderToSlideTest >> testSlideMetaData [

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
	MicMicrodownTopLevelHeaderToSlide new visit: doc. 
	self assert: doc children first class equals: MicMetaDataBlock.
	self assert: doc children second class equals: MicSlideBlock 
	
]

{ #category : 'tests' }
MicMicrodownTopLevelHeaderToSlideTest >> testSlideShouldContainFollowingElement [

	| doc |
	doc := MicrodownParser new parse: 
'# Level 1 - 1

## Level 2 - 1 

### Level 3

## Level 2 - 2

## Level 2 - 3 

# Level 1 - 2

## Level 2 - 1 

### Level 3

## Level 2 - 2

'.
 
	MicMicrodownTopLevelHeaderToSlide new start: doc. 
	
	self assert: doc children size equals: 2.
	self assert: doc children first children size equals: 4.
		"The followers are not nesting in each others so H3 is not a child of H2 but 
		a child of SlideBlock"
	self assert: doc children second children size equals: 3.
	
]
