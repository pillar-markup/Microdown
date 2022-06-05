Class {
	#name : #MicExportCanvasTest,
	#superclass : #TestCase,
	#instVars : [
		'canvas'
	],
	#category : #'Microdown-LaTeXExporter-Tests'
}

{ #category : #running }
MicExportCanvasTest >> setUp [
	| stream |
	super setUp.
	stream := MicOutputStream new setStream: (WriteStream on: (String new: 1000)).
	canvas := MicExportCanvas on: stream.
]

{ #category : #tests }
MicExportCanvasTest >> testCrAsNewLine [ 

	canvas crAsNewLine.
	self assert: canvas stream configuration newLine equals: Character cr
]

{ #category : #tests }
MicExportCanvasTest >> testCrlfAsNewLine [ 

	canvas crlfAsNewLine.
	self assert: canvas stream configuration newLine equals: String crlf
]

{ #category : #tests }
MicExportCanvasTest >> testLfAsNewLine [ 

	canvas lfAsNewLine.
	self assert: canvas stream configuration newLine equals: Character lf
]

{ #category : #tests }
MicExportCanvasTest >> testWriteAParagraphWithCr [
	canvas crAsNewLine.
	canvas nextPutAllLines: 'Je ne vois pas pourquoi
cela ne fonctionnerais pas
car il a etait fait pour cela'.
	self assert: canvas stream contents equals: 'Je ne vois pas pourquoi', String cr ,
'cela ne fonctionnerais pas', String cr,
'car il a etait fait pour cela'
]

{ #category : #tests }
MicExportCanvasTest >> testWriteAParagraphWithCrButNewLineIsCrlf [
	canvas crlfAsNewLine.
	canvas nextPutAllLines: 'Je ne vois pas pourquoi
cela ne fonctionnerais pas
car il a etait fait pour cela'.
	self deny: canvas stream contents equals: 'Je ne vois pas pourquoi', String cr ,
'cela ne fonctionnerais pas', String cr,
'car il a etait fait pour cela'
]

{ #category : #tests }
MicExportCanvasTest >> testWriteAParagraphWithCrButNewLineIsLf [
	canvas lfAsNewLine.
	canvas nextPutAllLines: 'Je ne vois pas pourquoi
cela ne fonctionnerais pas
car il a etait fait pour cela'.
	self deny: canvas stream contents equals: 'Je ne vois pas pourquoi', String cr ,
'cela ne fonctionnerais pas', String cr,
'car il a etait fait pour cela'
]

{ #category : #tests }
MicExportCanvasTest >> testWriteAParagraphWithCrlf [
	canvas crlfAsNewLine.
	canvas nextPutAllLines: 'Je ne vois pas pourquoi
cela ne fonctionnerais pas
car il a etait fait pour cela'.
	self assert: canvas stream contents equals: 'Je ne vois pas pourquoi', String crlf ,
'cela ne fonctionnerais pas', String crlf,
'car il a etait fait pour cela'
]

{ #category : #tests }
MicExportCanvasTest >> testWriteAParagraphWithCrlfButNewLineIsCr [
	canvas crAsNewLine.
	canvas nextPutAllLines: 'Je ne vois pas pourquoi
cela ne fonctionnerais pas
car il a etait fait pour cela'.
	self deny: canvas stream contents equals: 'Je ne vois pas pourquoi', String crlf ,
'cela ne fonctionnerais pas', String crlf,
'car il a etait fait pour cela'
]

{ #category : #tests }
MicExportCanvasTest >> testWriteAParagraphWithCrlfButNewLineIsLf [
	canvas lfAsNewLine.
	canvas nextPutAllLines: 'Je ne vois pas pourquoi
cela ne fonctionnerais pas
car il a etait fait pour cela'.
	self deny: canvas stream contents equals: 'Je ne vois pas pourquoi', String crlf ,
'cela ne fonctionnerais pas', String crlf,
'car il a etait fait pour cela'
]

{ #category : #tests }
MicExportCanvasTest >> testWriteAParagraphWithLf [
	canvas lfAsNewLine.
	canvas nextPutAllLines: 'Je ne vois pas pourquoi
cela ne fonctionnerais pas
car il a etait fait pour cela'.
	self assert: canvas stream contents equals: 'Je ne vois pas pourquoi', String lf ,
'cela ne fonctionnerais pas', String lf,
'car il a etait fait pour cela'
]

{ #category : #tests }
MicExportCanvasTest >> testWriteAParagraphWithLfButNewLineIsCr [
	canvas crAsNewLine.
	canvas nextPutAllLines: 'Je ne vois pas pourquoi
cela ne fonctionnerais pas
car il a etait fait pour cela'.
	self deny: canvas stream contents equals: 'Je ne vois pas pourquoi', String lf ,
'cela ne fonctionnerais pas', String lf,
'car il a etait fait pour cela'
]

{ #category : #tests }
MicExportCanvasTest >> testWriteAParagraphWithLfButNewLineIsCrlf [
	canvas crlfAsNewLine.
	canvas nextPutAllLines: 'Je ne vois pas pourquoi
cela ne fonctionnerais pas
car il a etait fait pour cela'.
	self deny: canvas stream contents equals: 'Je ne vois pas pourquoi', String lf ,
'cela ne fonctionnerais pas', String lf,
'car il a etait fait pour cela'
]
