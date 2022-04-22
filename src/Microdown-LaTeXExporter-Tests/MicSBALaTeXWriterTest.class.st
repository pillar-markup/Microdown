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
MicSBALaTeXWriterTest >> testCodeblock [

	self writeFor: (factory codeblockNoParamBody: 'this is a code').
	self assert: writer contents equals: '
\begin{displaycode}{smalltalk}
this is a code
\end{displaycode}
'
]

{ #category : #tests }
MicSBALaTeXWriterTest >> testCodeblockWithCaption [

	self writeFor: (factory codeblock: 'caption=Pharo is **cool**' body: 'this is a code').
	self assert: writer contents equals: '
\begin{listing}[float]{smalltalk}{Pharo is \textbf{cool}}
this is a code
\end{listing}
'
]

{ #category : #tests }
MicSBALaTeXWriterTest >> testCodeblockWithLabel [

	self writeFor: (factory codeblock: 'label=Pharo' body: 'this is a code').
	self assert: writer contents equals: '
\begin{listing}[float, label=Pharo]{smalltalk}{}
this is a code
\end{listing}
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
MicSBALaTeXWriterTest >> testParagraphWithMonospace [
	
	self parse: factory paragraphMonospaceSample andCheckWeGet:  '
this is a \textcode{paragraph}
'
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

{ #category : #tests }
MicSBALaTeXWriterTest >> testTable [
	self writeFor: factory tableSample.
	self assert: writer contents equals: '
\begin{fullwidthtabular}{ll}
\toprule
\textbf{aaab} & \textbf{jkhjh} \\
\midrule
bar & rab \\
\bottomrule
\end{fullwidthtabular}
'
]

{ #category : #tests }
MicSBALaTeXWriterTest >> testTableWhithoutHeader [
	
	self writeFor: (factory simpleTableWithoutHeaderTable).
	self assert: writer contents equals: '
\begin{fullwidthtabular}{ll}
\toprule
aaab & jkhjh \\
bar & rab \\
\bottomrule
\end{fullwidthtabular}
'
]
