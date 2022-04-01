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
		'stream'
	],
	#category : #'Microdown-HTMLExporter'
}

{ #category : #initialization }
MicHTMLDoc class >> documentType [
	"Answer a <String> specifying the mandatory document specification tag"

	^ '<!DOCTYPE html>'
]

{ #category : #accessing }
MicHTMLDoc >> charSet [

	^ charSet
]

{ #category : #accessing }
MicHTMLDoc >> charSet: anObject [

	charSet := anObject
]

{ #category : #accessing }
MicHTMLDoc >> contents [
	"Answer a <String> represented as valid HTML document"
	
	^ stream 	contents
]

{ #category : #accessing }
MicHTMLDoc >> contents: aHTMLString [
	"Set the receiver's contents, aString should be HTML to be presented (i.e. the contents enclosed into body tags)"

	stream := self newMicStreamOn: aHTMLString.


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

	super initialize.
	self setCharSetUTF8.
	stream := self newMicStreamOn: (String new: 1000)

]

{ #category : #accessing }
MicHTMLDoc >> newMicStreamOn: aString [
	"Answer a new wrapper over aString to help not hardcoding line ending everywhere."

	^ MicOutputStream new 
		setStream: (WriteStream on: String empty);
		nextPutAll: aString;
		yourself
]

{ #category : #initialization }
MicHTMLDoc >> setCharSetUTF8 [

	self charSet: 'utf-8'
]

{ #category : #accessing }
MicHTMLDoc >> stream [

	^ stream
]

{ #category : #accessing }
MicHTMLDoc >> stream: anObject [

	stream := anObject
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

{ #category : #initialization }
MicHTMLDoc >> writeBodyContents: aHTMLString [
	"Answer a <String> representing a valid HTML body for the receiver"

	stream
		<< '<body>';
		newLine;
		<< aHTMLString;
		<< '</body>';
		newLine;
		<< '</html>';
		flush
]

{ #category : #initialization }
MicHTMLDoc >> writeDocument: aHTMLString [

	self
		writeHeader;
		writeBodyContents: aHTMLString
]

{ #category : #initialization }
MicHTMLDoc >> writeHeader [
	"Answer a <String> representing a valid HTML header for the receiver"

	stream
		<< self documentType;
		newLine;
		<< '<html>';
		newLine;
		<< '<head>';
		<< '<meta http-equiv="Content-Type" content="text/html; charset=';
		<< self charSet;
		<< '">';
		<< '</head>';
		newLine			
]
