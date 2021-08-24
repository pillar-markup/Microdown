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

{ #category : #tests }
MicLaTeXWriterTest >> testAnchor [
	| mic |
	mic := parser parse: factory anchorSample.
	self assert: (writer visit: mic) contents equals: '\label{test}'
]

{ #category : #tests }
MicLaTeXWriterTest >> testAnchorReference [
	| mic |
	mic := parser parse: factory anchorReferenceSample.
	self assert: (writer visit: mic) contents equals: '
\ref{Foo}
'
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
MicLaTeXWriterTest >> testCitation [
	| mic |
	mic := parser parse: '?{citation|ref=Pharo is cool}?'.
	self assert: (writer visit: mic) contents equals: '
\cite{Pharo is cool}
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
	self flag: #toFix.
	"language = caption is false. It is not the case may in microdown we have ...&language=perl
	and this creates language=perl in latex."
	self assert: (writer visit: mic) contents equals: '
\begin{listing}[caption={Pharo is \textbf{cool}}, language=caption]
this is a code
\end{listing}
'
]

{ #category : #tests }
MicLaTeXWriterTest >> testCodeblockWithLabel [
	| mic |
	mic := parser parse: (factory codeblock: 'label=Pharo is cool' body: 'this is a code').
	self flag: #tofix.
	"This is wrong since language cannot be label"
	self assert: (writer visit: mic) contents equals: '
\begin{listing}[language=label, label=Pharo is cool]
this is a code
\end{listing}
'
]

{ #category : #'tests - references' }
MicLaTeXWriterTest >> testFigure [
	| mic |
	mic := parser parse: factory figureSample.
	self flag: #tofix.
	"we should give something similar to 
	
	\begin{figure}[htpb]
\begin{center}
\includegraphics[width=\linewidth]{stef-ReferenceSituation2.pdf}
\caption{A schematic mini project composed of the A, B, C, D, E, and F hierarchies (thick borders denote hierarchy roots). \label{figureIllustrativeExampleCB}}
\end{center}
\end{figure}
"

	self assert: (writer visit: mic) contents equals: '

\begin{figure}

\begin{center}
\includegraphics[width=1.0\textwidth]{/anUrl?label=figureTest&size=80}\caption{\label{figureTest}}
\end{center}
\end{figure}

'
]

{ #category : #'tests - references' }
MicLaTeXWriterTest >> testFigureBold [
	| mic |
	mic := parser parse: factory figureBoldSample.
	self assert: (writer visit: mic) contents equals: '

\begin{figure}

\begin{center}
\includegraphics[width=1.0\textwidth]{/anUrl?label=figureTest&size=80}\caption{\textbf{Foo}\label{figureTest}}
\end{center}
\end{figure}

'
]

{ #category : #tests }
MicLaTeXWriterTest >> testFootnote [
	| mic |
	mic := parser parse: factory footnoteSample.
	self assert: (writer visit: mic) contents equals: '
\footnote{Pharo is cool}
'
]

{ #category : #'tests - header' }
MicLaTeXWriterTest >> testHeaderLevel1 [
	| mic |
	mic := parser parse: factory headerLevel1Sample.
	self assert: (writer visit: mic) contents equals: '
\part{Foo}'
]

{ #category : #'tests - header' }
MicLaTeXWriterTest >> testHeaderLevel2 [
	| mic |
	mic := parser parse: factory headerLevel2Sample.
	self assert: (writer visit: mic) contents equals: '
\chapter{Foo}'
]

{ #category : #'tests - header' }
MicLaTeXWriterTest >> testHeaderLevel3 [
	| mic |
	mic := parser parse: factory headerLevel3Sample.
	self assert: (writer visit: mic) contents equals: '
\section{Foo}'
]

{ #category : #'tests - header' }
MicLaTeXWriterTest >> testHeaderLevel4 [
	| mic |
	mic := parser parse: factory headerLevel4Sample.
	self assert: (writer visit: mic) contents equals: '
\subsection{Foo}'
]

{ #category : #'tests - header' }
MicLaTeXWriterTest >> testHeaderLevel5 [
	| mic |
	mic := parser parse: factory headerLevel5Sample.
	self assert: (writer visit: mic) contents equals: '
\subsubsection{Foo}'
]

{ #category : #'tests - header' }
MicLaTeXWriterTest >> testHeaderLevel6 [
	| mic |
	mic := parser parse: factory headerLevel6Sample.
	self assert: (writer visit: mic) contents equals: '
\paragraph{Foo}'
]

{ #category : #tests }
MicLaTeXWriterTest >> testHorizontalLine [
	| mic |
	mic := parser parse: factory horizontalLineSample.
	self assert: (writer visit: mic) contents equals: '

\rule{\textwidth}{0.1pt}
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

{ #category : #'tests - references' }
MicLaTeXWriterTest >> testLink [
	| mic |
	mic := parser parse: factory linkSample.
	self flag: #tofix.
	"footnotesize"
	
	self assert: (writer visit: mic) contents equals: '
\href{/anUrl}{Foo}\footnote{\url{/anUrl}}
'
]

{ #category : #'tests - references' }
MicLaTeXWriterTest >> testLinkBold [
	| mic |
	self flag: 'caption do not use bold in the caption'.
	mic := parser parse: factory linkBoldSample.
	self flag: #toFix.
	"\textbf{Foo}"
	self assert: (writer visit: mic) contents equals: '
\href{/anUrl}{**Foo**}\footnote{\url{/anUrl}}
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

{ #category : #'tests - lists' }
MicLaTeXWriterTest >> testOrderedNestedListNested [
	| mic |
	mic := parser parse: factory nestedOrderedListSample.
	self assert: (writer visit: mic) contents equals: '
\begin{itemize}
    \item Foo
    \item Bar
    \begin{enumerate}
        \item B
        \item a
        \item r
    \end{enumerate}

\end{itemize}
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

{ #category : #tests }
MicLaTeXWriterTest >> testTable [
	| mic |
	mic := parser parse: (factory tableSample).
	self assert: (writer visit: mic) contents equals: '
\begin{tabular}{ll}
\toprule
\textbf{aaab} & \textbf{jkhjh} \\
\midrule
bar & rab \\
\bottomrule
\end{tabular}
'
]

{ #category : #tests }
MicLaTeXWriterTest >> testTableWhithoutHeader [
	| mic |
	mic := parser parse: (factory simpleTableWithoutHeaderTable).
	self assert: (writer visit: mic) contents equals: '
\begin{tabular}{ll}
\toprule
aaab & jkhjh \\
bar & rab \\
\bottomrule
\end{tabular}
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

{ #category : #'tests - lists' }
MicLaTeXWriterTest >> testUnorderedNestedListNested [
	| mic |
	mic := parser parse: factory nestedUnorderedListSample.
	self assert: (writer visit: mic) contents equals: '
\begin{itemize}
    \item Foo
    \item Bar
    \begin{itemize}
        \item B
        \item a
        \item r
    \end{itemize}

\end{itemize}
'
]

{ #category : #tests }
MicLaTeXWriterTest >> testUrlsAreProtected [
	self assert: (writer protectUrl: '#') equals: '\#'.
	self assert: (writer protectUrl: '~') equals: '~'.
	self assert: (writer protectUrl: '&') equals: '&'.
	self assert: (writer protectUrl: '%') equals: '\%'.
	self assert: (writer protectUrl: '\') equals: '\\'.
	self assert: (writer protectUrl: '\~#%') equals: '\\~\#\%'.
]
