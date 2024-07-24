Class {
	#name : 'MicSlideFollowerNesterTest',
	#superclass : 'TestCase',
	#category : 'Microdown-BeamerExporter-Tests-Slide as header',
	#package : 'Microdown-BeamerExporter-Tests',
	#tag : 'Slide as header'
}

{ #category : 'tests' }
MicSlideFollowerNesterTest >> testShouldContainFollowingElement [

	| doc nester |
	"I use faked slide ie without containting elements so that I can then test that the following items 
	are placed in slide after the pass of the slide nester."

	doc := MicrodownParser new parse: 
'<!slide|title=Level 1 - A!>

## Level 2 - A

### Level 3 - A

## Level 2 - B

<!slide|title=Level 1 - B!>

## Level 2 - A

'.
  
self halt.
	nester := MicSlideFollowerNester new. 
	
	nester treatElements: doc children.

	"note that the doc have header with extra children and this does not make 
	much sense even if this is correct from the algo. 
	This should only be applied on new nodes as planned.
	
	"
	self assert: doc children size equals: 2.
	self assert: doc children first children size equals: 3. 
	"three H2"
	
	
]
