Class {
	#name : 'MicNestingPreparerTest',
	#superclass : 'TestCase',
	#category : 'Microdown-BeamerExporter-Tests',
	#package : 'Microdown-BeamerExporter-Tests'
}

{ #category : 'tests' }
MicNestingPreparerTest >> testShouldContainFollowingElement [

	| doc pre |
	doc := MicrodownParser new parse: 
'# Title 1

Textouille 2 ici 

- item 1
- item 2

# Title 2

textouille ici 

- item 3
- item 4

'.
 
	pre := MicNestingPreparer new. 
	pre treatElements: doc children.
	
	self assert: pre store keys size equals: 2.
	self assert: pre store values size equals: 2.
	
	self assert: (pre store at: doc children first) asArray equals: { doc children second . doc children third }.
	self assert: (pre store at: doc children fourth) asArray equals: { doc children fifth . doc children sixth }
	
	
	
	
]
