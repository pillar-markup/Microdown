Class {
	#name : 'MicSlideFollowerNesterTest',
	#superclass : 'TestCase',
	#category : 'Microdown-BeamerExporter-Tests-Slide as header',
	#package : 'Microdown-BeamerExporter-Tests',
	#tag : 'Slide as header'
}

{ #category : 'tests' }
MicSlideFollowerNesterTest >> testShouldContainFollowingElement [

	| doc pre nDoc |
	"I use faked slide ie without containting elements so that I can then test that the following items 
are placed in slide after the pass of the slide nester."

	doc := MicrodownParser new parse: 
'# Level 1 - A

## Level 2 - A

## Level 2 - B

### Level 3 - A

## Level 2 - C

# Level 1 - B

## Level 2 - A

'.
  
	pre := MicSlideFollowerNester new. 
	
	pre treatChildrenOf: doc.
	nDoc := pre newDocument.
	"note that the doc have header with extra children and this does not make 
	much sense even if this is correct from the algo. 
	This should only be applied on new nodes as planned.
	
	"
	self assert: nDoc children size equals: 2.
	self assert: nDoc children first children size equals: 4. 
	"one for the header text and three H2"
	
	
]
