"
Handle and provides writing methods of additional information (metadata) of a Microdown HTML document:

- A default character set (**charSet**) as UTF-8 by default (**setCharSetUTF8**).
- A language (**languageId**) `String` of element's contents (matches the lang attribute in HTML specification).
- A title `String` acting as document short explanation.
- A `Collection` of Keywords (**keywords**).
- A `Collection` of authors (**authors**), each one being a `String`.
- A `Boolean` parameter which specifies if the CSS will be embeeded or linked.

It also parses Pillar-like headers converting a `Dictionary` of metadata attributes to their equivalent tag in the HTML header.

"
Class {
	#name : 'MicHTMLConfiguration',
	#superclass : 'Object',
	#instVars : [
		'scriptLanguage',
		'targetAttribute',
		'author',
		'charSet',
		'documentType',
		'description',
		'keywords',
		'title',
		'languageId',
		'viewport',
		'document',
		'robots',
		'date',
		'embeedCss'
	],
	#category : 'Microdown-HTMLExporter-Core',
	#package : 'Microdown-HTMLExporter',
	#tag : 'Core'
}

{ #category : 'accessing' }
MicHTMLConfiguration >> author [
	"Answer a <String> representing the author of the receiver"
	
	^ author
		ifNil: [ author := String empty ]
]

{ #category : 'accessing' }
MicHTMLConfiguration >> author: anObject [

	author := anObject
]

{ #category : 'writing - css' }
MicHTMLConfiguration >> beCssEmbedded [
	"Answer the receiver. Set CSS to be inserted into its the receiver's document"

	embeedCss := true
]

{ #category : 'writing - css' }
MicHTMLConfiguration >> beCssLinked [
	"Answer the receiver. Link CSS in the receiver's document"

	embeedCss := false
]

{ #category : 'accessing - robots' }
MicHTMLConfiguration >> beRobotFollow [
	"Instruct search engines to follow all the links in the receiver's document"
	
	self robots add: 'follow'
]

{ #category : 'accessing - robots' }
MicHTMLConfiguration >> beRobotIndex [
	"Instruct search engines to index the whole receiver's document"
	
	self robots add: 'index'
]

{ #category : 'accessing - robots' }
MicHTMLConfiguration >> beRobotNoArchive [
	"Instruct search engines to NOT show a cached copy of the receiver's document"
	
	self robots add: 'noarchive'
]

{ #category : 'accessing - robots' }
MicHTMLConfiguration >> beRobotNoCache [
	"Same as noarchive but only used by MSN/Live"
	
	self robots add: 'nocache'
]

{ #category : 'accessing - robots' }
MicHTMLConfiguration >> beRobotNoFollow [
	"Instruct search engines to NOT follow all the links in the receiver's document"
	
	self robots add: 'nofollow'
]

{ #category : 'accessing - robots' }
MicHTMLConfiguration >> beRobotNoImageIndex [
	"Instruct search engines to NOT index the images in the receiver's document"
	
	self robots add: 'noimageindex'
]

{ #category : 'accessing - robots' }
MicHTMLConfiguration >> beRobotNoIndex [
	"Instruct search engines to NOT index the whole receiver's document"
	
	self robots add: 'noindex'
]

{ #category : 'accessing - robots' }
MicHTMLConfiguration >> beRobotNoSnippet [
	"Prevents the search engines from showing a text or video snippet of this page in the search results, and prevents them from showing a cached copy of this page in their search results listings"
	
	self robots add: 'nosnippet'
]

{ #category : 'accessing - robots' }
MicHTMLConfiguration >> beRobotNoTranslate [
	"Prevents search engines from showing translations of the page in their search results"
	
	self robots add: 'notranslate'
]

{ #category : 'accessing - links' }
MicHTMLConfiguration >> beTargetAttributeBlank [
	"Opens the linked document in a new window or tab (Microdown default)"
	
	self targetAttribute: '_blank'
]

{ #category : 'accessing - links' }
MicHTMLConfiguration >> beTargetAttributeParent [
	"Opens the linked document in the parent frame"
	
	self targetAttribute: '_parent'
]

{ #category : 'accessing - links' }
MicHTMLConfiguration >> beTargetAttributeSelf [
	"Opens the linked document in the same frame as it was clicked (W3C default)"
	
	self targetAttribute: '_self'
]

{ #category : 'accessing - links' }
MicHTMLConfiguration >> beTargetAttributeTop [
	"Opens the linked document in the full body of the window"
	
	self targetAttribute: '_top'
]

{ #category : 'accessing' }
MicHTMLConfiguration >> canvas [
	"Answer the receiver's document <MicHTMLCanvas>"

	^ self document canvas
]

{ #category : 'accessing' }
MicHTMLConfiguration >> charSet [
	"Answer a <String> with specifies the character encoding for the HTML document"

	^ charSet

]

{ #category : 'accessing' }
MicHTMLConfiguration >> charSet: anObject [

	charSet := anObject
]

{ #category : 'writing - css' }
MicHTMLConfiguration >> cssFrameworks [
	"Answer the receiver's <Collection> of <MicCSSEntity>"
	
	^ self document cssFrameworks
]

{ #category : 'accessing' }
MicHTMLConfiguration >> date [
	"Answer a <String> describing the receiver's date"

	^ date
]

{ #category : 'accessing' }
MicHTMLConfiguration >> date: anObject [

	date := anObject
]

{ #category : 'defaults' }
MicHTMLConfiguration >> defaultCharset [
	"Answer a <String> representing the default character set used in a HTML document"
	
	^ 'utf-8'
]

{ #category : 'initialization' }
MicHTMLConfiguration >> defaultDocumentType [
	"Answer a <String> specifying the mandatory document specification tag"

	^ '<!DOCTYPE html>'
]

{ #category : 'defaults' }
MicHTMLConfiguration >> defaultLanguageId [

	^ 'en'
]

{ #category : 'defaults' }
MicHTMLConfiguration >> defaultScriptLanguage [
	"Answer a <PRAbstractScriptLanguage>"

	^ PRRealScriptLanguage for: 'pharo'
]

{ #category : 'defaults' }
MicHTMLConfiguration >> defaultTargetAttribute [
	"By default, opens the linked document in a new window or tab"

	^ '_blank'
]

{ #category : 'defaults' }
MicHTMLConfiguration >> defaultTitle [

	^ 'Untitled document'
]

{ #category : 'defaults' }
MicHTMLConfiguration >> defaultViewport [
	"Answer a <String> to give the browser instructions on how to control the page's dimensions and scaling"

	^ 'width=device-width,initial-scale=1.0,user-scalable=yes'
]

{ #category : 'accessing' }
MicHTMLConfiguration >> description [
	"Answer a <String> which define a description for the receiver"
	
	^ description
		ifNil: [ description := String empty ]
]

{ #category : 'accessing' }
MicHTMLConfiguration >> description: anObject [

	description := anObject
]

{ #category : 'accessing' }
MicHTMLConfiguration >> document [
	"Answer a <MicHTMLDocument> if configured, or nil otherwise"

	^ document

]

{ #category : 'accessing' }
MicHTMLConfiguration >> document: anObject [

	document := anObject
]

{ #category : 'private' }
MicHTMLConfiguration >> documentType [
	"Answer a <String> specifying the mandatory document specification tag"
	
	^ documentType
		ifNil: [ documentType := self defaultDocumentType ]
]

{ #category : 'accessing' }
MicHTMLConfiguration >> documentType: anObject [

	documentType := anObject
]

{ #category : 'initialization' }
MicHTMLConfiguration >> initialize [
	
	super initialize.
	self beCssLinked
]

{ #category : 'testing' }
MicHTMLConfiguration >> isCssEmbedded [

	^ embeedCss
]

{ #category : 'accessing' }
MicHTMLConfiguration >> keywords [
	"Answer a <Collection> of <String> which define keywords for search engines"
	
	^ keywords
		ifNil: [ keywords := OrderedCollection new ]
]

{ #category : 'accessing' }
MicHTMLConfiguration >> keywords: anObject [

	keywords := anObject
]

{ #category : 'accessing' }
MicHTMLConfiguration >> languageId [
	"Answer a <String> representing the target language of the receiver"
	
	^ languageId
		ifNil: [ languageId := self defaultLanguageId ]
]

{ #category : 'accessing' }
MicHTMLConfiguration >> languageId: anObject [

	languageId := anObject
]

{ #category : 'private' }
MicHTMLConfiguration >> metadataSelectorMap [
	"Answer a <Dictionary> mapping Pillar metadata keys to receiver's selectors. Corresponding methods will use the meta HTML tag and write its parameter as value"

	^ { 
		'description' -> #description: .
		'title' -> #title: .
		'author' -> #author: .
		'attribution' -> #author: .
		'date' -> #date:
	} asDictionary
]

{ #category : 'accessing - robots' }
MicHTMLConfiguration >> robots [
	"Answer a <Collection> of <String> with information to control how the receiver's document should be indexed and served"

	^ robots
		ifNil: [ robots := OrderedCollection new ]
]

{ #category : 'accessing' }
MicHTMLConfiguration >> scriptLanguage [

	^ scriptLanguage
]

{ #category : 'accessing' }
MicHTMLConfiguration >> scriptLanguage: anObject [

	scriptLanguage := anObject
]

{ #category : 'accessing - links' }
MicHTMLConfiguration >> targetAttribute [
	"Answer a <String>. The target attribute specifies where to open the linked document."

	^ targetAttribute
		ifNil: [ targetAttribute := self defaultTargetAttribute ]
]

{ #category : 'accessing - links' }
MicHTMLConfiguration >> targetAttribute: aString [
	"Set the receiver's target to be aString"
	
	targetAttribute := aString
]

{ #category : 'accessing' }
MicHTMLConfiguration >> title [
	"Answer a <String> representing the required title element"
	
	^ title
		ifNil: [ title := self defaultTitle ]
]

{ #category : 'accessing' }
MicHTMLConfiguration >> title: anObject [

	title := anObject
]

{ #category : 'accessing' }
MicHTMLConfiguration >> viewport [

	^ viewport 
		ifNil: [ viewport := self defaultViewport ]
]

{ #category : 'accessing' }
MicHTMLConfiguration >> viewport: anObject [

	viewport := anObject
]

{ #category : 'writing - css' }
MicHTMLConfiguration >> writeCssEmbeed [

	self canvas tag
		name: 'style';
		parameterAt: 'type' put: 'text/css';
		with: ((self cssFrameworks collect: #sourceCode) joinUsing: Character cr).
]

{ #category : 'writing - css' }
MicHTMLConfiguration >> writeCssLinked [
	"Add linked CSS resources to the receiver. This does not guarantee the CSS file exists, it only appends the tag to the document header"
	
	self cssFrameworks do: [ : cssFramework | 
		self canvas tag
			name: 'link';
			parameterAt: 'rel' put: 'stylesheet';
			parameterAt: 'href' put: cssFramework cssPath;
			close ]

]

{ #category : 'writing - metadata' }
MicHTMLConfiguration >> writeDocumentAuthor [
	"Set the receiver's authors, who write the content of the document"
	
	self canvas tag
		name: 'meta';
		parameterAt: 'name' put: 'author';
		parameterAt: 'content' put: self author;
		close
]

{ #category : 'writing - css' }
MicHTMLConfiguration >> writeDocumentCSS [
	"Add linked CSS resources to the receiver"

	self isCssEmbedded
		ifFalse: [ self writeCssLinked ]
		ifTrue: [ self writeCssEmbeed ]


]

{ #category : 'writing - metadata' }
MicHTMLConfiguration >> writeDocumentCharSet [
	"Write the character encoding for the receiver"

	self canvas tag
		name: 'meta';
		parameterAt: 'http-equiv' put: 'Content-Type';
		parameterAt: 'content' put: 'text/html; charset=' , self document charSet;
		close.
]

{ #category : 'writing - metadata' }
MicHTMLConfiguration >> writeDocumentDate [
	"Set the receiver's authors, who write the content of the document"
	
	self canvas tag
		name: 'meta';
		parameterAt: 'name' put: 'date';
		parameterAt: 'content' put: self date;
		close
]

{ #category : 'writing - metadata' }
MicHTMLConfiguration >> writeDocumentDescription [
	"Write a description for the receiver"

	self canvas tag
		name: 'description';
		parameterAt: 'content' put: self description;
		close.
]

{ #category : 'writing - metadata' }
MicHTMLConfiguration >> writeDocumentGenerator [
	"Write the automation tool used to generate the page content"

	self canvas tag
		name: 'meta';
		parameterAt: 'name' put: 'generator';
		parameterAt: 'content' put: 'Microdown';
		close.
]

{ #category : 'writing' }
MicHTMLConfiguration >> writeDocumentHead [

	self canvas tag
		name: 'head';
		with: [ 
			self 
				writeDocumentMetadata;
				writeDocumentTitle;
				writeDocumentCSS ]

]

{ #category : 'writing - metadata' }
MicHTMLConfiguration >> writeDocumentKeywords [
	"Set the receiver's page-related keywords, which help for better ranking on search engines"

	self canvas tag
		name: 'meta';
		parameterAt: 'name' put: 'keywords';
		parameterAt: 'content' put: self keywords;
		close
]

{ #category : 'writing - metadata' }
MicHTMLConfiguration >> writeDocumentMetadata [

	self 
		writeDocumentCharSet;
		writeDocumentGenerator;
		writeDocumentViewport
]

{ #category : 'writing - metadata' }
MicHTMLConfiguration >> writeDocumentRobots [
	"Set the receiver's robot’s values, which gives instructions to search engines how the web page should be indexed or not"
	
	self canvas tag
		name: 'meta';
		parameterAt: 'name' put: 'robots';
		parameterAt: 'content' put: (self robots joinUsing: ', ');
		close
]

{ #category : 'writing' }
MicHTMLConfiguration >> writeDocumentTitle [
	"Write the mandatory title tag which defines the title of the receiver"

	self canvas tag
		name: 'title';
		with: self title
]

{ #category : 'writing' }
MicHTMLConfiguration >> writeDocumentType [
	"Write the mandatory DOCTYPE HTML declaration in the receiver"

	self canvas raw: self documentType

]

{ #category : 'writing - metadata' }
MicHTMLConfiguration >> writeDocumentViewport [
	"Set the receiver's visible area to look good on all devices"
	
	self canvas tag
		name: 'meta';
		parameterAt: 'name' put: 'viewport';
		parameterAt: 'content' put: self viewport;
		close
]

{ #category : 'writing' }
MicHTMLConfiguration >> writeFromMetadataAssociation: anAssociation [ 

	anAssociation key = 'metadata'
		ifTrue: [ self writeHeaderFromMetadata: anAssociation value ]
		ifFalse: [ self writeHeaderFromMetadataAssociation: anAssociation ]
]

{ #category : 'private' }
MicHTMLConfiguration >> writeHeaderFromMetadata: aDictionary [ 

	aDictionary associationsDo: [ : assoc |
		self writeHeaderFromMetadataAssociation: assoc ]

]

{ #category : 'private' }
MicHTMLConfiguration >> writeHeaderFromMetadataAssociation: anAssociation [ 

	self metadataSelectorMap associationsDo: [ : metaSelectorPair | 
			metaSelectorPair key = anAssociation key asLowercase
				ifTrue: [ self perform: metaSelectorPair value with: anAssociation value ] ]

]
