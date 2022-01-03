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
MicLaTeXWriterTest >> actualClass [

	^ MicLaTeXWriter
]

{ #category : #helpers }
MicLaTeXWriterTest >> assert: result includesSubstring: expected [

	expected ifEmpty: [ ^ self ].
	self 
		assert: (result includesSubstring: expected) 
		description: ('''{1}'' not in ''{2}''' format: {expected . result})
]

{ #category : #helpers }
MicLaTeXWriterTest >> assertWriting: aDocumentItem includesText: aString [
	| result |
	result := (writer visit: aDocumentItem) contents.
	self assert: result includesSubstring: aString
]

{ #category : #'tests - formats' }
MicLaTeXWriterTest >> parse: aString andCheckWeGet: aResultingString [
	
	| mic |
	mic := parser parse: 	aString.
	writer visit: mic.
	self assert: writer contents equals: aResultingString
]

{ #category : #'tests - formats' }
MicLaTeXWriterTest >> parseInlined: aString andCheckWeGet: aResultingString [
	
	| mic |
	mic := parser parse: 	aString.
	writer visit: mic.
	self assert: writer contents equals: writer usedNewLine, aResultingString, writer usedNewLine
]

{ #category : #running }
MicLaTeXWriterTest >> setUp [

	super setUp.
	parser := MicroDownParser new.
	writer := self actualClass new.
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

	self writeLaTeXFor: (factory codeblockNoParamBody: 'this is a code').
	self assert: writer contents equals: '
\begin{listing}
this is a code
\end{listing}
'
]

{ #category : #tests }
MicLaTeXWriterTest >> testCodeblockWithCaption [

	self writeLaTeXFor: (factory codeblock: 'caption=Pharo is **cool**' body: 'this is a code').
	self assert: writer contents equals: '
\begin{listing}[caption={Pharo is \textbf{cool}}]
this is a code
\end{listing}
'
]

{ #category : #tests }
MicLaTeXWriterTest >> testCodeblockWithLabel [

	self writeLaTeXFor: (factory codeblock: 'label=Pharo' body: 'this is a code').
	self assert: writer contents equals: '
\begin{listing}[label=Pharo]
this is a code
\end{listing}
'
]

{ #category : #'tests - figure/link' }
MicLaTeXWriterTest >> testFigure [

	self writeLaTeXFor: factory figureSample.
	self assert: writer contents equals: '

\begin{figure}[htpb]

\begin{center}
\includegraphics[width=0.8\textwidth]{/anUrl}
\caption{Foo}\label{figureTest}
\end{center}
\end{figure}

'
]

{ #category : #'tests - figure/link' }
MicLaTeXWriterTest >> testFigureBold [
	self writeLaTeXFor: factory figureBoldSample.
	self assert: writer contents equals: '

\begin{figure}[htpb]

\begin{center}
\includegraphics[width=0.8\textwidth]{/anUrl}
\caption{\textbf{Foo}}\label{figureTest}
\end{center}
\end{figure}

'
]

{ #category : #'tests - figure/link' }
MicLaTeXWriterTest >> testFigureRealSample [

	self writeLaTeXFor: factory figureRealSample.
	self assert: writer contents equals: '

\begin{figure}[htpb]

\begin{center}
\includegraphics[width=0.8\textwidth]{/logo.png}
\caption{A logo png under figures folder}\label{figureTest}
\end{center}
\end{figure}

'.
self flag: #todo.
"may be we should get figures/logo.png when file://figures/logo.png"

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
	self writeLaTeXFor: factory linkSample.		
	self assert: writer contents equals: '
\href{/anUrl}{Foo}\footnotesize{\url{/anUrl}}
'
]

{ #category : #'tests - figure/link' }
MicLaTeXWriterTest >> testLinkBold [

	self flag: 'caption do not use bold in the caption'.
	self writeLaTeXFor: factory linkBoldSample.
	self flag: #toFix.
	"\textbf{Foo}" 
	self assert: writer contents equals: '
\href{/anUrl}{**Foo**}\footnotesize{\url{/anUrl}}
'
]

{ #category : #'tests - formats' }
MicLaTeXWriterTest >> testMonospace [

	self parseInlined: factory monospaceFormatSample andCheckWeGet: '\code{Foo}'
]

{ #category : #'tests - lists' }
MicLaTeXWriterTest >> testOrderedList [
	
	self writeLaTeXFor: factory orderedListWithTwoItemsSample.
	self assert: writer contents equals: '
\begin{enumerate}
    \item first
    \item second
\end{enumerate}
'
]

{ #category : #'tests - lists' }
MicLaTeXWriterTest >> testOrderedListBold [

	self writeLaTeXFor: factory orderedListWithTwoItemsBoldSample.
	self assert: writer contents equals: '
\begin{enumerate}
    \item \textbf{first}
    \item second
\end{enumerate}
'
]

{ #category : #'tests - lists' }
MicLaTeXWriterTest >> testOrderedListNested [

	self writeLaTeXFor:  factory orderedListWithTwoItemsBoldFirstSample.
	self assert: writer contents equals: '
\begin{enumerate}
    \item \textbf{\textit{first}}
    \item second
\end{enumerate}
'
]

{ #category : #'tests - lists' }
MicLaTeXWriterTest >> testOrderedNestedListNested [

	self writeLaTeXFor: factory nestedOrderedListSample. 
	self assert: writer contents equals: '
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

	self writeLaTeXFor: factory nestedOrderedList2Sample. 
	self assert: writer contents  equals: '
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

{ #category : #'tests - figure/link' }
MicLaTeXWriterTest >> testRealLinkSample [
	self writeLaTeXFor: factory realLinkSample.	
	self assert: writer contents equals: '
\href{http://www.pharo.org}{The Pharo Project}\footnotesize{\url{http://www.pharo.org}}
'
]

{ #category : #'tests - formats' }
MicLaTeXWriterTest >> testStrike [

	self parseInlined: factory strikethroughFormatSample andCheckWeGet: '\sout{Foo}'
		
]

{ #category : #tests }
MicLaTeXWriterTest >> testTable [
	self writeLaTeXFor: factory tableSample.
	self assert: writer contents equals: '
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
	
	self writeLaTeXFor: (factory simpleTableWithoutHeaderTable).
	self assert: writer contents equals: '
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

	self writeLaTeXFor: factory unorderedListWithTwoItemsSample.
	self assert: writer contents equals: '
\begin{itemize}
    \item Foo
    \item Bar
\end{itemize}
'
]

{ #category : #'tests - lists' }
MicLaTeXWriterTest >> testUnorderedListBold [

	self writeLaTeXFor: factory unorderedListWithTwoItemsBoldSample.
	self assert: writer contents equals: '
\begin{itemize}
    \item \textbf{Foo}
    \item Bar
\end{itemize}
'
]

{ #category : #'tests - lists' }
MicLaTeXWriterTest >> testUnorderedListNested [

	self writeLaTeXFor: factory unorderedListWithTwoItemsNestedSample.
	self assert: writer contents equals: '
\begin{itemize}
    \item \sout{\textit{Foo}}
    \item Bar
\end{itemize}
'
]

{ #category : #'tests - lists' }
MicLaTeXWriterTest >> testUnorderedNestedListNested [

	self writeLaTeXFor: factory nestedUnorderedListSample. 
	self assert: writer contents equals: '
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

{ #category : #tests }
MicLaTeXWriterTest >> writeLaTeXFor: aString [ 
	| mic |
	mic := parser parse: aString.
	writer visit: mic.

]

{ #category : #tests }
MicLaTeXWriterTest >> writeLaTeXForElement: aNode [

	writer visit: aNode.

]
