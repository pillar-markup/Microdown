Class {
	#name : #MicHTMLDocTest,
	#superclass : #TestCase,
	#instVars : [
		'doc'
	],
	#category : #'Microdown-HTMLExporter-Tests'
}

{ #category : #running }
MicHTMLDocTest >> sampleHTMLContents [

	^ MicDocFactory exampleMicAsHTMLDocument
]

{ #category : #running }
MicHTMLDocTest >> setUp [
	
	super setUp.
	doc := MicHTMLDoc new
		contents: self sampleHTMLContents;
		yourself
]

{ #category : #tests }
MicHTMLDocTest >> testCharSet [

	self 
		assert: (doc charSet isKindOf: String)
		description: 'It tests that the charSet identifier is a String'.
		
	self
		assert: doc charSet notNil
		description: 'It test that the document charset has beed initialized'.

	
]

{ #category : #tests }
MicHTMLDocTest >> testContents [

	self 
		assert: (doc contents isKindOf: String) 
		description: 'It test that a HTML document contents contains a String'.
	self
		assert: doc contents
		equals: self sampleHTMLContents.
	doc contents: String empty.
	self 
		assert: doc contents isEmpty
		description: 'It test that a HTML document contents is not empty'.
]

{ #category : #tests }
MicHTMLDocTest >> testDocumentType [

	self 
		assert: (doc documentType isKindOf: String)
		description: 'The document type should be described as String'.
		
	self
		assert: doc documentType
		equals: doc class documentType
]

{ #category : #tests }
MicHTMLDocTest >> testFileName [

	self 
		assert: doc fileName isNil
		description: 'A document does not have a file name by default'.
		
	doc fileName: 'index.html'.
	self
		assert: (doc fileName isKindOf: String)
		description: 'No transformations are done to the configured file name'.
		
	self
		assert: doc fileName
		equals: 'index.html'
]

{ #category : #test }
MicHTMLDocTest >> testNewMicStreamOn [

	self 
		assert: ((doc newMicStreamOn: String empty) isKindOf: MicOutputStream)
		description: 'It checks that we obtain a new Microdown stream wrapper'
]

{ #category : #tests }
MicHTMLDocTest >> testSetCharSetUTF8 [

	doc charSet: nil.
	self assert: doc charSet isNil.
	
	doc setCharSetUTF8.
	self assert: doc charSet asLowercase  equals: 'utf-8'

]

{ #category : #tests }
MicHTMLDocTest >> testTempFileName [

	self 
		assert: (doc tempFileName isKindOf: String)
		description: 'It test that a temporary file name is of correct class'.
		
	self
		assert: (doc tempFileName endsWith: '.html')
		description: 'It test that a temporary file name should have correct HTML extension'.
		
	self
		deny: doc tempFileName first
		equals: '.'
]

{ #category : #tests }
MicHTMLDocTest >> testWriteBodyContents [

	doc contents: String empty.
	self assert: doc contents isEmpty.
	doc writeBodyContents: 'Prueba'.
	self deny: doc contents isEmpty.
	self assert: (doc contents beginsWith: '<body>').
	self assert: (doc contents endsWith: '</html>')
]

{ #category : #test }
MicHTMLDocTest >> testWriteHeader [

	doc contents: String empty.
	self
		assert: doc contents isEmpty
		description: 'It tests that HTML header is not written yet'.

	doc writeHeader.
	self 
		assert: (doc contents beginsWith: MicHTMLDoc documentType)
		description: 'It tests that HTML header tag is written'.

]
