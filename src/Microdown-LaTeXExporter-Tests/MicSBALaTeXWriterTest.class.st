Class {
	#name : #MicSBALaTeXWriterTest,
	#superclass : #MicLaTeXWriterTest,
	#category : #'Microdown-LaTeXExporter-Tests'
}

{ #category : #private }
MicSBALaTeXWriterTest >> actualClass [
	^ MicSBALaTeXWriter
]

{ #category : #tests }
MicSBALaTeXWriterTest >> testFloatingScriptWithNoLanguageGeneratePlain [
	| script |
	script := (MicCodeBlock new body: 'foo')
		caption: 'a caption';
		yourself.
	self assertWriting: script includesText: '{plain}'
]

{ #category : #tests }
MicSBALaTeXWriterTest >> testMonospace [

	self parseInlined: factory monospaceFormatSample andCheckWeGet: '\textcode{Foo}'
]
