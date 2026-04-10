Class {
	#name : 'MicHTMLDocumentTest',
	#superclass : 'TestCase',
	#instVars : [
		'doc',
		'docString'
	],
	#category : 'Microdown-HTMLExporter-Tests-HTML',
	#package : 'Microdown-HTMLExporter-Tests',
	#tag : 'HTML'
}

{ #category : 'tests' }
MicHTMLDocumentTest class >> resources [

	^ Array with: MicCSSFileResource
]

{ #category : 'helpers' }
MicHTMLDocumentTest >> sampleHTMLBody [

	^ MicDocFactory exampleMicAsHTMLBodyString
]

{ #category : 'helpers' }
MicHTMLDocumentTest >> sampleMicCSSFile [

	^ MicCSSFileResource current micCSSFile
]

{ #category : 'helpers' }
MicHTMLDocumentTest >> sampleMicCSSName [

	^ MicCSSProvider defaultFramework
]

{ #category : 'running' }
MicHTMLDocumentTest >> setUp [
	
	super setUp.
	docString := self sampleHTMLBody.
	doc := MicHTMLDocument new.

]

{ #category : 'running' }
MicHTMLDocumentTest >> tearDown [ 

	doc fullName asFileReference ensureDelete.
	super tearDown.
]

{ #category : 'tests' }
MicHTMLDocumentTest >> testAddCSSNamed [

	|micCSSFrw |

	micCSSFrw := doc addCSSNamed: self sampleMicCSSName.
	self
		assertCollection: doc cssFrameworks
		hasSameElements: { micCSSFrw }
		

]

{ #category : 'tests' }
MicHTMLDocumentTest >> testAuthor [

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

{ #category : 'tests' }
MicHTMLDocumentTest >> testCanvasClass [

	self
		assert: (doc canvasClass = MicHTMLCanvas)
		description: 'It tests that the canvas class of a document is a HTML canvas' 
]

{ #category : 'tests' }
MicHTMLDocumentTest >> testCharSet [

	self 
		assert: (doc charSet isKindOf: String)
		description: 'It tests that the charSet identifier is a String'.
		
	self
		assert: doc charSet isNotNil
		description: 'It test that the document charset has beed initialized'.

	
]

{ #category : 'tests' }
MicHTMLDocumentTest >> testConfiguration [

	self 
		assert: (doc configuration isKindOf: MicHTMLConfiguration)
		description: 'It tests that the configuration is a MicHTMLConfiguration'.

]

{ #category : 'tests' }
MicHTMLDocumentTest >> testContents [

	self 
		assert: (doc contents isKindOf: String) 
		description: 'It test that a HTML document contents contains a String'.

	self 
		assert: doc contents isEmpty
		description: 'It test that a HTML document contents is not empty'.
]

{ #category : 'tests' }
MicHTMLDocumentTest >> testCssFrameworks [

	self
		assert: (doc cssFrameworks isKindOf: Collection)
		description: 'It test that the contained CSS files is a Collection'.
		
	self
		assert: doc cssFrameworks isEmpty
		description: 'It test that the contained CSS files collection is empty'
]

{ #category : 'tests' }
MicHTMLDocumentTest >> testDescription [

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

{ #category : 'tests' }
MicHTMLDocumentTest >> testDestinationPath [

	self assert: (doc destinationPath isKindOf: String).
	self deny: doc destinationPath isEmpty.

]

{ #category : 'tests' }
MicHTMLDocumentTest >> testDocumentType [

	self 
		assert: (doc documentType isKindOf: String)
		description: 'The document type should be described as String'.
		
	doc documentType: ''.

	self
		assert: doc documentType
		equals: String empty
]

{ #category : 'tests' }
MicHTMLDocumentTest >> testExists [

	self 
		deny: doc exists 
		description: 'It tests the document has not been yet created'.
	doc writeToFile.
	self
		assert: doc exists
		description: 'It tests the document has been created'
]

{ #category : 'tests' }
MicHTMLDocumentTest >> testFileName [

	self 
		assert: doc fileName = 'index.html'
		description: 'A document default file name is index.html'.

]

{ #category : 'tests' }
MicHTMLDocumentTest >> testFromMicrodown [

	| html |
	
	html := doc fromMicrodown: MicDocFactory exampleMic.
	self
		deny: html contents isEmpty.
]

{ #category : 'tests' }
MicHTMLDocumentTest >> testKeywords [

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

{ #category : 'tests' }
MicHTMLDocumentTest >> testLanguageId [

	self
		assert: (doc languageId isKindOf: String)
		description: 'It test that the language identifier of a document is a String'.
	
	doc languageId: 'es'.
	
	self
		assert: doc languageId
		equals: 'es'
]

{ #category : 'tests' }
MicHTMLDocumentTest >> testNewMicStreamOn [

	self 
		assert: ((doc newMicStreamOn: String empty) isKindOf: MicOutputStream)
		description: 'It checks that we obtain a new Microdown stream wrapper'
]

{ #category : 'tests' }
MicHTMLDocumentTest >> testSetCharSetUTF8 [

	doc charSet: nil.
	self assert: doc charSet isNil.
	
	doc setCharSetUTF8.
	self assert: doc charSet asLowercase  equals: 'utf-8'

]

{ #category : 'tests' }
MicHTMLDocumentTest >> testTempFileName [

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

{ #category : 'tests' }
MicHTMLDocumentTest >> testTitle [

	self
		assert: (doc title isKindOf: String)
		description: 'It test that the title of a document is a String'.
		
	self
		assert: doc title notEmpty
		description: 'It test that the default title of a document is not empty'
]

{ #category : 'tests' }
MicHTMLDocumentTest >> testWriteDocument [

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

{ #category : 'tests' }
MicHTMLDocumentTest >> testWriteDocumentBody [

	doc writeDocumentBody: 'Prueba'.
	self deny: doc contents isEmpty.
	self assert: (doc contents beginsWith: '<body>').
	self assert: (doc contents endsWith: '</body>')
]

{ #category : 'tests' }
MicHTMLDocumentTest >> testWriteToFile [

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

{ #category : 'tests' }
MicHTMLDocumentTest >> testWriteToFileNamed [

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
