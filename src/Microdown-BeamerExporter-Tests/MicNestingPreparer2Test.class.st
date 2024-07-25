Class {
	#name : 'MicNestingPreparer2Test',
	#superclass : 'TestCase',
	#category : 'Microdown-BeamerExporter-Tests',
	#package : 'Microdown-BeamerExporter-Tests'
}

{ #category : 'tests' }
MicNestingPreparer2Test >> testShouldContainFollowingElement [

	| doc pre nDoc |
	doc := MicrodownParser new parse: 
'# Level 1 - A

## Level 2 - A

## Level 2 - B

### Level 3 - A

## Level 2 - C

# Level 1 - B

## Level 2 - A

'.
 
	pre := MicNestingPreparer2 new. 
	
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
