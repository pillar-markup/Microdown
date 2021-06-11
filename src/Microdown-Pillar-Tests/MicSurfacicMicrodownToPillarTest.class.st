"
This test case uses the microdownSnippetFactory and test that the conversion to Pillar object trees is correct. 
This is why it is in this package

Microdown text -> Microdown trees -> Pillar trees

Te tests are just checking that object of the correct class is created. 
Future extensions should handle the details.
"
Class {
	#name : #MicSurfacicMicrodownToPillarTest,
	#superclass : #TestCase,
	#instVars : [
		'factory'
	],
	#category : #'Microdown-Pillar-Tests'
}

{ #category : #'tests - anchor' }
MicSurfacicMicrodownToPillarTest >> anchorClass [

	^ PRAnchor
]

{ #category : #'tests - codeblock' }
MicSurfacicMicrodownToPillarTest >> codeBlockClass [
	^ PRCodeblock
]

{ #category : #accessing }
MicSurfacicMicrodownToPillarTest >> factory [

	^ factory
]

{ #category : #accessing }
MicSurfacicMicrodownToPillarTest >> factory: aFactory [

	factory := aFactory
]

{ #category : #'tests - header' }
MicSurfacicMicrodownToPillarTest >> headerClass [
	^ PRHeader
]

{ #category : #'tests - list' }
MicSurfacicMicrodownToPillarTest >> orderedListClass [
	^ PROrderedList
]

{ #category : #accessing }
MicSurfacicMicrodownToPillarTest >> parse: sample createChildElementOfClass: aClass [

	| parser micDoc pillarDoc |
	parser := self parserClass new. 
	micDoc := parser parse: sample.
	pillarDoc := micDoc asPillar.
	self assert: pillarDoc children first children first class equals: aClass.
	^ pillarDoc children first children first
]

{ #category : #accessing }
MicSurfacicMicrodownToPillarTest >> parse: sample createElementOfClass: aClass [

	| parser micDoc pillarDoc |
	parser := self parserClass new. 
	micDoc := parser parse: sample.
	pillarDoc := micDoc asPillar.
	self assert: pillarDoc children first class equals: aClass.
]

{ #category : #accessing }
MicSurfacicMicrodownToPillarTest >> parseCreateDocument: sample [ 

	| parser micDoc pillarDoc |
	parser := self parserClass new. 
	micDoc := parser parse: sample.
	pillarDoc := micDoc asPillar.
	self assert: pillarDoc class equals: PRDocument.
]

{ #category : #accessing }
MicSurfacicMicrodownToPillarTest >> parserClass [
	^ MicroDownParser   
]

{ #category : #'tests - document' }
MicSurfacicMicrodownToPillarTest >> rootBlockClass [

	^ PRDocument
]

{ #category : #running }
MicSurfacicMicrodownToPillarTest >> setUp [ 
	super setUp.
	self factory: MicMicrodownSnippetFactory new.
]

{ #category : #'tests - list' }
MicSurfacicMicrodownToPillarTest >> unorderedListClass [

	^ PRUnorderedList 
]
