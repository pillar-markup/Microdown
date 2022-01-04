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
MicSBALaTeXWriterTest >> testFloatingWithBothLabelAndCaption [
	| codeBlock |
	codeBlock := (MicCodeBlock new body: 'foo')
					label: 'myScript';
					caption: 'a caption';
					yourself.
	self assertWriting: codeBlock includesTexts: #('label=myScript')
]

{ #category : #tests }
MicSBALaTeXWriterTest >> testInFlowOnTwoLines [
	| codeBlock |
	codeBlock := MicCodeBlock new body: 'foo', writer usedNewLine, 'bar on another line'.
	self writeLaTeXForElement: codeBlock.	
	self assert: writer contents equals: '
\begin{displaycode}{smalltalk}
foo', 
writer usedNewLine,
'bar on another line
\end{displaycode}
'
]

{ #category : #tests }
MicSBALaTeXWriterTest >> testMonospace [

	self parseInlined: factory monospaceFormatSample andCheckWeGet: '\textcode{Foo}'
]

{ #category : #tests }
MicSBALaTeXWriterTest >> testSimpleFloating [
	| codeBlock |
	codeBlock := (MicCodeBlock new body: 'foo')
		caption: 'A caption.';
		yourself.
	self writeLaTeXForElement: codeBlock.
	self assert: writer contents equals: '
\begin{listing}[float]{smalltalk}{A caption.}
foo
\end{listing}
'
]

{ #category : #tests }
MicSBALaTeXWriterTest >> testSimpleFloatingNoLanguage [
	| codeBlock |
	codeBlock := (MicCodeBlock new body: 'foo')
		caption: 'A caption.';
		yourself.
	self writeLaTeXForElement: codeBlock.
	self flag: #languageSupport. "smalltalk -> plain"
	self assertWriting: codeBlock includesText: '{smalltalk}'
]
