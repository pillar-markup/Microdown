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

{ #category : #running }
MicLaTeXWriterTest >> testBold [
	| mic |
	mic := parser parse: factory boldFormatSample.
	self assert: (writer visit: mic) contents equals: '
\textbf{Foo}
'
]

{ #category : #running }
MicLaTeXWriterTest >> testItalic [
	| mic |
	mic := parser parse: factory italicFormatSample.
	self assert: (writer visit: mic) contents equals: '
\textit{Foo}
'
]

{ #category : #running }
MicLaTeXWriterTest >> testMonospace [
	| mic |
	mic := parser parse: factory monospaceFormatSample.
	self assert: (writer visit: mic) contents equals: '
\code{Foo}
'
]

{ #category : #running }
MicLaTeXWriterTest >> testStrike [
	| mic |
	mic := parser parse: factory strikethroughFormatSample.
	self assert: (writer visit: mic) contents equals: '
\sout{Foo}
'
]
