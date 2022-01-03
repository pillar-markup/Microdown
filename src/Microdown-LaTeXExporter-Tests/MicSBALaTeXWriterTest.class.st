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
MicSBALaTeXWriterTest >> testInFlowOnTwoLines [
	| codeBlock res |
	codeBlock := MicCodeBlock new body: 'foo', writer usedNewLine, 'bar on another line'.
	res := (writer visit: codeBlock) contents.	
	self assert: res equals: '
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
	| codeBlock res |
	codeBlock := (MicCodeBlock new body: 'foo')
		caption: 'A caption.';
		yourself.
	res := (writer visit: codeBlock) contents.	
	self assert: res equals: '
\begin{listing}[float, list text={A caption.}]{smalltalk}{A caption.}
foo
\end{listing}
'



]
