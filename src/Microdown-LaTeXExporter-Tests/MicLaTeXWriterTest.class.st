Class {
	#name : #MicLaTeXWriterTest,
	#superclass : #TestCase,
	#instVars : [
		'parser',
		'writer',
		'factory'
	],
	#category : #'Microdown-LaTeXExporter-Tests'
}

{ #category : #running }
MicLaTeXWriterTest >> setUp [
	super setUp.
	parser := MicroDownParser new.
	writer := MicLaTeXWriter new.
	factory := MicMicrodownSnippetFactory new
]

{ #category : #'tests - formats' }
MicLaTeXWriterTest >> testBold [
	| mic |
	mic := parser parse: factory boldFormatSample.
	self assert: (writer visit: mic) contents equals: '
\textbf{Foo}
'
]

{ #category : #'tests - formats' }
MicLaTeXWriterTest >> testItalic [
	| mic |
	mic := parser parse: factory italicFormatSample.
	self assert: (writer visit: mic) contents equals: '
\textit{Foo}
'
]

{ #category : #'tests - formats' }
MicLaTeXWriterTest >> testMonospace [
	| mic |
	mic := parser parse: factory monospaceFormatSample.
	self assert: (writer visit: mic) contents equals: '
\code{Foo}
'
]

{ #category : #'tests - paragraph' }
MicLaTeXWriterTest >> testParagraph [
	| mic |
	mic := parser parse: factory paragraphSample.
	self assert: (	writer visit: mic) contents equals: '
Foo
'
]

{ #category : #'tests - paragraph' }
MicLaTeXWriterTest >> testParagraphWithBold [
	| mic |
	mic := parser parse: factory paragraphBoldSample.
	self assert: (writer visit: mic) contents equals: '
this is a \textbf{paragraph}
'
]

{ #category : #'tests - paragraph' }
MicLaTeXWriterTest >> testParagraphWithItalic [
	| mic |
	mic := parser parse: factory paragraphItalicSample.
	self assert: (writer visit: mic) contents equals: '
this is a \textit{paragraph}
'
]

{ #category : #'tests - paragraph' }
MicLaTeXWriterTest >> testParagraphWithMonospace [
	| mic |
	mic := parser parse: factory paragraphMonospaceSample.
	self assert: (writer visit: mic) contents equals: '
this is a \code{paragraph}
'
]

{ #category : #'tests - paragraph' }
MicLaTeXWriterTest >> testParagraphWithNested [
	| mic |
	mic := parser parse: factory paragraphNestedSample.
	self assert: (writer visit: mic) contents equals: '
this is a \textbf{\textit{paragraph}}
'
]

{ #category : #'tests - formats' }
MicLaTeXWriterTest >> testStrike [
	| mic |
	mic := parser parse: factory strikethroughFormatSample.
	self assert: (writer visit: mic) contents equals: '
\sout{Foo}
'
]
