"
Represents a Text/HTML file with default character set as UTF-8.
Assume it receives as input raw HTML String, without any valid mandatory header tag, and builds a header and body tags around it.

"
Class {
	#name : #MicHTMLDocBuilder,
	#superclass : #Object,
	#instVars : [
		'fileName',
		'contents',
		'charSet',
		'stream'
	],
	#category : #'Microdown-HTMLExporter'
}

{ #category : #initialization }
MicHTMLDocBuilder class >> documentType [
	"Answer a <String> specifying the mandatory document specification tag"

	^ '<!DOCTYPE html>'
]

{ #category : #accessing }
MicHTMLDocBuilder >> charSet [

	^ charSet
]

{ #category : #accessing }
MicHTMLDocBuilder >> charSet: anObject [

	charSet := anObject
]

{ #category : #accessing }
MicHTMLDocBuilder >> contents [

	^ contents
]

{ #category : #accessing }
MicHTMLDocBuilder >> contents: anObject [

	contents := anObject
]

{ #category : #initialization }
MicHTMLDocBuilder >> document [
	"Answer a <String> represented as valid HTML document"
	
	self writeDocumentHeader.
	self writeDocumentBody.
	^ stream contents
]

{ #category : #initialization }
MicHTMLDocBuilder >> documentType [
	"Answer a <String> specifying the mandatory document specification tag"
	
	^ self class documentType
]

{ #category : #accessing }
MicHTMLDocBuilder >> fileName [

	^ fileName
]

{ #category : #accessing }
MicHTMLDocBuilder >> fileName: anObject [

	fileName := anObject
]

{ #category : #initialization }
MicHTMLDocBuilder >> initialize [

	super initialize.
	self setCharSetUTF8.
	stream := MicOutputStream new setStream: (WriteStream on: (String new: 1000)).	

]

{ #category : #initialization }
MicHTMLDocBuilder >> setCharSetUTF8 [

	self charSet: 'utf-8'
]

{ #category : #accessing }
MicHTMLDocBuilder >> stream [

	^ stream
]

{ #category : #accessing }
MicHTMLDocBuilder >> stream: anObject [

	stream := anObject
]

{ #category : #initialization }
MicHTMLDocBuilder >> writeDocumentBody [
	"Answer a <String> representing a valid HTML body for the receiver"

	stream
		<< '<body>';
		newLine;
		<< self contents;				
		<< '</body>';
		newLine;
		<< '</html>'				
]

{ #category : #initialization }
MicHTMLDocBuilder >> writeDocumentHeader [
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
