Class {
	#name : #MicHTMLDocTest,
	#superclass : #TestCase,
	#instVars : [
		'doc',
		'docString'
	],
	#category : #'Microdown-HTMLExporter-Tests-HTML'
}

{ #category : #tests }
MicHTMLDocTest class >> resources [

	^ Array with: MicCSSFileResource
]

{ #category : #running }
MicHTMLDocTest >> sampleHTMLBody [

	^ MicDocFactory exampleMicAsHTMLBodyString
]

{ #category : #tests }
MicHTMLDocTest >> sampleMicCSSFile [

	^ MicCSSFileResource current micCSSFile
]

{ #category : #tests }
MicHTMLDocTest >> sampleMicCSSName [

	^ MicCSSProvider defaultFramework
]

{ #category : #running }
MicHTMLDocTest >> setUp [
	
	super setUp.
	docString := self sampleHTMLBody.
	doc := MicHTMLDoc new.

]

{ #category : #tests }
MicHTMLDocTest >> tearDown [ 

	super tearDown.
	doc fullName asFileReference ensureDelete
]

{ #category : #tests }
MicHTMLDocTest >> testAddCSSNamed [

	|micCSSFrw |

	micCSSFrw := doc addCSSNamed: self sampleMicCSSName.
	self
		assertCollection: doc cssFrameworks
		hasSameElements: { micCSSFrw }
		

]

{ #category : #tests }
MicHTMLDocTest >> testAuthor [

	self
		assert: (doc author isKindOf: String)
		description: 'It test that the author of a document is a String'.
		
	self
		assert: doc author isEmpty
		description: 'It test that the default author of a document is empty'.
		
	doc author: 'Nicole Neumann'.
	self 
		assert: doc author
		equals: 'Nicole Neumann'
]

{ #category : #tests }
MicHTMLDocTest >> testCanvasClass [

	self
		assert: (doc canvasClass = MicHTMLCanvas)
		description: 'It tests that the canvas class of a document is a HTML canvas' 
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
MicHTMLDocTest >> testConfiguration [

	self 
		assert: (doc configuration isKindOf: MicHTMLConfiguration)
		description: 'It tests that the configuration is a MicHTMLConfiguration'.

]

{ #category : #tests }
MicHTMLDocTest >> testContents [

	self 
		assert: (doc contents isKindOf: String) 
		description: 'It test that a HTML document contents contains a String'.

	self 
		assert: doc contents isEmpty
		description: 'It test that a HTML document contents is not empty'.
]

{ #category : #tests }
MicHTMLDocTest >> testCssFrameworks [

	self
		assert: (doc cssFrameworks isKindOf: Collection)
		description: 'It test that the contained CSS files is a Collection'.
		
	self
		assert: doc cssFrameworks isEmpty
		description: 'It test that the contained CSS files collection is empty'
]

{ #category : #tests }
MicHTMLDocTest >> testDescription [

	| sampleDescription |
	
	sampleDescription := 'Sample Microdown HTML document'.
	self
		assert: (doc description isKindOf: String)
		description: 'It test that the description is a String'.
		
	doc description: sampleDescription.
	self
		assert: doc description
		equals: sampleDescription
]

{ #category : #tests }
MicHTMLDocTest >> testDestinationPath [

	self assert: (doc destinationPath isKindOf: String).
	self deny: doc destinationPath isEmpty.

]

{ #category : #tests }
MicHTMLDocTest >> testDocumentType [

	self 
		assert: (doc documentType isKindOf: String)
		description: 'The document type should be described as String'.
		
	doc documentType: ''.

	self
		assert: doc documentType
		equals: String empty
]

{ #category : #tests }
MicHTMLDocTest >> testExists [

	self 
		deny: doc exists 
		description: 'It tests the document has not been yet created'.
	doc writeToFile.
	self
		assert: doc exists
		description: 'It tests the document has been created'
]

{ #category : #tests }
MicHTMLDocTest >> testFileName [

	self 
		assert: doc fileName = 'index.html'
		description: 'A document default file name is index.html'.

]

{ #category : #tests }
MicHTMLDocTest >> testFromMicrodown [

	| html |
	
	html := doc fromMicrodown: MicDocFactory exampleMic.
	self
		deny: html contents isEmpty.
]

{ #category : #tests }
MicHTMLDocTest >> testKeywords [

	self
		assert: (doc keywords isKindOf: Collection)
		description: 'It test that the keywords of a document is a Collection'.
	
	self
		assert: doc keywords isEmpty
		description: 'It test that the default keywords of a document is empty'.

	doc keywords: #('keyword1' 'keyword2').
	
	self
		assertCollection: doc keywords
		equals: #('keyword1' 'keyword2').						

]

{ #category : #tests }
MicHTMLDocTest >> testLanguageId [

	self
		assert: (doc languageId isKindOf: String)
		description: 'It test that the language identifier of a document is a String'.
	
	doc languageId: 'es'.
	
	self
		assert: doc languageId
		equals: 'es'
]

{ #category : #tests }
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
MicHTMLDocTest >> testTitle [

	self
		assert: (doc title isKindOf: String)
		description: 'It test that the title of a document is a String'.
		
	self
		assert: doc title notEmpty
		description: 'It test that the default title of a document is not empty'
]

{ #category : #tests }
MicHTMLDocTest >> testWriteDocument [

	| parsedContents |
	doc writeDocument: 'Prueba'.
	self deny: doc contents isEmpty.
	self assert: (doc contents beginsWith: '<!DOCTYPE html>').
	self assert: (doc contents endsWith: '</html>').
	parsedContents := (XMLHTMLParser on: doc contents) parseDocument.
	self
		assert: ((parsedContents descendantElementsNamed: 'body') contentStringAt: 'body')
		equals: 'Prueba'
]

{ #category : #tests }
MicHTMLDocTest >> testWriteDocumentBody [

	doc writeDocumentBody: 'Prueba'.
	self deny: doc contents isEmpty.
	self assert: (doc contents beginsWith: '<body>').
	self assert: (doc contents endsWith: '</body>')
]

{ #category : #tests }
MicHTMLDocTest >> testWriteToFile [

	| fileName file wd |
	
	fileName := 'index.html'.
	wd := FileSystem memory workingDirectory / 'testDir'.
	file := wd / fileName.

	doc 
		destinationPath: wd;
		writeToFile.

	self 
		assert: file exists
		description: 'It tests that the document was created'.
	self 
		assert: file basename
		equals: fileName.
	wd ensureDeleteAllChildren.
]

{ #category : #tests }
MicHTMLDocTest >> testWriteToFileNamed [

	| fileName file wd |
	
	fileName := 'sampleFile.html'.
	wd := FileSystem memory workingDirectory / 'testDir'.
	file := wd / fileName.

	doc 
		destinationPath: wd;
		writeToFileNamed: fileName.

	self 
		assert: file exists
		description: 'It tests that the document was created'.
	self 
		assert: file basename
		equals: fileName.
	wd ensureDeleteAllChildren.
]
