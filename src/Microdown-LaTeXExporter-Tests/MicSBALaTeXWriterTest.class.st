Class {
	#name : #MicSBALaTeXWriterTest,
	#superclass : #MicLaTeXWriterTest,
	#category : #'Microdown-LaTeXExporter-Tests'
}

{ #category : #private }
MicSBALaTeXWriterTest >> actualClass [
	^ MicSBALaTeXWriter
]

{ #category : #'tests - figure/link' }
MicSBALaTeXWriterTest >> testFigureRealSample [

	self writeFor: factory figureRealSample.
	self assert: writer contents equals: '

\begin{center}
\includegraphics[width=0.8\textwidth]{/logo.png}\end{center}

'
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
	self writeForElement: codeBlock.	
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
	self writeForElement: codeBlock.
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
	self writeForElement: codeBlock.
	self flag: #languageSupport. "smalltalk -> plain"
	self assertWriting: codeBlock includesText: '{smalltalk}'
]
