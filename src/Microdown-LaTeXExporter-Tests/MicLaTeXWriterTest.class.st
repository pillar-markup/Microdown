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

{ #category : #'tests - formats' }
MicLaTeXWriterTest >> parse: aString andCheckWeGet: aResultingString [
	
	| mic |
	mic := parser parse: 	aString.
	self assert: (writer visit: mic) contents equals: aResultingString
]

{ #category : #'tests - formats' }
MicLaTeXWriterTest >> parseInlined: aString andCheckWeGet: aResultingString [
	
	| mic |
	mic := parser parse: 	aString.
	self assert: (writer visit: mic) contents equals: writer usedNewLine, aResultingString, writer usedNewLine
]

{ #category : #running }
MicLaTeXWriterTest >> setUp [
	super setUp.
	parser := MicroDownParser new.
	writer := MicLaTeXWriter new.
	factory := MicMicrodownSnippetFactory new
]

{ #category : #tests }
MicLaTeXWriterTest >> testAnchor [

	self parse: factory anchorSample andCheckWeGet: '\label{test}'

]

{ #category : #tests }
MicLaTeXWriterTest >> testAnchorReference [
	"Pay attention that an anchor reference only exists within a paragraph and as such a paragraph emit a newline to start."
	self parseInlined: factory anchorReferenceSample andCheckWeGet: '\ref{Foo}'
	
]

{ #category : #'tests - formats' }
MicLaTeXWriterTest >> testBold [

	self parseInlined: factory boldFormatSample andCheckWeGet: '\textbf{Foo}'
]

{ #category : #tests }
MicLaTeXWriterTest >> testCitation [

	self parseInlined: '?{citation|ref=Duca99a}?' andCheckWeGet: '\cite{Duca99a}'
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

{ #category : #'tests - figure/link' }
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

{ #category : #'tests - figure/link' }
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

	self parseInlined: factory footnoteSample andCheckWeGet: '\footnote{Pharo is cool}'
	
]

{ #category : #'tests - header' }
MicLaTeXWriterTest >> testHeaderLevel1 [

	self parse: factory headerLevel1Sample andCheckWeGet: writer usedNewLine , '\part{Foo}'
	
]

{ #category : #'tests - header' }
MicLaTeXWriterTest >> testHeaderLevel2 [

	self parse: factory headerLevel2Sample andCheckWeGet: writer usedNewLine , '\chapter{Foo}'
]

{ #category : #'tests - header' }
MicLaTeXWriterTest >> testHeaderLevel3 [

	self parse: factory headerLevel3Sample andCheckWeGet: writer usedNewLine , '\section{Foo}'
]

{ #category : #'tests - header' }
MicLaTeXWriterTest >> testHeaderLevel4 [

	self parse: factory headerLevel4Sample andCheckWeGet: writer usedNewLine , '\subsection{Foo}'
]

{ #category : #'tests - header' }
MicLaTeXWriterTest >> testHeaderLevel5 [

	self parse: factory headerLevel5Sample andCheckWeGet: writer usedNewLine , '\subsubsection{Foo}'
]

{ #category : #'tests - header' }
MicLaTeXWriterTest >> testHeaderLevel6 [
	
   self parse: factory headerLevel6Sample andCheckWeGet: writer usedNewLine , '\paragraph{Foo}'
]

{ #category : #tests }
MicLaTeXWriterTest >> testHorizontalLine [


	self parseInlined: factory horizontalLineSample andCheckWeGet: '\rule{\textwidth}{0.1pt}'
]

{ #category : #'tests - formats' }
MicLaTeXWriterTest >> testItalic [

	self parseInlined: factory italicFormatSample andCheckWeGet: '\textit{Foo}'
]

{ #category : #'tests - figure/link' }
MicLaTeXWriterTest >> testLink [
	| mic |
	mic := parser parse: factory linkSample.
	self flag: #tofix.
	"footnotesize"
	
	self assert: (writer visit: mic) contents equals: '
\href{/anUrl}{Foo}\footnote{\url{/anUrl}}
'
]

{ #category : #'tests - figure/link' }
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

	self parseInlined: factory monospaceFormatSample andCheckWeGet: '\code{Foo}'
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
	mic := parser parse: factory orderedListWithTwoItemsBoldFirstSample.
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

{ #category : #'tests - lists' }
MicLaTeXWriterTest >> testOrderedNestedListNested2 [
	| mic |
	mic := parser parse: factory nestedOrderedList2Sample.
	self assert: (writer visit: mic) contents  equals: '
\begin{itemize}
    \item Foo
    \item Bar
    \begin{enumerate}
        \item B
        \item a
        \item r
        \begin{itemize}
            \item 3rdlvel
            \item 3rdlevl2
        \end{itemize}
    \end{enumerate}
    \item Zork
\end{itemize}
'
]

{ #category : #'tests - paragraph' }
MicLaTeXWriterTest >> testParagraph [
	
	self parse: factory paragraphSample andCheckWeGet: '
Foo
'
]

{ #category : #'tests - paragraph' }
MicLaTeXWriterTest >> testParagraphLongWithAccents [

		self parse: factory paragraphOnMultipleLinesSample andCheckWeGet:  '
Je ne connais pas la peur, car la peur tue l''esprit. La peur est la petite mort qui conduit \`{a} l''oblit\''{e}ration totale. J''affonterai ma peur. Je lui permettrais de passer sur moi, au travers de moi. Et lorsqu''elle sera pass\''{e}e, je tournerai mon oeil interieur sur son chemin. Et l\`{a} o\`{u} elle sera pass\''{e}e, il n''y aura plus rien, rien que moi.
'
]

{ #category : #'tests - paragraph' }
MicLaTeXWriterTest >> testParagraphWithBold [

	self parse: factory paragraphBoldSample andCheckWeGet:  '
this is a \textbf{paragraph}
'
]

{ #category : #'tests - paragraph' }
MicLaTeXWriterTest >> testParagraphWithItalic [

	self parse: factory paragraphItalicSample andCheckWeGet:  '
this is a \textit{paragraph}
'
]

{ #category : #'tests - paragraph' }
MicLaTeXWriterTest >> testParagraphWithMonospace [
	
	self parse: factory paragraphMonospaceSample andCheckWeGet:  '
this is a \code{paragraph}
'

]

{ #category : #'tests - paragraph' }
MicLaTeXWriterTest >> testParagraphWithNested [

	self parse: factory paragraphNestedSample andCheckWeGet:  '
this is a \textbf{\textit{paragraph}}
'
]

{ #category : #tests }
MicLaTeXWriterTest >> testQuote [

	self parse: factory quoteSample andCheckWeGet:  '
\begin{verbatim}
Foo
\end{verbatim}
'
]

{ #category : #'tests - formats' }
MicLaTeXWriterTest >> testStrike [

	self parseInlined: factory strikethroughFormatSample andCheckWeGet: '\sout{Foo}'
		
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
