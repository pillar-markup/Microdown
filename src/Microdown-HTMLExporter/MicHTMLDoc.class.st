"
Represents a Text/HTML file with default character set as UTF-8.
Assume it receives as input raw HTML String, without any valid mandatory header tag, and builds a header and body tags around it.

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
		'cssFiles',
		'description',
		'keywords',
		'author'
	],
	#category : #'Microdown-HTMLExporter'
}

{ #category : #initialization }
MicHTMLDoc class >> documentType [
	"Answer a <String> specifying the mandatory document specification tag"

	^ '<!DOCTYPE html>'
]

{ #category : #'accessing - css' }
MicHTMLDoc >> addCSSFile: aCSSFile [
	"Add aCSSFile to the receiver's linked CSS resources"
	
	self cssFiles add: aCSSFile
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

{ #category : #initialization }
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
MicHTMLDoc >> cssBaseFolder [

	^ 'css/'
]

{ #category : #'accessing - css' }
MicHTMLDoc >> cssFiles [
	"Answer a <Collection> of <String> each one representing a path to a CSS file"
	
	^ cssFiles
		ifNil: [ cssFiles := OrderedCollection new ]
]

{ #category : #'accessing - css' }
MicHTMLDoc >> cssLocationFor: cssFile [
	"Answer a <String> describing the location for CSS resouce cssFile"
	
	^ String streamContents: [ : stream |
		stream 
			<< self cssBaseFolder;
			<< cssFile fileName ]
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

{ #category : #initialization }
MicHTMLDoc >> documentType [
	"Answer a <String> specifying the mandatory document specification tag"
	
	^ self class documentType
]

{ #category : #accessing }
MicHTMLDoc >> fileName [

	^ fileName
]

{ #category : #accessing }
MicHTMLDoc >> fileName: anObject [

	fileName := anObject
]

{ #category : #accessing }
MicHTMLDoc >> flush [
	"If we have a fileName already, then write the receiver's contents to it. If not, then assign a temporary file name and write contents"
	
	self fileName ifNil: [ self fileName: self tempFileName ].
	self fileName asFileReference 
		writeStreamDo: [ : fileStream | fileStream nextPutAll: self contents; flush ]
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

{ #category : #initialization }
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

{ #category : #initialization }
MicHTMLDoc >> writeDocument: aHTMLString [
	"Write markup hyperlink, which is used to link from one page to another"

	self writeDocumentType.
	canvas tag
		name: 'html';
		parameterAt: 'lang' put: self languageId;
		with: [ 
			self 
				writeDocumentHead;
				writeDocumentBody: aHTMLString ]
]

{ #category : #initialization }
MicHTMLDoc >> writeDocumentBody: aHTMLString [
	"Write aHTMLString representing a valid HTML body for the receiver"

	canvas tag
		name: 'body';
		with: aHTMLString
]

{ #category : #'writing - css' }
MicHTMLDoc >> writeDocumentCSS [
	"Add linked CSS resources to the receiver"
	
	self cssFiles do: [ : cssFile | 
		canvas tag
			name: 'link';
			parameterAt: 'rel' put: 'stylesheet';
			parameterAt: 'href' put: (self cssLocationFor: cssFile);
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

{ #category : #initialization }
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
