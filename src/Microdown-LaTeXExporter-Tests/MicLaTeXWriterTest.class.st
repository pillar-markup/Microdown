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

{ #category : #tests }
MicLaTeXWriterTest >> testCodeblock [
	| mic |
	mic := parser parse: (factory codeblockNoParamBody: 'this is a code').
	self assert: (writer visit: mic) contents equals: '
\begin{listing}
this is a code
\end{listing}
'
]

{ #category : #tests }
MicLaTeXWriterTest >> testCodeblockWithCaption [
	| mic |
	mic := parser parse: (factory codeblock: 'caption=Pharo is **cool**' body: 'this is a code').
	self assert: (writer visit: mic) contents equals: '
\begin{listing}[caption={Pharo is \textbf{cool}}, language=caption]
this is a code
\end{listing}
'
]

{ #category : #'tests - header' }
MicLaTeXWriterTest >> testHeaderLevel1 [
	| mic |
	mic := parser parse: factory headerLevel1Sample.
	self assert: (writer visit: mic) contents equals: '\part{Foo}'
]

{ #category : #'tests - header' }
MicLaTeXWriterTest >> testHeaderLevel2 [
	| mic |
	mic := parser parse: factory headerLevel2Sample.
	self assert: (writer visit: mic) contents equals: '\chapter{Foo}'
]

{ #category : #'tests - header' }
MicLaTeXWriterTest >> testHeaderLevel3 [
	| mic |
	mic := parser parse: factory headerLevel3Sample.
	self assert: (writer visit: mic) contents equals: '\section{Foo}'
]

{ #category : #'tests - header' }
MicLaTeXWriterTest >> testHeaderLevel4 [
	| mic |
	mic := parser parse: factory headerLevel4Sample.
	self assert: (writer visit: mic) contents equals: '\subsection{Foo}'
]

{ #category : #'tests - header' }
MicLaTeXWriterTest >> testHeaderLevel5 [
	| mic |
	mic := parser parse: factory headerLevel5Sample.
	self assert: (writer visit: mic) contents equals: '\subsubsection{Foo}'
]

{ #category : #'tests - header' }
MicLaTeXWriterTest >> testHeaderLevel6 [
	| mic |
	mic := parser parse: factory headerLevel6Sample.
	self assert: (writer visit: mic) contents equals: '\paragraph{Foo}'
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

{ #category : #'tests - lists' }
MicLaTeXWriterTest >> testOrderedList [
	| mic |
	mic := parser parse: factory orderedListWithTwoItemsSample.
	self assert: (writer visit: mic) contents equals: '
\begin{enumerate}
\item first
\item second
\end{enumerate}
'
]

{ #category : #'tests - lists' }
MicLaTeXWriterTest >> testOrderedListBold [
	| mic |
	mic := parser parse: factory orderedListWithTwoItemsBoldSample.
	self assert: (writer visit: mic) contents equals: '
\begin{enumerate}
\item \textbf{first}
\item second
\end{enumerate}
'
]

{ #category : #'tests - lists' }
MicLaTeXWriterTest >> testOrderedListNested [
	| mic |
	mic := parser parse: factory orderedListWithTwoItemsNestedSample.
	self assert: (writer visit: mic) contents equals: '
\begin{enumerate}
\item \textbf{\textit{first}}
\item second
\end{enumerate}
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

{ #category : #tests }
MicLaTeXWriterTest >> testQuote [
	| mic |
	mic := parser parse: (factory quoteSample).
	self assert: (writer visit: mic) contents equals: '
\begin{verbatim}
Foo
\end{verbatim}
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

{ #category : #'tests - lists' }
MicLaTeXWriterTest >> testUnorderedList [
	| mic |
	mic := parser parse: factory unorderedListWithTwoItemsSample.
	self assert: (writer visit: mic) contents equals: '
\begin{itemize}
\item Foo
\item Bar
\end{itemize}
'
]

{ #category : #'tests - lists' }
MicLaTeXWriterTest >> testUnorderedListBold [
	| mic |
	mic := parser parse: factory unorderedListWithTwoItemsBoldSample.
	self assert: (writer visit: mic) contents equals: '
\begin{itemize}
\item \textbf{Foo}
\item Bar
\end{itemize}
'
]

{ #category : #'tests - lists' }
MicLaTeXWriterTest >> testUnorderedListNested [
	| mic |
	mic := parser parse: factory unorderedListWithTwoItemsNestedSample.
	self assert: (writer visit: mic) contents equals: '
\begin{itemize}
\item \sout{\textit{Foo}}
\item Bar
\end{itemize}
'
]
