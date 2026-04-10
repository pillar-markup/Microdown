"
A MicHTMLConfigurationTest is a test class for testing the behavior of MicHTMLConfiguration
"
Class {
	#name : 'MicHTMLConfigurationTest',
	#superclass : 'MicHTMLDocumentTest',
	#instVars : [
		'configuration'
	],
	#category : 'Microdown-HTMLExporter-Tests-HTML',
	#package : 'Microdown-HTMLExporter-Tests',
	#tag : 'HTML'
}

{ #category : 'tests' }
MicHTMLConfigurationTest >> docTypeOptions [

	^ #('<!DOCTYPE html>'

'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" 
"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">'

'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'

'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">'

 '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">'
		
'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">'
	
'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN"
"http://www.w3.org/TR/html4/frameset.dtd">'

'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">'
		
 '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">'
		
'<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0 Strict Level 2//EN">')
]

{ #category : 'running' }
MicHTMLConfigurationTest >> setUp [

	super setUp.
	configuration := MicHTMLConfiguration new 
		document: doc;
		yourself
]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testAuthor [

	self
		assert: (configuration author isKindOf: String)
		description: 'It test that a configuration by default has an empty author'.
		
	configuration author: 'Steve Vai'.

	self
		assert: configuration author
		equals: 'Steve Vai'.

]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testBeCssEmbedded [

	self
		deny: configuration isCssEmbedded
		description: 'It test that by default a configuration is linked'.
		
	configuration beCssEmbedded.

	self
		assert: configuration isCssEmbedded
		description: 'It test that by a configuration is now embedded'.

]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testBeCssLinked [

	configuration beCssEmbedded.
	
	self
		assert: configuration isCssEmbedded
		description: 'It test that a configuration is embedded'.
		
	configuration beCssLinked.

	self
		deny: configuration isCssEmbedded
		equals: 'It test that by a configuration is now linked'.

]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testBeRobotFollow [

	self
		assert: configuration robots isEmpty
		description: 'It test that a configuration has no instructions for robots'.
		
	configuration beRobotFollow.

	self
		assertCollection: configuration robots
		hasSameElements: #('follow').


]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testBeRobotIndex [

	self
		assert: configuration robots isEmpty
		description: 'It test that a configuration has no instructions for robots'.
		
	configuration beRobotIndex.

	self
		assertCollection: configuration robots
		hasSameElements: #('index').


]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testBeRobotNoArchive [

	self
		assert: configuration robots isEmpty
		description: 'It test that a configuration has no instructions for robots'.
		
	configuration beRobotNoArchive.

	self
		assertCollection: configuration robots
		hasSameElements: #('noarchive').


]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testBeRobotNoCache [

	self
		assert: configuration robots isEmpty
		description: 'It test that a configuration has no instructions for robots'.
		
	configuration beRobotNoCache.

	self
		assertCollection: configuration robots
		hasSameElements: #('nocache').


]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testBeRobotNoFollow [

	self
		assert: configuration robots isEmpty
		description: 'It test that a configuration has no instructions for robots'.
		
	configuration beRobotNoFollow.

	self
		assertCollection: configuration robots
		hasSameElements: #('nofollow').


]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testBeRobotNoImageIndex [

	self
		assert: configuration robots isEmpty
		description: 'It test that a configuration has no instructions for robots'.
		
	configuration beRobotNoImageIndex.

	self
		assertCollection: configuration robots
		hasSameElements: #('noimageindex').


]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testBeRobotNoIndex [

	self
		assert: configuration robots isEmpty
		description: 'It test that a configuration has no instructions for robots'.
		
	configuration beRobotNoIndex.

	self
		assertCollection: configuration robots
		hasSameElements: #('noindex').


]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testBeRobotNoSnippet [

	self
		assert: configuration robots isEmpty
		description: 'It test that a configuration has no instructions for robots'.
		
	configuration beRobotNoSnippet.

	self
		assertCollection: configuration robots
		hasSameElements: #('nosnippet').


]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testBeRobotNoTranslate [

	self
		assert: configuration robots isEmpty
		description: 'It test that a configuration has no instructions for robots'.
		
	configuration beRobotNoTranslate.

	self
		assertCollection: configuration robots
		hasSameElements: #('notranslate').


]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testBeTargetAttributeBlank [

	configuration beTargetAttributeBlank.
	self assert: configuration targetAttribute equals: '_blank'.
]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testBeTargetAttributeParent [

	configuration beTargetAttributeParent.
	self assert: configuration targetAttribute equals: '_parent'.
]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testBeTargetAttributeSelf [

	configuration beTargetAttributeSelf.
	self assert: configuration targetAttribute equals: '_self'.
]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testBeTargetAttributeTop [

	configuration beTargetAttributeTop.
	self assert: configuration targetAttribute equals: '_top'.
]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testCssFrameworks [

	self
		assert: (configuration cssFrameworks isKindOf: Collection)
		description: 'It test that the contained CSS files is a Collection'.
		
	self
		assert: configuration cssFrameworks isEmpty
		description: 'It test that the contained CSS files collection is empty'
]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testDate [

	self
		assert: configuration date isNil
		description: 'It test that by default a configuration have no date assigned'.
		
	configuration date: '9 August 2022'.

	self
		assert: configuration date
		equals: '9 August 2022'.

]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testDefaultCharset [

	self
		assert: (configuration defaultCharset isKindOf: String)
		description: 'It test that the default character set of a document is a String'.
		
	self
		assert: configuration defaultCharset 
		equals: 'utf-8'
]

{ #category : 'test' }
MicHTMLConfigurationTest >> testDefaultDocumentType [

	self 
		assert: (configuration defaultDocumentType isKindOf: String)
		description: 'It tests that the default document type identifier is a String'.

]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testDefaultLanguageId [

	self
		assert: (configuration defaultLanguageId isKindOf: String)
		description: 'It test that the default language identifier is a String'.
		
	self
		assert: configuration defaultLanguageId notEmpty
		description: 'It test that the default language identifier is not empty'
]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testDefaultTargetAttribute [

	| validTargetAttributes |
	self
		assert: (configuration defaultTargetAttribute isKindOf: String)
		description: 'It test that a default configuration target is a String'.
		
	validTargetAttributes := #('_blank' '_parent' '_self' '_top').

	self
		assert: (validTargetAttributes includes: configuration defaultTargetAttribute)
		description: 'It test a target should be one of the valid types'		

]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testDefaultTitle [

	self
		assert: (configuration defaultTitle isKindOf: String)
		description: 'It test that the default title of a document is a String'.
		

]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testDefaultViewport [

	self
		assert: (configuration defaultViewport isKindOf: String)
		description: 'It test that the default viewport of a document is a String'.
		

]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testDescription [

	self
		assert: configuration description isEmpty
		description: 'It test that a configuration has no default description'.
		
	configuration description: 'My cool HTML document'.

	self
		assert: configuration description
		equals: 'My cool HTML document'.


]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testDocument [

	self
		assert: (configuration document isKindOf: MicHTMLDocument)
		description: 'It test a configuration has a MicHTMLDocument'.
		
	configuration document: nil.

	self
		assert: configuration document isNil
		description: 'It test that now configuration does not have a related HTML document'.
		

]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testDocumentType [

	self 
		assert: (configuration documentType isKindOf: String)
		description: 'The document type should be described as String'.
		
	configuration documentType: '<!DOCTYPE html>'.

	self
		assert: (self docTypeOptions includes: configuration documentType)


]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testIsCssEmbedded [

	self deny: configuration isCssEmbedded.
	
	configuration beCssEmbedded.
	
	self assert: configuration isCssEmbedded
]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testKeywords [

	self
		assert: (configuration keywords isKindOf: Collection)
		description: 'It test that the keywords of a document is a Collection'.
	
	self
		assert: configuration keywords isEmpty
		description: 'It test that the default keywords of a document is empty'.

	configuration keywords: #('keyword1' 'keyword2').
	
	self
		assertCollection: configuration keywords
		equals: #('keyword1' 'keyword2').

						

]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testLanguageId [

	self
		assert: (configuration languageId isKindOf: String)
		description: 'It test that the language identifier of a document is a String'.
	
	doc languageId: 'es'.
	
	self
		assert: doc languageId
		equals: 'es'

]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testMetadataSelectorMap [

	self
		assert: (configuration metadataSelectorMap isKindOf: Dictionary)
		description: 'It test that the metadata mapping to selectors is a Dictionary'.
	
	self
		deny: configuration metadataSelectorMap isEmpty
		description: 'It test that the metadata mapping to selectors is not empty'.

]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testRobots [

	self
		assert: (configuration robots isKindOf: Collection)
		description: 'It test that robots are a collection'.

	self
		assert: configuration robots isEmpty
		description: 'It test that we have no instructions for robots by default'.
		
	configuration beRobotIndex.
	
	self
		assert: (configuration robots size = 1)
		description: 'It test that there is at least one instruction for robots'.
		
	configuration beRobotNoCache.
	
	self
		assert: configuration robots size
		equals: 2

						

]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testTitle [

	self 
		assert: (configuration title isKindOf: String)
		description: 'The document title should be described as String'.
		
	configuration title: 'Hello Microdown'.

	self
		assert: configuration title
		equals: 'Hello Microdown'.


]

{ #category : 'tests' }
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

{ #category : 'tests' }
MicHTMLConfigurationTest >> testWriteDocumentCSS [

	"| parsedContents linkElements |"
	
	self skip.
	"Need to think about creating referenced CSS files on the fly/on demand"
	"doc addCSSNamed: self sampleMicCSSName.
	configuration writeDocumentCSS.
	self deny: doc contents isEmpty.

	doc addCSSNamed: self sampleMicCSSName.
	parsedContents := (XMLHTMLParser on: doc contents) parseDocument.
	linkElements := parsedContents descendantElementsNamed: 'link'.

	self
		assert: ((linkElements elementsDetect: [ : e | e includesAttribute: 'rel' ]) attributeAt: 'href')
		equals: 'css/awsm.css'."


]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testWriteDocumentCharSet [

	| parsedTag |

	configuration writeDocumentCharSet.
	self deny: doc contents isEmpty.

	parsedTag := (doc contents copyWithoutAll: '<">') substrings.
	self assert: (parsedTag includes: 'charset=' , doc charSet)
]

{ #category : 'tests' }
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

{ #category : 'tests' }
MicHTMLConfigurationTest >> testWriteDocumentDescription [

	| parsedTag |

	configuration writeDocumentDescription.
	self deny: doc contents isEmpty.

	parsedTag := (doc contents copyWithoutAll: '<">') substrings.
	self assert: (parsedTag includes: 'content=' , doc description ).	
]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testWriteDocumentGenerator [

	| parsedTag |

	configuration writeDocumentGenerator.
	self deny: doc contents isEmpty.

	parsedTag := (doc contents copyWithoutAll: '<">') substrings.
	self assert: (parsedTag includes: 'name=generator').
	self assert: (parsedTag includes: 'content=Microdown' ).	
]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testWriteDocumentHead [

	configuration writeDocumentHead.
	self deny: doc contents isEmpty.
	self assert: (doc contents beginsWith: '<head>').
	self assert: (doc contents endsWith: '</head>')
]

{ #category : 'tests' }
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

{ #category : 'tests' }
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

{ #category : 'tests' }
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

{ #category : 'tests' }
MicHTMLConfigurationTest >> testWriteDocumentTitle [

	configuration writeDocumentTitle.
	self deny: doc contents isEmpty.
	
	self assert: (doc contents beginsWith: '<title>').
	self assert: (doc contents endsWith: '</title>')

]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testWriteDocumentType [

	configuration writeDocumentType.
	self deny: doc contents isEmpty.
	
	self 
		assert: doc contents
		equals: doc documentType.

]

{ #category : 'tests' }
MicHTMLConfigurationTest >> testWriteDocumentViewport [

	| parsedTag |

	configuration writeDocumentViewport.
	self deny: doc contents isEmpty.

	parsedTag := (doc contents copyWithoutAll: '<">') substrings.
	self assert: (parsedTag includes: 'name=viewport').	
	self assert: (parsedTag includes: 'content=' , configuration viewport).	
]
