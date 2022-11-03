Class {
	#name : #MicLaTeXWriterTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'parser',
		'writer',
		'factory',
		'newLine'
	],
	#category : #'Microdown-LaTeXExporter-Tests'
}

{ #category : #asserting }
MicLaTeXWriterTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #asserting }
MicLaTeXWriterTest class >> testParameters [

	^ ParametrizedTestMatrix new
		  forSelector: #writer addOptions: { MicLaTeXWriter };
		  forSelector: #factory addOptions: { MicMicrodownSnippetFactory };
		  forSelector: #parser addOptions: { Microdown };
		  forSelector: #newLine addOptions: { String cr . String lf . String crlf};
		  yourself
]

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
	self writeForElement: aDocumentItem.
	result := writer contents.
	self assert: result includesSubstring: aString
]

{ #category : #helpers }
MicLaTeXWriterTest >> assertWriting: aDocumentItem includesTexts: aCollection [
	| resultString |
	self writeForElement: aDocumentItem.
	resultString := writer contents.
	aCollection do: [ :testString | self assert: resultString includesSubstring: testString ]
]

{ #category : #accessing }
MicLaTeXWriterTest >> factory: aFactory [
	factory := aFactory new
]

{ #category : #accessing }
MicLaTeXWriterTest >> newLine: aNewLine [
	(aNewLine = String cr) ifTrue:[ writer crAsNewLine ].
	(aNewLine = String lf) ifTrue:[ writer lfAsNewLine ].
	(aNewLine = String crlf) ifTrue:[ writer crlfAsNewLine ].
	newLine := aNewLine
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
	self assert: writer contents equals: newLine , aResultingString, newLine
]

{ #category : #accessing }
MicLaTeXWriterTest >> parser: aParser [
	parser := aParser new
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

	self parseInlined: '{!citation|ref=Duca99a!}' andCheckWeGet: '\cite{Duca99a}'
]

{ #category : #tests }
MicLaTeXWriterTest >> testCodeblock [

	self writeFor: (factory codeblockNoParamBody: 'this is a code').
	self assert: writer contents equals: '\begin{listing}', newLine ,
													'this is a code', newLine ,
													'\end{listing}', newLine
]

{ #category : #tests }
MicLaTeXWriterTest >> testCodeblockWithCaption [

	self writeFor: (factory codeblock: 'caption=Pharo is **cool**' body: 'this is a code').
	self assert: writer contents equals: '\begin{listing}[caption={Pharo is \textbf{cool}}]', newLine,
													'this is a code', newLine,
													'\end{listing}', newLine
]

{ #category : #tests }
MicLaTeXWriterTest >> testCodeblockWithLabel [

	self writeFor: (factory codeblock: 'label=Pharo' body: 'this is a code').
	self assert: writer contents equals: '\begin{listing}[label=Pharo]', newLine ,
													'this is a code', newLine ,
													'\end{listing}', newLine 
]

{ #category : #'tests - breaklining' }
MicLaTeXWriterTest >> testCrAsNewLine [ 

	writer crAsNewLine.
	self assert: writer canvas stream configuration newLine equals: Character cr
]

{ #category : #'tests - breaklining' }
MicLaTeXWriterTest >> testCrlfAsNewLine [ 

	writer crlfAsNewLine.
	self assert: writer canvas stream configuration newLine equals: String crlf
]

{ #category : #'tests - figure/link' }
MicLaTeXWriterTest >> testFigure [

	self writeFor: factory figureSample.
	self assert: writer contents equals: newLine ,
					'\begin{figure}[htpb]', newLine ,
					'\begin{center}', newLine ,
					'\includegraphics[width=0.8\textwidth]{/anUrl}', newLine ,
					'\caption{Foo}\label{figureTest}', newLine ,
					'\end{center}', newLine ,
					'\end{figure}', newLine, newLine
]

{ #category : #'tests - figure/link' }
MicLaTeXWriterTest >> testFigureBold [
	self writeFor: factory figureBoldSample.
	self assert: writer contents equals: newLine,
					'\begin{figure}[htpb]', newLine ,
					'\begin{center}', newLine ,
					'\includegraphics[width=0.8\textwidth]{/anUrl}', newLine ,
					'\caption{\textbf{Foo}}\label{figureTest}', newLine ,
					'\end{center}', newLine ,
					'\end{figure}', newLine , newLine
]

{ #category : #'tests - figure/link' }
MicLaTeXWriterTest >> testFigureRealSample [

	self writeFor: factory figureRealSample.
	self assert: writer contents equals: newLine ,
'\begin{figure}[htpb]', newLine ,
'\begin{center}', newLine ,
'\includegraphics[width=0.8\textwidth]{figures/logo.png}', newLine ,
'\caption{A logo png under figures folder}\label{figureTest}', newLine ,
'\end{center}', newLine ,
'\end{figure}', newLine, newLine
.
self flag: #todo.
"may be we should get figures/logo.png when file://figures/logo.png"

]

{ #category : #tests }
MicLaTeXWriterTest >> testFootnote [

	self parseInlined: factory footnoteSample andCheckWeGet: '\footnote{Pharo is cool}'
	
]

{ #category : #'tests - header' }
MicLaTeXWriterTest >> testHeaderLevel1 [

	self parse: factory headerLevel1Sample andCheckWeGet: newLine , '\part{Foo}'
	
]

{ #category : #'tests - header' }
MicLaTeXWriterTest >> testHeaderLevel2 [

	self parse: factory headerLevel2Sample andCheckWeGet: newLine  , '\chapter{Foo}'
]

{ #category : #'tests - header' }
MicLaTeXWriterTest >> testHeaderLevel3 [

	self parse: factory headerLevel3Sample andCheckWeGet: newLine , '\section{Foo}'
]

{ #category : #'tests - header' }
MicLaTeXWriterTest >> testHeaderLevel4 [

	self parse: factory headerLevel4Sample andCheckWeGet: newLine , '\subsection{Foo}'
]

{ #category : #'tests - header' }
MicLaTeXWriterTest >> testHeaderLevel5 [

	self parse: factory headerLevel5Sample andCheckWeGet: newLine , '\subsubsection{Foo}'
]

{ #category : #'tests - header' }
MicLaTeXWriterTest >> testHeaderLevel6 [
	
   self parse: factory headerLevel6Sample andCheckWeGet: newLine , '\paragraph{Foo}'
]

{ #category : #tests }
MicLaTeXWriterTest >> testHorizontalLine [

	self parseInlined: factory horizontalLineSample andCheckWeGet: '\rule{\textwidth}{0.1pt}'
]

{ #category : #'tests - formats' }
MicLaTeXWriterTest >> testItalic [

	self parseInlined: factory italicFormatSample andCheckWeGet: '\textit{Foo}'
]

{ #category : #'tests - breaklining' }
MicLaTeXWriterTest >> testLfAsNewLine [ 

	writer lfAsNewLine.
	self assert: writer canvas stream configuration newLine equals: Character lf
]

{ #category : #'tests - figure/link' }
MicLaTeXWriterTest >> testLink [
	self writeFor: factory linkSample.		
	self assert: writer contents equals: newLine,
'\href{/anUrl}{Foo}\footnotesize{\url{/anUrl}}', newLine
]

{ #category : #'tests - figure/link' }
MicLaTeXWriterTest >> testLinkBold [

	self writeFor: factory linkBoldSample.
	self assert: writer contents equals: newLine ,
		'\href{/anUrl}{\textbf{Foo}}\footnotesize{\url{/anUrl}}', newLine
]

{ #category : #'tests - formats' }
MicLaTeXWriterTest >> testMonospace [

	self parseInlined: factory monospaceFormatSample andCheckWeGet: '\code{Foo}'
]

{ #category : #'tests - lists' }
MicLaTeXWriterTest >> testOrderedList [
	
	self writeFor: factory orderedListWithTwoItemsSample.
	self assert: writer contents equals: newLine,
						'\begin{enumerate}', newLine ,
						'    \item first', newLine ,
						'    \item second', newLine ,
						'\end{enumerate}', newLine
]

{ #category : #'tests - lists' }
MicLaTeXWriterTest >> testOrderedListBold [

	self writeFor: factory orderedListWithTwoItemsBoldSample.
	self assert: writer contents equals: newLine ,
						'\begin{enumerate}', newLine ,
						'    \item \textbf{first}', newLine ,
						'    \item second', newLine ,
						'\end{enumerate}', newLine
]

{ #category : #'tests - lists' }
MicLaTeXWriterTest >> testOrderedListNested [

	self writeFor:  factory orderedListWithTwoItemsBoldFirstSample.
	self assert: writer contents equals: newLine, 
						'\begin{enumerate}', newLine ,
						'    \item \textbf{\textit{first}}', newLine ,
						'    \item second', newLine ,
						'\end{enumerate}', newLine
]

{ #category : #'tests - lists' }
MicLaTeXWriterTest >> testOrderedNestedListNested [

	self writeFor: factory nestedOrderedListSample. 
	self assert: writer contents equals: newLine ,
							'\begin{itemize}', newLine ,
							'    \item Foo', newLine ,
							'    \item Bar', newLine ,
							'    \begin{enumerate}', newLine ,
							'        \item B', newLine ,
							'        \item a', newLine ,
							'        \item r', newLine ,
							'    \end{enumerate}', newLine ,
							'\end{itemize}', newLine
]

{ #category : #'tests - lists' }
MicLaTeXWriterTest >> testOrderedNestedListNested2 [

	self writeFor: factory nestedOrderedList2Sample. 
	self assert: writer contents  equals: newLine ,
							'\begin{itemize}', newLine ,
							'    \item Foo', newLine ,
							'    \item Bar', newLine ,
							'    \begin{enumerate}', newLine ,
							'        \item B', newLine ,
							'        \item a', newLine ,
							'        \item r', newLine ,
							'        \begin{itemize}', newLine ,
							'            \item 3rdlvel', newLine ,
							'            \item 3rdlevl2', newLine ,
							'        \end{itemize}', newLine ,
							'    \end{enumerate}', newLine ,
							'    \item Zork', newLine ,
							'\end{itemize}', newLine 
]

{ #category : #'tests - paragraph' }
MicLaTeXWriterTest >> testParagraph [
	
	self parse: factory paragraphSample andCheckWeGet: newLine,
															'Foo',newLine

]

{ #category : #'tests - paragraph' }
MicLaTeXWriterTest >> testParagraphLongWithAccents [

		self parse: factory paragraphOnMultipleLinesSample andCheckWeGet:  newLine,
'Je ne connais pas la peur, car la peur tue l''esprit. La peur est la petite mort qui conduit \`{a} l''oblit\''{e}ration totale. J''affonterai ma peur. Je lui permettrais de passer sur moi, au travers de moi. Et lorsqu''elle sera pass\''{e}e, je tournerai mon oeil interieur sur son chemin. Et l\`{a} o\`{u} elle sera pass\''{e}e, il n''y aura plus rien, rien que moi.', newLine
]

{ #category : #'tests - paragraph' }
MicLaTeXWriterTest >> testParagraphWithBold [

	self parse: factory paragraphBoldSample andCheckWeGet:  newLine ,
									'this is a \textbf{paragraph}', newLine
]

{ #category : #'tests - paragraph' }
MicLaTeXWriterTest >> testParagraphWithItalic [

	self parse: factory paragraphItalicSample andCheckWeGet:  newLine ,
									'this is a \textit{paragraph}', newLine
]

{ #category : #'tests - paragraph' }
MicLaTeXWriterTest >> testParagraphWithMonospace [
	
	self parse: factory paragraphMonospaceSample andCheckWeGet:  newLine ,
'this is a \code{paragraph}', newLine 

]

{ #category : #'tests - paragraph' }
MicLaTeXWriterTest >> testParagraphWithNested [

	self parse: factory paragraphNestedSample andCheckWeGet:  newLine ,
'this is a \textbf{\textit{paragraph}}', newLine
]

{ #category : #tests }
MicLaTeXWriterTest >> testQuote [

	self parse: factory quoteSample andCheckWeGet:  '\begin{verbatim}', newLine ,
																	'Foo', newLine ,
																	'\end{verbatim}', newLine
]

{ #category : #'tests - figure/link' }
MicLaTeXWriterTest >> testRealLinkSample [
	self writeFor: factory realLinkSample.	
	self assert: writer contents equals: newLine ,
'\href{http://www.pharo.org}{The Pharo Project}\footnotesize{\url{http://www.pharo.org}}', newLine 
]

{ #category : #'tests - formats' }
MicLaTeXWriterTest >> testStrike [

	self parseInlined: factory strikethroughFormatSample andCheckWeGet: '\sout{Foo}'
		
]

{ #category : #tests }
MicLaTeXWriterTest >> testTable [
	self writeFor: factory tableSample.
	self assert: writer contents equals: newLine,
													'\begin{tabular}{ll}', newLine ,
													'\toprule', newLine ,
													'\textbf{aaab} & \textbf{jkhjh} \\', newLine ,
													'\midrule', newLine ,
													'bar & rab \\', newLine ,
													'\bottomrule', newLine ,
													'\end{tabular}', newLine
]

{ #category : #tests }
MicLaTeXWriterTest >> testTableWhithoutHeader [
	
	self writeFor: (factory simpleTableWithoutHeaderTable).
	self assert: writer contents equals: newLine,
													'\begin{tabular}{ll}', newLine ,
													'\toprule', newLine ,
													'aaab & jkhjh \\', newLine ,
													'bar & rab \\', newLine ,
													'\bottomrule', newLine ,
													'\end{tabular}', newLine
]

{ #category : #'tests - lists' }
MicLaTeXWriterTest >> testUnorderedList [

	self writeFor: factory unorderedListWithTwoItemsSample.
	self assert: writer contents equals: newLine, 
							'\begin{itemize}', newLine ,
							'    \item Foo', newLine ,
							'    \item Bar', newLine ,
							'\end{itemize}', newLine
]

{ #category : #'tests - lists' }
MicLaTeXWriterTest >> testUnorderedListBold [

	self writeFor: factory unorderedListWithTwoItemsBoldSample.
	self assert: writer contents equals: newLine ,
							'\begin{itemize}', newLine ,
							'    \item \textbf{Foo}', newLine ,
							'    \item Bar', newLine ,
							'\end{itemize}', newLine
]

{ #category : #'tests - lists' }
MicLaTeXWriterTest >> testUnorderedListNested [

	self writeFor: factory unorderedListWithTwoItemsNestedSample.
	self assert: writer contents equals: newLine ,
							'\begin{itemize}', newLine ,
							'    \item \sout{\textit{Foo}}', newLine ,
							'    \item Bar', newLine ,
							'\end{itemize}', newLine
]

{ #category : #'tests - lists' }
MicLaTeXWriterTest >> testUnorderedNestedListNested [

	self writeFor: factory nestedUnorderedListSample. 
	self assert: writer contents equals: newLine ,
							'\begin{itemize}', newLine ,
							'    \item Foo', newLine ,
							'    \item Bar', newLine ,
							'    \begin{itemize}', newLine ,
							'        \item B', newLine ,
							'        \item a', newLine ,
							'        \item r', newLine ,
							'    \end{itemize}', newLine ,
							'\end{itemize}', newLine

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

{ #category : #'tests - breaklining' }
MicLaTeXWriterTest >> testWriteAParagraphWithCr [
	writer crAsNewLine.
	writer canvas nextPutAllLines: 'Je ne vois pas pourquoi
cela ne fonctionnerais pas
car il a etait fait pour cela'.
	self assert: writer canvas stream contents equals: 'Je ne vois pas pourquoi', String cr ,
'cela ne fonctionnerais pas', String cr,
'car il a etait fait pour cela'
]

{ #category : #'tests - breaklining' }
MicLaTeXWriterTest >> testWriteAParagraphWithCrButNewLineIsCrlf [
	writer crlfAsNewLine.
	writer canvas nextPutAllLines: 'Je ne vois pas pourquoi
cela ne fonctionnerais pas
car il a etait fait pour cela'.
	self deny: writer canvas stream contents equals: 'Je ne vois pas pourquoi', String cr ,
'cela ne fonctionnerais pas', String cr,
'car il a etait fait pour cela'
]

{ #category : #'tests - breaklining' }
MicLaTeXWriterTest >> testWriteAParagraphWithCrButNewLineIsLf [
	writer lfAsNewLine.
	writer canvas nextPutAllLines: 'Je ne vois pas pourquoi
cela ne fonctionnerais pas
car il a etait fait pour cela'.
	self deny: writer canvas stream contents equals: 'Je ne vois pas pourquoi', String cr ,
'cela ne fonctionnerais pas', String cr,
'car il a etait fait pour cela'
]

{ #category : #'tests - breaklining' }
MicLaTeXWriterTest >> testWriteAParagraphWithCrlf [
	writer crlfAsNewLine .
	writer canvas nextPutAllLines: 'Je ne vois pas pourquoi
cela ne fonctionnerais pas
car il a etait fait pour cela'.
	self assert: writer canvas stream contents equals: 'Je ne vois pas pourquoi', String crlf ,
'cela ne fonctionnerais pas', String crlf,
'car il a etait fait pour cela'
]

{ #category : #'tests - breaklining' }
MicLaTeXWriterTest >> testWriteAParagraphWithCrlfButNewLineIsCr [
	writer crAsNewLine.
	writer canvas nextPutAllLines: 'Je ne vois pas pourquoi
cela ne fonctionnerais pas
car il a etait fait pour cela'.
	self deny: writer canvas stream contents equals: 'Je ne vois pas pourquoi', String crlf ,
'cela ne fonctionnerais pas', String crlf,
'car il a etait fait pour cela'
]

{ #category : #'tests - breaklining' }
MicLaTeXWriterTest >> testWriteAParagraphWithCrlfButNewLineIsLf [
	writer lfAsNewLine.
	writer canvas nextPutAllLines: 'Je ne vois pas pourquoi
cela ne fonctionnerais pas
car il a etait fait pour cela'.
	self deny: writer canvas stream contents equals: 'Je ne vois pas pourquoi', String crlf ,
'cela ne fonctionnerais pas', String crlf,
'car il a etait fait pour cela'
]

{ #category : #'tests - breaklining' }
MicLaTeXWriterTest >> testWriteAParagraphWithLf [
	writer lfAsNewLine.
	writer canvas nextPutAllLines: 'Je ne vois pas pourquoi
cela ne fonctionnerais pas
car il a etait fait pour cela'.
	self assert: writer canvas stream contents equals: 'Je ne vois pas pourquoi', String lf ,
'cela ne fonctionnerais pas', String lf,
'car il a etait fait pour cela'
]

{ #category : #'tests - breaklining' }
MicLaTeXWriterTest >> testWriteAParagraphWithLfButNewLineIsCr [
	writer crAsNewLine.
	writer canvas nextPutAllLines: 'Je ne vois pas pourquoi
cela ne fonctionnerais pas
car il a etait fait pour cela'.
	self deny: writer canvas stream contents equals: 'Je ne vois pas pourquoi', String lf ,
'cela ne fonctionnerais pas', String lf,
'car il a etait fait pour cela'
]

{ #category : #'tests - breaklining' }
MicLaTeXWriterTest >> testWriteAParagraphWithLfButNewLineIsCrlf [
	writer crlfAsNewLine.
	writer canvas nextPutAllLines: 'Je ne vois pas pourquoi
cela ne fonctionnerais pas
car il a etait fait pour cela'.
	self deny: writer canvas stream contents equals: 'Je ne vois pas pourquoi', String lf ,
'cela ne fonctionnerais pas', String lf,
'car il a etait fait pour cela'
]

{ #category : #tests }
MicLaTeXWriterTest >> writeFor: aString [ 
	| mic |
	mic := parser parse: aString.
	writer visit: mic.

]

{ #category : #tests }
MicLaTeXWriterTest >> writeForElement: aNode [

	writer visit: aNode.

]

{ #category : #accessing }
MicLaTeXWriterTest >> writer: aWriter [
	writer := aWriter new
]
