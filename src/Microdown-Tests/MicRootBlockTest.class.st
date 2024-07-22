"
I'm a test class for testing the behavior of MicRootBlock
"
Class {
	#name : 'MicRootBlockTest',
	#superclass : 'MicBlockTest',
	#category : 'Microdown-Tests-Parser',
	#package : 'Microdown-Tests',
	#tag : 'Parser'
}

{ #category : 'tests' }
MicRootBlockTest >> subjectClass [ 
	^ MicRootBlock 
]

{ #category : 'tests' }
MicRootBlockTest >> testRootCanConsumeLine [
	"a root block can consume anything"
	
	| rootNode | 
	rootNode := MicRootBlock new.
	self assert: (rootNode canConsumeLine: '#').
	self assert: (rootNode canConsumeLine: '- ')
]

{ #category : 'tests - metadata' }
MicRootBlockTest >> testRootDoesNotHaveMetaDataElement [

	| source root |
	source := '
# Section 1 
	
	{
"authors" : "S. Ducasse" ,
"title" : "Pharo by Example"
}

# Section 1 

- bullet 1
- bullet 2
'.


	root := parser parse: source.
	self deny: root hasMetaDataElement.
	
]

{ #category : 'tests - metadata' }
MicRootBlockTest >> testRootHasMetaDataElement [

	| source root |
	source := '{
"authors" : "S. Ducasse" ,
"title" : "Pharo by Example"
}

# Section 1 

- bullet 1
- bullet 2
'.


	root := parser parse: source..
	self assert: root hasMetaDataElement.
	
]

{ #category : 'tests - metadata' }
MicRootBlockTest >> testRootWithMetaDataElementHasProperties [

	| source root |
	source := '{
"authors" : "S. Ducasse" ,
"title" : "Pharo by Example"
}

# Section 1 

- bullet 1
- bullet 2
'.


	root := parser parse: source.
	self assert: root hasMetaDataElement.
	self assert: root properties class equals: Dictionary.
	self assert: (root propertyAt: 'title') equals: 'Pharo by Example'.
	self assert: (root propertyAt: 'authors') equals: 'S. Ducasse'.
	
]
