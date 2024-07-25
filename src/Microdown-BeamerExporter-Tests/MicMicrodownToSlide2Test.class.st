Class {
	#name : 'MicMicrodownToSlide2Test',
	#superclass : 'TestCase',
	#category : 'Microdown-BeamerExporter-Tests',
	#package : 'Microdown-BeamerExporter-Tests'
}

{ #category : 'tests' }
MicMicrodownToSlide2Test >> testSectionLevelOneIsMapToSlide [

	| doc slide |
	doc := MicrodownParser new parse: '# Slide title

- item 1
- item 2
'.
	MicMicrodownToSlideVisitor2 new visit: doc. 
	slide := doc children first.
	self assert: slide class equals: MicSlideBlock.
	self assert:  slide title equals: 'Slide title'.
	self assert: doc children second class equals: MicUnorderedListBlock.
		
	
]

{ #category : 'tests' }
MicMicrodownToSlide2Test >> testSlideGotCorrectParent [

	| doc slide |
	doc := MicrodownParser new parse: '# Slide title

- item 1
- item 2
'.
   self assert: doc children size equals: 2.
	MicMicrodownToSlideVisitor2 new visit: doc. 
	slide := doc children first.
	self assert: slide parent equals: doc.
	self assert: doc children size equals: 2
	
]

{ #category : 'tests' }
MicMicrodownToSlide2Test >> testSlideMetaData [

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
	MicMicrodownToSlideVisitor2 new visit: doc. 
	self assert: doc children first class equals: MicMetaDataBlock.
	self assert: doc children second class equals: MicSlideBlock 
	
]

{ #category : 'tests' }
MicMicrodownToSlide2Test >> testSlideShouldContainFollowingElement [

	| doc |
	self skip.
	doc := MicrodownParser new parse: 
'# Level 1

## Level 2

### Level 3

## Level 2 

## Level 2 

# Level 1 

## Level 2

### Level 3

## Level 2






'.
 
	MicMicrodownToSlideVisitor2 new visit: doc. 
	
	self assert: doc children equals: 2.
	self assert: doc children first size equals: 2
	
]
