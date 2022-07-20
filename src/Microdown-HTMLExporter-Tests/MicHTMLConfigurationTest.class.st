"
A MicHTMLConfigurationTest is a test class for testing the behavior of MicHTMLConfiguration
"
Class {
	#name : #MicHTMLConfigurationTest,
	#superclass : #MicHTMLDocTest,
	#instVars : [
		'configuration'
	],
	#category : #'Microdown-HTMLExporter-Tests-HTML'
}

{ #category : #running }
MicHTMLConfigurationTest >> setUp [

	super setUp.
	configuration := MicHTMLConfiguration new 
		document: doc;
		yourself
]

{ #category : #tests }
MicHTMLConfigurationTest >> testBeTargetAttributeBlank [

	configuration beTargetAttributeBlank.
	self assert: configuration targetAttribute equals: '_blank'.
]

{ #category : #tests }
MicHTMLConfigurationTest >> testBeTargetAttributeParent [

	configuration beTargetAttributeParent.
	self assert: configuration targetAttribute equals: '_parent'.
]

{ #category : #tests }
MicHTMLConfigurationTest >> testBeTargetAttributeSelf [

	configuration beTargetAttributeSelf.
	self assert: configuration targetAttribute equals: '_self'.
]

{ #category : #tests }
MicHTMLConfigurationTest >> testBeTargetAttributeTop [

	configuration beTargetAttributeTop.
	self assert: configuration targetAttribute equals: '_top'.
]

{ #category : #test }
MicHTMLConfigurationTest >> testDefaultDocumentType [

	self 
		assert: (configuration defaultDocumentType isKindOf: String)
		description: 'It tests that the default document type identifier is a String'.

]

{ #category : #tests }
MicHTMLConfigurationTest >> testDefaultLanguageId [

	self
		assert: (configuration defaultLanguageId isKindOf: String)
		description: 'It test that the default language identifier is a String'.
		
	self
		assert: configuration defaultLanguageId notEmpty
		description: 'It test that the default language identifier is not empty'
]

{ #category : #tests }
MicHTMLConfigurationTest >> testDefaultScriptLanguage [

	self
		assert: (configuration defaultScriptLanguage isKindOf: PRAbstractScriptLanguage)
		description: 'It test that the default script language of a document is a PRAbstractScriptLanguage'.
		

]

{ #category : #tests }
MicHTMLConfigurationTest >> testDefaultTitle [

	self
		assert: (configuration defaultTitle isKindOf: String)
		description: 'It test that the default title of a document is a String'.
		

]

{ #category : #tests }
MicHTMLConfigurationTest >> testDefaultViewport [

	self
		assert: (configuration defaultViewport isKindOf: String)
		description: 'It test that the default viewport of a document is a String'.
		

]

{ #category : #tests }
MicHTMLConfigurationTest >> testWriteDocumentAuthor [

	| parsedContents metaElements |

	configuration author: 'Alex Lifeson'.
	configuration writeDocumentAuthor.
	self deny: doc contents isEmpty.
	self assert: (doc contents beginsWith: '<meta').
	parsedContents := (XMLHTMLParser on: doc contents) parseDocument.
	metaElements := parsedContents descendantElementsNamed: 'meta'.

	self
		assert: ((metaElements elementsDetect: [ : e | (e attributeNodeAt: 'name') value = 'author' ]) attributeAt: 'content')
		equals: 'Alex Lifeson'.


]

{ #category : #tests }
MicHTMLConfigurationTest >> testWriteDocumentCSS [

	| parsedContents linkElements |
	
	doc addCSSNamed: self sampleMicCSSName.
	configuration writeDocumentCSS.
	self deny: doc contents isEmpty.

	doc addCSSNamed: self sampleMicCSSName.
	parsedContents := (XMLHTMLParser on: doc contents) parseDocument.
	linkElements := parsedContents descendantElementsNamed: 'link'.

	self
		assert: ((linkElements elementsDetect: [ : e | e includesAttribute: 'rel' ]) attributeAt: 'href')
		equals: 'css/awsm.css'.


]

{ #category : #tests }
MicHTMLConfigurationTest >> testWriteDocumentCharSet [

	| parsedTag |

	configuration writeDocumentCharSet.
	self deny: doc contents isEmpty.

	parsedTag := (doc contents copyWithoutAll: '<">') substrings.
	self assert: (parsedTag includes: 'charset=' , doc charSet)
]

{ #category : #tests }
MicHTMLConfigurationTest >> testWriteDocumentDate [

	| parsedContents metaElements |

	configuration date: Date today asString.
	configuration writeDocumentDate.
	self deny: doc contents isEmpty.
	self assert: (doc contents beginsWith: '<meta').
	parsedContents := (XMLHTMLParser on: doc contents) parseDocument.
	metaElements := parsedContents descendantElementsNamed: 'meta'.

	self
		assert: ((metaElements elementsDetect: [ : e | (e attributeNodeAt: 'name') value = 'date' ]) attributeAt: 'content')
		equals: Date today asString.


]

{ #category : #tests }
MicHTMLConfigurationTest >> testWriteDocumentDescription [

	| parsedTag |

	configuration writeDocumentDescription.
	self deny: doc contents isEmpty.

	parsedTag := (doc contents copyWithoutAll: '<">') substrings.
	self assert: (parsedTag includes: 'content=' , doc description ).	
]

{ #category : #tests }
MicHTMLConfigurationTest >> testWriteDocumentGenerator [

	| parsedTag |

	configuration writeDocumentGenerator.
	self deny: doc contents isEmpty.

	parsedTag := (doc contents copyWithoutAll: '<">') substrings.
	self assert: (parsedTag includes: 'name=generator').
	self assert: (parsedTag includes: 'content=Microdown' ).	
]

{ #category : #tests }
MicHTMLConfigurationTest >> testWriteDocumentHead [

	configuration writeDocumentHead.
	self deny: doc contents isEmpty.
	self assert: (doc contents beginsWith: '<head>').
	self assert: (doc contents endsWith: '</head>')
]

{ #category : #tests }
MicHTMLConfigurationTest >> testWriteDocumentKeywords [

	| parsedContents metaElements |

	configuration keywords: 'keyword1, keyword2, keyword3'.
	configuration writeDocumentKeywords.
	self deny: doc contents isEmpty.
	self assert: (doc contents beginsWith: '<meta').
	parsedContents := (XMLHTMLParser on: doc contents) parseDocument.
	metaElements := parsedContents descendantElementsNamed: 'meta'.

	self
		assert: ((metaElements elementsDetect: [ : e | (e attributeNodeAt: 'name') value = 'keywords' ]) attributeAt: 'content')
		equals: 'keyword1, keyword2, keyword3'.


]

{ #category : #tests }
MicHTMLConfigurationTest >> testWriteDocumentMetadata [

	| parsedContents metaElements |

	configuration writeDocumentMetadata.
	self deny: doc contents isEmpty.
	self assert: (doc contents beginsWith: '<meta').
	parsedContents := (XMLHTMLParser on: doc contents) parseDocument.
	metaElements := parsedContents descendantElementsNamed: 'meta'.

	self
		assert: ((metaElements elementsDetect: [ : e | e includesAttribute: 'http-equiv' ]) attributeAt: 'content')
		equals: 'text/html; charset=utf-8'.
	self
		assert: ((metaElements elementsDetect: [ : e | (e attributeNodeAt: 'name') value = 'generator' ]) attributeAt: 'content')
		equals: 'Microdown'.
	self
		assert: ((metaElements elementsDetect: [ : e | (e attributeNodeAt: 'name') value = 'viewport' ]) attributeAt: 'content')
		equals: 'width=device-width,initial-scale=1.0,user-scalable=yes'.

]

{ #category : #tests }
MicHTMLConfigurationTest >> testWriteDocumentRobots [

	| parsedContents metaElements |

	configuration beRobotNoFollow; beRobotNoIndex.
	configuration writeDocumentRobots.
	self deny: doc contents isEmpty.
	self assert: (doc contents beginsWith: '<meta').
	parsedContents := (XMLHTMLParser on: doc contents) parseDocument.
	metaElements := parsedContents descendantElementsNamed: 'meta'.

	self
		assert: ((metaElements elementsDetect: [ : e | (e attributeNodeAt: 'name') value = 'robots' ]) attributeAt: 'content')
		equals: 'nofollow, noindex'.


]

{ #category : #tests }
MicHTMLConfigurationTest >> testWriteDocumentTitle [

	configuration writeDocumentTitle.
	self deny: doc contents isEmpty.
	
	self assert: (doc contents beginsWith: '<title>').
	self assert: (doc contents endsWith: '</title>')

]

{ #category : #tests }
MicHTMLConfigurationTest >> testWriteDocumentType [

	configuration writeDocumentType.
	self deny: doc contents isEmpty.
	
	self 
		assert: doc contents
		equals: doc documentType.

]

{ #category : #tests }
MicHTMLConfigurationTest >> testWriteDocumentViewport [

	| parsedTag |

	configuration writeDocumentViewport.
	self deny: doc contents isEmpty.

	parsedTag := (doc contents copyWithoutAll: '<">') substrings.
	self assert: (parsedTag includes: 'name=viewport').	
	self assert: (parsedTag includes: 'content=' , configuration viewport).	
]
