"
Represents a Text/HTML file to be displayed in a web browser. It can be created with a CSS style **newWithStyle:**, and passing a `Microdown` content String through **fromMicrodown:** as parameter.

## Example

The following generates a HTML String from Microdown contents:

```language=Pharo
(MicHTMLDoc newWithStyle: 'NewCSS') 
	fromMicrodown: MicDocFactory exampleMic;
	contents.
```

Select and inspect the following:

```language=Pharo
MicCSSProvider libraryNames.
```

to see a list of available CSS libraries.

## Description

A document has multiple primary properties which can be configured:

- A **fileName** `String`.
- A `Collection` of CSS files to define the look of the document, through **addCSSFile:**.
- A destination directory (**destinationDir**) representing the output path of the document.

Additional properties, for example those specified in a Microdown header, are translated into HTML meta tags and they are handled in its `MicHTMLConfiguration` object.

A Microdown HTML document can receive as input a raw HTML String, without any surrounding header tags, and it builds a header and body tags around it.

## Internals

A HTML document uses a canvas which acts as a brush to render content.

Internally, it uses a Configuration object (instance of `MicHTMLConfiguration`) to set important HTML properties, prividing widely used defaults:

- The viewport, specified in **defaultViewport**, to control layout in mobile browsers.
- The language identifier is set by default to 'en' (English).
- A subdirectory where the linked CSS files are stored, specified in `MicHTMLDoc >> cssBasePath`.

"
Class {
	#name : #MicHTMLDoc,
	#superclass : #Object,
	#instVars : [
		'fileName',
		'canvas',
		'destinationDir',
		'cssFrameworks',
		'configuration'
	],
	#category : #'Microdown-HTMLExporter-Core'
}

{ #category : #initialization }
MicHTMLDoc class >> newWithStyle: aStyleName [
	"Answer a new HTML document styled with aStyleName <String>"

	^ self new
		addCSSNamed: aStyleName;
		yourself
]

{ #category : #'accessing - css' }
MicHTMLDoc >> addCSS: aMicCSSEntity [
	"Add a <aMicCSSEntity> to the receiver's linked CSS resources. Answer a <MicCSSFramework>"
	
	^ self cssFrameworks add: aMicCSSEntity
]

{ #category : #'accessing - css' }
MicHTMLDoc >> addCSSNamed: aString [
	"Add a <MicCSSProvider> named aString to the receiver's linked CSS resources. Answer a <MicCSSFramework>"
	
	^ self cssFrameworks add: (MicCSSProvider forCSSNamed: aString)
]

{ #category : #accessing }
MicHTMLDoc >> author [
	"Refer to comment in MicHTMLConfiguration>>author"
	
	^ self configuration author
]

{ #category : #accessing }
MicHTMLDoc >> author: aString [
	"Refer to comment in MicHTMLConfiguration>>author:"
	
	^ self configuration author: aString
]

{ #category : #accessing }
MicHTMLDoc >> canvas [

	^ canvas
]

{ #category : #accessing }
MicHTMLDoc >> canvas: anObject [

	canvas := anObject
]

{ #category : #private }
MicHTMLDoc >> canvasClass [

	^ MicHTMLCanvas
]

{ #category : #accessing }
MicHTMLDoc >> charSet [
	"Answer a <String> with specifies the character encoding for the HTML document"

	^ self configuration charSet
]

{ #category : #accessing }
MicHTMLDoc >> charSet: anObject [

	self configuration charSet: anObject
]

{ #category : #accessing }
MicHTMLDoc >> configuration [
	"Answer the receiver's <MicHTMLConfiguration>"

	^ configuration
]

{ #category : #accessing }
MicHTMLDoc >> configuration: anObject [

	configuration := anObject
]

{ #category : #accessing }
MicHTMLDoc >> contents [
	"Update the document with the canvas contents and answer the HTML"

	^ canvas contents
]

{ #category : #'accessing - css' }
MicHTMLDoc >> cssFrameworks [
	"Answer a <Collection> of <String> each one representing a path to a CSS file"
	
	^ cssFrameworks
		ifNil: [ cssFrameworks := OrderedCollection new ]
]

{ #category : #accessing }
MicHTMLDoc >> description [
	"Refer to comment in MicHTMLConfiguration>>description"
	
	^ self configuration description
]

{ #category : #accessing }
MicHTMLDoc >> description: aString [
	"Refer to comment in MicHTMLConfiguration>>description:"
	
	^ self configuration description: aString
]

{ #category : #accessing }
MicHTMLDoc >> destinationPath [
	"Answer a <String> specifying the destination directory where receiver's output is written"

	^ destinationDir
		ifNil: [ destinationDir := 'output' ]
]

{ #category : #accessing }
MicHTMLDoc >> destinationPath: anObject [

	destinationDir := anObject
]

{ #category : #accessing }
MicHTMLDoc >> documentType [
	"Refer to comment in MicHTMLConfiguration>>documentType"
	
	^ self configuration documentType
]

{ #category : #accessing }
MicHTMLDoc >> documentType: aString [
	"Refer to comment in MicHTMLConfiguration>>documentType:"
	
	^ self configuration documentType: aString
]

{ #category : #testing }
MicHTMLDoc >> exists [
	"Answer <true> if receiver exists as a file"
	
	^ self fullName asFileReference exists
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
	(self destinationPath asFileReference / self fileName)
		ensureCreateFile;
		writeStreamDo: [ : fileStream | 
			fileStream 
				nextPutAll: self contents; 
				flush ]
]

{ #category : #accessing }
MicHTMLDoc >> fromMicrodown: aMicrodownString [
	"Convert to HTML and wrap aMicrodownString in the receiver's HTML stream"

	self initializeCanvas.
	self writeDocument: (Microdown 
		asHTMLString: aMicrodownString 
		configuration: self configuration)
]

{ #category : #accessing }
MicHTMLDoc >> fullName [
	"Return the full path name of the receiver."
	
	^ (self destinationPath asFileReference / self fileName) fullName 
]

{ #category : #initialization }
MicHTMLDoc >> initialize [
	
	super initialize.
	self configuration: (MicHTMLConfiguration new 
		document: self;
		yourself).	
	self setCharSetUTF8.
	self initializeCanvas.

]

{ #category : #initialization }
MicHTMLDoc >> initializeCanvas [

	canvas := self canvasClass new.

]

{ #category : #accessing }
MicHTMLDoc >> keywords [
	"Refer to comment in MicHTMLConfiguration>>keywords"
	
	^ self configuration keywords
]

{ #category : #accessing }
MicHTMLDoc >> keywords: aCollection [
	"Refer to comment in MicHTMLConfiguration>>keywords:"
	
	^ self configuration keywords: aCollection
]

{ #category : #accessing }
MicHTMLDoc >> languageId [
	"Refer to comment in MicHTMLConfiguration>>languageId"
	
	^ self configuration languageId
]

{ #category : #accessing }
MicHTMLDoc >> languageId: aString [
	"Refer to comment in MicHTMLConfiguration>>languageId:"
	
	^ self configuration languageId: aString
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
MicHTMLDoc >> removeCSSNamed: aString [
	"Remove <MicCSSFramework> named aString from the receiver's linked CSS resources"
	
	self cssFrameworks remove: aString
]

{ #category : #writing }
MicHTMLDoc >> serializeHtml: aFilename in: destDirFileRef [
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
	"Refer to comment in MicHTMLConfiguration>>title"
	
	^ self configuration title
]

{ #category : #writing }
MicHTMLDoc >> writeDocument: aHTMLString [
	"Write markup from anHTMLString to the receiver's body part"

	self configuration writeDocumentType.
	canvas tag
		name: 'html';
		parameterAt: 'lang' put: self languageId;
		with: [ 
			self configuration writeDocumentHead.
			self writeDocumentBody: aHTMLString ].
	self flush.
]

{ #category : #writing }
MicHTMLDoc >> writeDocumentBody: aHTMLString [
	"Write aHTMLString representing a valid HTML body for the receiver"

	canvas tag
		name: 'body';
		with: [ 
			canvas tag 
				name: 'main';
				parameterAt: 'role' put: 'main';
				with: aHTMLString ]
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
	
	destDirFileRef := self destinationPath asFileReference.
	self serializeHtml: aFilename in: destDirFileRef.
	self cssFrameworks do: [ : cssEntity | cssEntity writeTo: destDirFileRef ].
]
