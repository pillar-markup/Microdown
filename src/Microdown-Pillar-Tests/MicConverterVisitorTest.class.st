Class {
	#name : #MicConverterVisitorTest,
	#superclass : #TestCase,
	#instVars : [
		'pillarDocument',
		'visitor'
	],
	#category : #'Microdown-Pillar-Tests'
}

{ #category : #tests }
MicConverterVisitorTest >> parserClass [
	^ MicroDownParser
]

{ #category : #initialization }
MicConverterVisitorTest >> setUp [
 	super setUp.
 	visitor := MicPillarConverterOnUnexpandedBloc new
]

{ #category : #tests }
MicConverterVisitorTest >> testCodeBlock [

	| document |
	document := self parserClass new parse: '```language=pharo
	1-2 
```'.
	self assert: (document accept: visitor) children first class equals: PRCodeblock.
	
]

{ #category : #tests }
MicConverterVisitorTest >> testCodeInText [

	| document |
	document := self parserClass new parse: 'The method `foo` is fun'.
	pillarDocument := document accept: visitor.
	self assert: pillarDocument children first class equals: PRParagraph.
	self assert: pillarDocument children first children second class equals: PRMonospaceFormat 
	
	
]

{ #category : #tests }
MicConverterVisitorTest >> testHeader [ 

	| document |
	document := self parserClass new parse: '# Header1
	
## Header 2
	
### Header 3'.
	pillarDocument := document accept: visitor.
	"we could have use Grammar headerMarkup to build the text but this is clearer like that"
	self assert: pillarDocument children first class equals: PRHeader.
	self assert: pillarDocument children third class equals: PRHeader.
	self assert: pillarDocument children fifth class equals: PRHeader
	
]

{ #category : #tests }
MicConverterVisitorTest >> testNumberedList [
	| document |
	document := (self parserClass new 
		parse: MicMicroDownSnippetFactory new orderedListWithTwoItemsSample).
	document := document accept: visitor.
	self assert: document children first class equals: PROrderedList.
	self
		assert: document children first children first class
		equals: PRListItem.
	self
		assert: document children first children second class
		equals: PRListItem
]
