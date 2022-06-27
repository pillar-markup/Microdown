"
Represents a Text/HTML file to be displayed in a web browser. It can be created with a CSS style **newWithStyle:**, and passing a `Microdown` content String through **fromMicrodown:** as parameter.

## Example

The following generates a HTML String from Microdown contents:

```language=Pharo
(MicHTMLDoc newWithStyle: 'tufte') 
	fromMicrodown: MicDocFactory exampleMic;
	contents.
```

Select and inspect the following:

```language=Pharo
MicCSSProvider libraryNames.
```

to see a list of available CSS libraries.

## Description

A document has multiple properties which can be configured:

- A **fileName** `String`.
- A `Collection` of CSS files to define the look of the document, through **addCSSFile:**.
- A default character set (**charSet**) as UTF-8 by default (**setCharSetUTF8**)..
- A language (**languageId**) `String` of element's contents (matches the lang attribute in HTML specification).
- A title `String` acting as document short explanation.
- A `Collection` of Keywords (**keywords**).
- A `Collection` of authors (**authors**), each one being a `String`.
- A destination directory (**destinationDir**) representing the output path of the document.

A Microdown HTML document can receive as input a raw HTML String, without any surrounding header tags, and it builds a header and body tags around it.


## Internals

Internally some properties are configured by default:

- A canvas which acts as a brush to render content.
- The viewport, specified in **defaultViewport**, to control layout in mobile browsers.
- The language identifier is set by default to 'en' (English).
- A subdirectory where the linked CSS files are stored, specified in `MicHTMLDoc >> cssBasePath`.

"
Class {
	#name : #MicHTMLDoc,
	#superclass : #Object,
	#instVars : [
		'fileName',
		'charSet',
		'canvas',
		'languageId',
		'title',
		'description',
		'keywords',
		'author',
		'destinationDir',
		'cssFrameworks'
	],
	#category : #'Microdown-HTMLExporter-Core'
}

{ #category : #initialization }
MicHTMLDoc class >> documentType [
	"Answer a <String> specifying the mandatory document specification tag"

	^ '<!DOCTYPE html>'
]

{ #category : #initialization }
MicHTMLDoc class >> newWithStyle: aStyleName [
	"Answer a new HTML document styled with aStyleName <String>"

	^ self new
		addCSSFramework: (MicCSSProvider forCSSFrameworkNamed: aStyleName);
		yourself
]

{ #category : #'accessing - css' }
MicHTMLDoc >> addCSSFramework: aMicCSSProvider [
	"Add aMicCSSProvider to the receiver's linked CSS resources"
	
	self cssFrameworks add: aMicCSSProvider
]

{ #category : #'accessing - css' }
MicHTMLDoc >> addCSSFrameworkNamed: aString [
	"Add a <MicCSSProvider> named aString to the receiver's linked CSS resources"
	
	self addCSSFramework: (MicCSSProvider forCSSFrameworkNamed: aString)
]

{ #category : #'writing - metadata' }
MicHTMLDoc >> author [
	"Answer a <String> representing the author of the receiver"
	
	^ author
		ifNil: [ author := String empty ]
]

{ #category : #accessing }
MicHTMLDoc >> author: anObject [

	author := anObject
]

{ #category : #private }
MicHTMLDoc >> canvasClass [

	^ MicHTMLCanvas
]

{ #category : #accessing }
MicHTMLDoc >> charSet [
	"Answer a <String> with specifies the character encoding for the HTML document"

	^ charSet
]

{ #category : #accessing }
MicHTMLDoc >> charSet: anObject [

	charSet := anObject
]

{ #category : #accessing }
MicHTMLDoc >> contents [

	^ canvas contents
]

{ #category : #'accessing - css' }
MicHTMLDoc >> cssFrameworks [
	"Answer a <Collection> of <String> each one representing a path to a CSS file"
	
	^ cssFrameworks
		ifNil: [ cssFrameworks := OrderedCollection new ]
]

{ #category : #defaults }
MicHTMLDoc >> defaultLanguageId [

	^ 'en'
]

{ #category : #defaults }
MicHTMLDoc >> defaultTitle [

	^ 'Untitled document'
]

{ #category : #defaults }
MicHTMLDoc >> defaultViewport [
	"Answer a <String> to give the browser instructions on how to control the page's dimensions and scaling"

	^ 'width=device-width,initial-scale=1.0,user-scalable=yes'
]

{ #category : #'writing - metadata' }
MicHTMLDoc >> description [
	"Answer a <String> which define a description for the receiver"
	
	^ description
		ifNil: [ description := String empty ]
]

{ #category : #accessing }
MicHTMLDoc >> description: anObject [

	description := anObject
]

{ #category : #accessing }
MicHTMLDoc >> destinationDir [
	"Answer a <String> specifying the destination directory where receiver's output is written"

	^ destinationDir
		ifNil: [ destinationDir := 'output' ]
]

{ #category : #accessing }
MicHTMLDoc >> destinationDir: anObject [

	destinationDir := anObject
]

{ #category : #private }
MicHTMLDoc >> documentType [
	"Answer a <String> specifying the mandatory document specification tag"
	
	^ self class documentType
]

{ #category : #accessing }
MicHTMLDoc >> fileName [
	"Answer a <String> representing the basename for the receiver when written to disk"
	
	^ fileName 
		ifNil: [ fileName := 'index.html' ]
]

{ #category : #accessing }
MicHTMLDoc >> fileName: anObject [

	fileName := anObject
]

{ #category : #accessing }
MicHTMLDoc >> flush [
	"Write the receiver's contents to a file. If there is no file name, then assign a temporary file name and write contents"
	
	self fileName ifNil: [ self fileName: self tempFileName ].
	(self destinationDir asFileReference / self fileName)
		ensureCreateFile;
		writeStreamDo: [ : fileStream | 
			fileStream 
				nextPutAll: self contents; 
				flush ]
]

{ #category : #accessing }
MicHTMLDoc >> fromMicrodown: aMicrodownString [
	"Convert to HTML and wrap aMicrodownString in the receiver's HTML stream"

	self writeDocument: (Microdown asHTMLString: aMicrodownString)
]

{ #category : #accessing }
MicHTMLDoc >> fullName [
	"Return the full path name of the receiver."
	
	^ (self destinationDir asFileReference / self fileName) fullName 
]

{ #category : #initialization }
MicHTMLDoc >> initialize [
	| stream |
	
	super initialize.
	self setCharSetUTF8.
	stream := MicOutputStream new setStream: (WriteStream on: String empty).
	canvas := self canvasClass on: stream.

]

{ #category : #'writing - metadata' }
MicHTMLDoc >> keywords [
	"Answer a <Collection> of <String> which define keywords for search engines"
	
	^ keywords
		ifNil: [ keywords := OrderedCollection new ]
]

{ #category : #accessing }
MicHTMLDoc >> keywords: anObject [

	keywords := anObject
]

{ #category : #accessing }
MicHTMLDoc >> languageId [
	"Answer a <String> representing the target language of the receiver"
	
	^ languageId
		ifNil: [ languageId := self defaultLanguageId ]
]

{ #category : #accessing }
MicHTMLDoc >> languageId: anObject [

	languageId := anObject
]

{ #category : #accessing }
MicHTMLDoc >> newMicStreamOn: aString [
	"Answer a new wrapper over aString to help not hardcoding line ending everywhere."

	^ MicOutputStream new 
		setStream: (WriteStream on: String empty);
		nextPutAll: aString;
		yourself
]

{ #category : #'accessing - css' }
MicHTMLDoc >> removeCSSProvider: aMicCSSProvider [
	"Remove aMicCSSProvider from the receiver's linked CSS resources"
	
	self cssFrameworks remove: aMicCSSProvider
]

{ #category : #'accessing - css' }
MicHTMLDoc >> removeCSSProviderNamed: aString [
	"Remove a <MicCSSProvider> named aString to the receiver's linked CSS resources"
	
	self removeCSSProvider: (MicCSSProvider forCSSFrameworkNamed: aString)
]

{ #category : #writing }
MicHTMLDoc >> serializeHTML: aFilename in: destDirFileRef [
	"Private - Serialize the receiver's into aFilename in destDirFileRef <FileReference>"

	self fileName: aFilename.
	(destDirFileRef resolveString: aFilename) 
		ensureDelete;
		ensureCreateFile.
	self flush.

]

{ #category : #'writing - metadata' }
MicHTMLDoc >> setCharSetUTF8 [

	self charSet: 'utf-8'
]

{ #category : #accessing }
MicHTMLDoc >> tempFileName [
	"Answer a <String> representing a random file in a temporary location in the receiver's file system"

	^ String streamContents: [ : str | 
		str 
			<< FileLocator temp fullName;
			<< DiskStore delimiter asString;
			<< UUIDGenerator new next asString36;
			<< '.html' ]
]

{ #category : #accessing }
MicHTMLDoc >> title [
	"Answer a <String> representing the required title element"
	
	^ title
		ifNil: [ title := self defaultTitle ]
]

{ #category : #accessing }
MicHTMLDoc >> title: anObject [

	title := anObject
]

{ #category : #writing }
MicHTMLDoc >> writeDocument: aHTMLString [
	"Write markup from anHTMLString to the receiver's body part"

	self writeDocumentType.
	canvas tag
		name: 'html';
		parameterAt: 'lang' put: self languageId;
		with: [ 
			self 
				writeDocumentHead;
				writeDocumentBody: aHTMLString ].
	self flush.
]

{ #category : #writing }
MicHTMLDoc >> writeDocumentBody: aHTMLString [
	"Write aHTMLString representing a valid HTML body for the receiver"

	canvas tag
		name: 'body';
		with: aHTMLString
]

{ #category : #'writing - css' }
MicHTMLDoc >> writeDocumentCSS [
	"Add linked CSS resources to the receiver"
	
	self cssFrameworks do: [ : cssProvider | 
		canvas tag
			name: 'link';
			parameterAt: 'rel' put: 'stylesheet';
			parameterAt: 'href' put: cssProvider cssPath;
			close ]

]

{ #category : #'writing - metadata' }
MicHTMLDoc >> writeDocumentCharSet [
	"Write the character encoding for the receiver"

	canvas tag
		name: 'meta';
		parameterAt: 'http-equiv' put: 'Content-Type';
		parameterAt: 'content' put: 'text/html; charset=' , self charSet;
		close.
]

{ #category : #'writing - metadata' }
MicHTMLDoc >> writeDocumentDescription [
	"Write a description for the receiver"

	canvas tag
		name: 'description';
		parameterAt: 'content' put: self description;
		close.
]

{ #category : #'writing - metadata' }
MicHTMLDoc >> writeDocumentGenerator [

	canvas tag
		name: 'meta';
		parameterAt: 'name' put: 'generator';
		parameterAt: 'content' put: 'microdown';
		close.
]

{ #category : #writing }
MicHTMLDoc >> writeDocumentHead [

	canvas tag
		name: 'head';
		with: [ 
			self 
				writeDocumentMetadata;
				writeDocumentTitle;
				writeDocumentCSS ]

]

{ #category : #'writing - metadata' }
MicHTMLDoc >> writeDocumentMetadata [

	self 
		writeDocumentCharSet;
		writeDocumentGenerator;
		writeDocumentViewport
]

{ #category : #writing }
MicHTMLDoc >> writeDocumentTitle [
	"Write the mandatory title tag which defines the title of the receiver"

	canvas tag
		name: 'title';
		with: self title
]

{ #category : #writing }
MicHTMLDoc >> writeDocumentType [
	"Write the mandatory DOCTYPE HTML declaration in the receiver"

	canvas raw: self documentType

]

{ #category : #'writing - metadata' }
MicHTMLDoc >> writeDocumentViewport [
	"Set the receiver's visible area to look good on all devices"
	
	canvas tag
		name: 'meta';
		parameterAt: 'name' put: 'viewport';
		parameterAt: 'content' put: self defaultViewport;
		close
]

{ #category : #writing }
MicHTMLDoc >> writeToFile [
	"Write the receiver's contents to the default file name"

	self writeToFileNamed: self fileName
]

{ #category : #writing }
MicHTMLDoc >> writeToFileNamed: aFilename [
	"Ensure a new file named aFilename and write the receiver's contents into it"

	| destDirFileRef |
	
	destDirFileRef := self destinationDir asFileReference.
	self serializeHTML: aFilename in: destDirFileRef.
	self cssFrameworks do: [ : cssProvider | cssProvider writeTo: destDirFileRef ].
]
