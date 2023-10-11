"
A MicHTMLTagTest is a test class for testing the behavior of MicHTMLTag
"
Class {
	#name : 'MicHTMLTagTest',
	#superclass : 'MicHTMLBrushTest',
	#category : 'Microdown-HTMLExporter-Tests-HTML',
	#package : 'Microdown-HTMLExporter-Tests',
	#tag : 'HTML'
}

{ #category : 'tests' }
MicHTMLTagTest >> sampleMicFigureBlock [

	^ MicFigureBlock new 
		argumentAt: 'label' put: 'sampleClass';
		argumentAt: 'width' put: '30';
		yourself.
]

{ #category : 'tests' }
MicHTMLTagTest >> testAddArguments [

	self tag addArguments: self sampleMicFigureBlock.
	self 
		assertCollection: ((self tag contents findTokens: '=') collect: #trimBoth)
		hasSameElements: #('class' '"sampleClass" width' '"30"').

]

{ #category : 'tests' }
MicHTMLTagTest >> testClose [

	tag close.
	self assert: tag contents equals: '>'
]

{ #category : 'tests' }
MicHTMLTagTest >> testContents [

	tag 
		name: 'falop';
		with: 'This is a test'.
	
	self assert: tag contents equals: '<falop>This is a test</falop>'
]

{ #category : 'tests' }
MicHTMLTagTest >> testInitializeArgumentsMap [

	self 
		assert: (tag initializeArgumentsMap isKindOf: Dictionary)
		description: 'It test that the arguments map is of type Dictionary'.
]

{ #category : 'tests' }
MicHTMLTagTest >> testParameterAtPut [

	| keyString valueString tagContents parsedAssoc |
	keyString := 'aKey'.
	valueString := 'aValueString'.
	
	tag parameterAt: keyString put: valueString.
	tagContents := tag contents.
	self 
		assert: (tagContents beginsWith: ' ')
		description: 'It tests that we write a parameter named keyString with valueString as value.'.
	parsedAssoc := tagContents findTokens: '='.

	self assert: parsedAssoc first trimBoth equals: keyString.
	self assert: parsedAssoc second trimBoth equals: (valueString surroundedBy: '"').
	
]

{ #category : 'tests' }
MicHTMLTagTest >> testWith [

	tag 
		name: '';
		with: 'This is a test'.
	
	self assert: tag contents equals: '<>This is a test</>'
]
