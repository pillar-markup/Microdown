Class {
	#name : 'MicAbstractLaTexWriterTest',
	#superclass : 'ParametrizedTestCase',
	#instVars : [
		'writer',
		'factory',
		'newLine',
		'parser'
	],
	#category : 'Microdown-LaTeXExporter-Tests',
	#package : 'Microdown-LaTeXExporter-Tests'
}

{ #category : 'asserting' }
MicAbstractLaTexWriterTest class >> shouldInheritSelectors [
	^ true
]

{ #category : 'asserting' }
MicAbstractLaTexWriterTest class >> testParameters [

	^ ParametrizedTestMatrix new
		  forSelector: #writer addOptions: { MicLaTeXWriter };
		  forSelector: #factory addOptions: { MicMicrodownSnippetFactory };
		  forSelector: #parser addOptions: { Microdown };
		  forSelector: #newLine addOptions: { String cr . String lf . String crlf};
		  yourself
]

{ #category : 'running' }
MicAbstractLaTexWriterTest >> actualClass [

	^ MicLaTeXWriter
]

{ #category : 'helpers' }
MicAbstractLaTexWriterTest >> assert: result includesSubstring: expected [

	expected ifEmpty: [ ^ self ].
	self 
		assert: (result includesSubstring: expected) 
		description: ('''{1}'' not in ''{2}''' format: {expected . result})
]

{ #category : 'helpers' }
MicAbstractLaTexWriterTest >> assertWriting: aDocumentItem includesText: aString [
	| result |
	self writeForElement: aDocumentItem.
	result := writer contents.
	self assert: result includesSubstring: aString
]

{ #category : 'helpers' }
MicAbstractLaTexWriterTest >> assertWriting: aDocumentItem includesTexts: aCollection [
	| resultString |
	self writeForElement: aDocumentItem.
	resultString := writer contents.
	aCollection do: [ :testString | self assert: resultString includesSubstring: testString ]
]

{ #category : 'accessing' }
MicAbstractLaTexWriterTest >> factory: aFactory [
	factory := aFactory new
]

{ #category : 'accessing' }
MicAbstractLaTexWriterTest >> newLine: aNewLine [
	(aNewLine = String cr) ifTrue:[ writer crAsNewLine ].
	(aNewLine = String lf) ifTrue:[ writer lfAsNewLine ].
	(aNewLine = String crlf) ifTrue:[ writer crlfAsNewLine ].
	newLine := aNewLine
]

{ #category : 'tests - formats' }
MicAbstractLaTexWriterTest >> parse: aString andCheckWeGet: aResultingString [
	
	| mic |
	mic := parser parse: 	aString.
	writer visit: mic.
	self assert: writer contents equals: aResultingString
]

{ #category : 'tests - formats' }
MicAbstractLaTexWriterTest >> parseInlined: aString andCheckWeGet: aResultingString [
	
	| mic |
	mic := parser parse: 	aString.
	writer visit: mic.
	self assert: writer contents equals: newLine , aResultingString, newLine
]

{ #category : 'accessing' }
MicAbstractLaTexWriterTest >> parser: aParser [
	parser := aParser new
]

{ #category : 'running' }
MicAbstractLaTexWriterTest >> setUp [ 

	super setUp.
	self parser: Microdown
]

{ #category : 'tests' }
MicAbstractLaTexWriterTest >> testAnchor [

	self parse: factory anchorSample andCheckWeGet: '\label{test}'

]

{ #category : 'tests' }
MicAbstractLaTexWriterTest >> testAnchorReference [
	"Pay attention that an anchor reference only exists within a paragraph and as such a paragraph emit a newline to start."
	
	self parseInlined: factory anchorReferenceSample andCheckWeGet: '\ref{Foo}'
	
]

{ #category : 'tests - figure/link' }
MicAbstractLaTexWriterTest >> testAnnotatedParagraph [
	
	self writeFor: factory annotatedSample.
	self assert: writer contents equals: newLine ,
					'\begin{note}', newLine ,
					'label Foo \textit{bar}', newLine ,
					'\end{note}'
]

{ #category : 'tests - formats' }
MicAbstractLaTexWriterTest >> testBold [

	self parseInlined: factory boldFormatSample andCheckWeGet: '\textbf{Foo}'
]

{ #category : 'tests' }
MicAbstractLaTexWriterTest >> testCitation [

	self parseInlined: '{!citation|ref=Duca99a!}' andCheckWeGet: '\cite{Duca99a}'
]

{ #category : 'tests - breaklining' }
MicAbstractLaTexWriterTest >> testCrAsNewLine [ 

	writer crAsNewLine.
	self assert: writer canvas stream configuration newLine equals: Character cr
]

{ #category : 'tests - breaklining' }
MicAbstractLaTexWriterTest >> testCrlfAsNewLine [ 

	writer crlfAsNewLine.
	self assert: writer canvas stream configuration newLine equals: String crlf
]

{ #category : 'tests - figure/link' }
MicAbstractLaTexWriterTest >> testFigure [
	
	self writeFor: factory figureSample.
	self assert: writer contents equals: newLine ,
					'\begin{figure}[htpb]', newLine ,
					'\begin{center}', newLine ,
					'\includegraphics[width=0.8\textwidth]{/anUrl}', newLine ,
					'\caption{Foo}\label{figureTest}', newLine ,
					'\end{center}', newLine ,
					'\end{figure}', newLine, newLine
]

{ #category : 'tests - figure/link' }
MicAbstractLaTexWriterTest >> testFigureBold [
	self writeFor: factory figureBoldSample.
	self assert: writer contents equals: newLine,
					'\begin{figure}[htpb]', newLine ,
					'\begin{center}', newLine ,
					'\includegraphics[width=0.8\textwidth]{/anUrl}', newLine ,
					'\caption{\textbf{Foo}}\label{figureTest}', newLine ,
					'\end{center}', newLine ,
					'\end{figure}', newLine , newLine
]

{ #category : 'tests - figure/link' }
MicAbstractLaTexWriterTest >> testFigureRealSample [

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

{ #category : 'tests - figure/link' }
MicAbstractLaTexWriterTest >> testFigureWithEmptyCaption [

	self writeFor: '![](figures/f.png)'.
	self
		assert: writer contents
		equals:
			newLine , '\begin{center}', newLine, '\includegraphics[width=1.0\textwidth]{figures/f.png}'
			, '\end{center}', newLine, newLine
]

{ #category : 'tests' }
MicAbstractLaTexWriterTest >> testFootnote [

	self parseInlined: factory footnoteSample andCheckWeGet: '\footnote{Pharo is cool}'
	
]

{ #category : 'tests - header' }
MicAbstractLaTexWriterTest >> testHeaderLevel1 [

	self parse: factory headerLevel1Sample andCheckWeGet: newLine , '\part{Foo}'
	
]

{ #category : 'tests - header' }
MicAbstractLaTexWriterTest >> testHeaderLevel2 [

	self parse: factory headerLevel2Sample andCheckWeGet: newLine  , '\chapter{Foo}'
]

{ #category : 'tests - header' }
MicAbstractLaTexWriterTest >> testHeaderLevel3 [

	self parse: factory headerLevel3Sample andCheckWeGet: newLine , '\section{Foo}'
]

{ #category : 'tests - header' }
MicAbstractLaTexWriterTest >> testHeaderLevel4 [

	self parse: factory headerLevel4Sample andCheckWeGet: newLine , '\subsection{Foo}'
]

{ #category : 'tests - header' }
MicAbstractLaTexWriterTest >> testHeaderLevel5 [

	self parse: factory headerLevel5Sample andCheckWeGet: newLine , '\subsubsection{Foo}'
]

{ #category : 'tests - header' }
MicAbstractLaTexWriterTest >> testHeaderLevel6 [
	
   self parse: factory headerLevel6Sample andCheckWeGet: newLine , '\paragraph{Foo}'
]

{ #category : 'tests' }
MicAbstractLaTexWriterTest >> testHorizontalLine [

	self parseInlined: factory horizontalLineSample andCheckWeGet: '\rule{\textwidth}{0.1pt}'
]

{ #category : 'tests - formats' }
MicAbstractLaTexWriterTest >> testItalic [

	self parseInlined: factory italicFormatSample andCheckWeGet: '\textit{Foo}'
]

{ #category : 'tests - breaklining' }
MicAbstractLaTexWriterTest >> testLfAsNewLine [ 

	writer lfAsNewLine.
	self assert: writer canvas stream configuration newLine equals: Character lf
]

{ #category : 'tests - figure/link' }
MicAbstractLaTexWriterTest >> testLink [
	self writeFor: factory linkSample.		
	self assert: writer contents equals: newLine,
'\href{/anUrl}{Foo}', newLine
]

{ #category : 'tests - figure/link' }
MicAbstractLaTexWriterTest >> testLinkBold [

	self writeFor: factory linkBoldSample.
	self assert: writer contents equals: newLine ,
		'\href{/anUrl}{\textbf{Foo}}', newLine
]

{ #category : 'tests - math' }
MicAbstractLaTexWriterTest >> testMathBloc [

	self
	parseInlined:'$$
f(a) = \frac{1}{2\pi i} \oint_{\gamma} \frac{f(z)}{z - a} dz
$$'

	andCheckWeGet: 

'\begin{equation}', newLine,
'f(a) = \frac{1}{2\pi i} \oint_{\gamma} \frac{f(z)}{z - a} dz', newLine,
'\end{equation}' 
]

{ #category : 'tests - math' }
MicAbstractLaTexWriterTest >> testMathBlocWithLabel [

	self
	parseInlined:'$$ % anchor=eq1
f(a) = \frac{1}{2\pi i} \oint_{\gamma} \frac{f(z)}{z - a} dz
$$'

	andCheckWeGet: 

'\begin{equation}', newLine,
'\label{eq1}', newLine,
'f(a) = \frac{1}{2\pi i} \oint_{\gamma} \frac{f(z)}{z - a} dz', newLine,
'\end{equation}' 
]

{ #category : 'tests - math' }
MicAbstractLaTexWriterTest >> testMathInLine [

	self
	parseInlined: 'Similarly, let $f_{w,C}$ be the number of documents in corpus $C$ that contain word $w$:'


	andCheckWeGet: 

'Similarly, let $f_{w,C}$ be the number of documents in corpus $C$ that contain word $w$:'
]

{ #category : 'tests - formats' }
MicAbstractLaTexWriterTest >> testMonospace [

	self parseInlined: factory monospaceFormatSample andCheckWeGet: '\code{Foo}'
]

{ #category : 'tests - lists' }
MicAbstractLaTexWriterTest >> testOrderedList [
	
	self writeFor: factory orderedListWithTwoItemsSample.
	self assert: writer contents equals: newLine,
						'\begin{enumerate}', newLine ,
						'    \item first', newLine ,
						'    \item second', newLine ,
						'\end{enumerate}', newLine
]

{ #category : 'tests - lists' }
MicAbstractLaTexWriterTest >> testOrderedListBold [

	self writeFor: factory orderedListWithTwoItemsBoldSample.
	self assert: writer contents equals: newLine ,
						'\begin{enumerate}', newLine ,
						'    \item \textbf{first}', newLine ,
						'    \item second', newLine ,
						'\end{enumerate}', newLine
]

{ #category : 'tests - lists' }
MicAbstractLaTexWriterTest >> testOrderedListNested [

	self writeFor:  factory orderedListWithTwoItemsBoldFirstSample.
	self assert: writer contents equals: newLine, 
						'\begin{enumerate}', newLine ,
						'    \item \textbf{\textit{first}}', newLine ,
						'    \item second', newLine ,
						'\end{enumerate}', newLine
]

{ #category : 'tests - lists' }
MicAbstractLaTexWriterTest >> testOrderedNestedListNested [

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

{ #category : 'tests - lists' }
MicAbstractLaTexWriterTest >> testOrderedNestedListNested2 [

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

{ #category : 'tests - paragraph' }
MicAbstractLaTexWriterTest >> testParagraph [
	
	self parse: factory paragraphSample andCheckWeGet: newLine,
															'Foo',newLine

]

{ #category : 'tests - paragraph' }
MicAbstractLaTexWriterTest >> testParagraphLongWithAccents [

		self parse: factory paragraphOnMultipleLinesSample andCheckWeGet:  newLine,
'Je ne connais pas la peur, car la peur tue l''esprit. La peur est la petite mort qui conduit \`{a} l''oblit\''{e}ration totale. J''affonterai ma peur. Je lui permettrais de passer sur moi, au travers de moi. Et lorsqu''elle sera pass\''{e}e, je tournerai mon oeil interieur sur son chemin. Et l\`{a} o\`{u} elle sera pass\''{e}e, il n''y aura plus rien, rien que moi.', newLine
]

{ #category : 'tests - paragraph' }
MicAbstractLaTexWriterTest >> testParagraphWithBold [

	self parse: factory paragraphBoldSample andCheckWeGet:  newLine ,
									'this is a \textbf{paragraph}', newLine
]

{ #category : 'tests - paragraph' }
MicAbstractLaTexWriterTest >> testParagraphWithItalic [

	self parse: factory paragraphItalicSample andCheckWeGet:  newLine ,
									'this is a \textit{paragraph}', newLine
]

{ #category : 'tests - paragraph' }
MicAbstractLaTexWriterTest >> testParagraphWithMonospace [
	
	self parse: factory paragraphMonospaceSample andCheckWeGet:  newLine ,
'this is a \code{paragraph}', newLine 

]

{ #category : 'tests - paragraph' }
MicAbstractLaTexWriterTest >> testParagraphWithNested [

	self parse: factory paragraphNestedSample andCheckWeGet:  newLine ,
'this is a \textbf{\textit{paragraph}}', newLine
]

{ #category : 'tests' }
MicAbstractLaTexWriterTest >> testQuote [

	self parse: factory quoteSample andCheckWeGet:  '\begin{verbatim}', newLine ,
																	'Foo', newLine ,
																	'\end{verbatim}', newLine
]

{ #category : 'tests - figure/link' }
MicAbstractLaTexWriterTest >> testRealLinkSample [
	self writeFor: factory realLinkSample.	
	self assert: writer contents equals: newLine ,
'\href{http://www.pharo.org}{The Pharo Project}', newLine 
]

{ #category : 'tests - math' }
MicAbstractLaTexWriterTest >> testSimpleMathBloc [
	
	| root math |
	root := parser parse: '
$$
f(a) = \frac{1}{2\pi i} \oint_{\gamma} \frac{f(z)}{z - a} dz
$$'.
	math := root children first.
	self
	parseInlined:'$$ 
f(a) = \frac{1}{2\pi i} \oint_{\gamma} \frac{f(z)}{z - a} dz
$$'

	andCheckWeGet: 

'\begin{equation}', newLine, 
'f(a) = \frac{1}{2\pi i} \oint_{\gamma} \frac{f(z)}{z - a} dz', newLine,
'\end{equation}' 
]

{ #category : 'tests - formats' }
MicAbstractLaTexWriterTest >> testStrike [

	self parseInlined: factory strikethroughFormatSample andCheckWeGet: '\sout{Foo}'
		
]

{ #category : 'tests' }
MicAbstractLaTexWriterTest >> testTable [
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

{ #category : 'tests' }
MicAbstractLaTexWriterTest >> testTableWhithoutHeader [
	
	self writeFor: (factory simpleTableWithoutHeaderTable).
	self assert: writer contents equals: newLine,
													'\begin{tabular}{ll}', newLine ,
													'\toprule', newLine ,
													'aaab & jkhjh \\', newLine ,
													'bar & rab \\', newLine ,
													'\bottomrule', newLine ,
													'\end{tabular}', newLine
]

{ #category : 'tests - lists' }
MicAbstractLaTexWriterTest >> testUnorderedList [

	self writeFor: factory unorderedListWithTwoItemsSample.
	self assert: writer contents equals: newLine, 
							'\begin{itemize}', newLine ,
							'    \item Foo', newLine ,
							'    \item Bar', newLine ,
							'\end{itemize}', newLine
]

{ #category : 'tests - lists' }
MicAbstractLaTexWriterTest >> testUnorderedListBold [

	self writeFor: factory unorderedListWithTwoItemsBoldSample.
	self assert: writer contents equals: newLine ,
							'\begin{itemize}', newLine ,
							'    \item \textbf{Foo}', newLine ,
							'    \item Bar', newLine ,
							'\end{itemize}', newLine
]

{ #category : 'tests - lists' }
MicAbstractLaTexWriterTest >> testUnorderedListNested [

	self writeFor: factory unorderedListWithTwoItemsNestedSample.
	self assert: writer contents equals: newLine ,
							'\begin{itemize}', newLine ,
							'    \item \sout{\textit{Foo}}', newLine ,
							'    \item Bar', newLine ,
							'\end{itemize}', newLine
]

{ #category : 'tests - lists' }
MicAbstractLaTexWriterTest >> testUnorderedNestedListNested [

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

{ #category : 'tests' }
MicAbstractLaTexWriterTest >> testUrlsAreProtected [

	self assert: (writer protectUrl: '#') equals: '\#'.
	self assert: (writer protectUrl: '~') equals: '~'.
	self assert: (writer protectUrl: '&') equals: '&'.
	self assert: (writer protectUrl: '%') equals: '\%'.
	self assert: (writer protectUrl: '\') equals: '\\'.
	self assert: (writer protectUrl: '\~#%') equals: '\\~\#\%'.
]

{ #category : 'tests - breaklining' }
MicAbstractLaTexWriterTest >> testWriteAParagraphWithCr [
	writer crAsNewLine.
	writer canvas nextPutAllLines: 'Je ne vois pas pourquoi
cela ne fonctionnerais pas
car il a etait fait pour cela'.
	self assert: writer canvas stream contents equals: 'Je ne vois pas pourquoi', String cr ,
'cela ne fonctionnerais pas', String cr,
'car il a etait fait pour cela'
]

{ #category : 'tests - breaklining' }
MicAbstractLaTexWriterTest >> testWriteAParagraphWithCrButNewLineIsCrlf [
	writer crlfAsNewLine.
	writer canvas nextPutAllLines: 'Je ne vois pas pourquoi
cela ne fonctionnerais pas
car il a etait fait pour cela'.
	self deny: writer canvas stream contents equals: 'Je ne vois pas pourquoi', String cr ,
'cela ne fonctionnerais pas', String cr,
'car il a etait fait pour cela'
]

{ #category : 'tests - breaklining' }
MicAbstractLaTexWriterTest >> testWriteAParagraphWithCrButNewLineIsLf [
	writer lfAsNewLine.
	writer canvas nextPutAllLines: 'Je ne vois pas pourquoi
cela ne fonctionnerais pas
car il a etait fait pour cela'.
	self deny: writer canvas stream contents equals: 'Je ne vois pas pourquoi', String cr ,
'cela ne fonctionnerais pas', String cr,
'car il a etait fait pour cela'
]

{ #category : 'tests - breaklining' }
MicAbstractLaTexWriterTest >> testWriteAParagraphWithCrlf [
	writer crlfAsNewLine .
	writer canvas nextPutAllLines: 'Je ne vois pas pourquoi
cela ne fonctionnerais pas
car il a etait fait pour cela'.
	self assert: writer canvas stream contents equals: 'Je ne vois pas pourquoi', String crlf ,
'cela ne fonctionnerais pas', String crlf,
'car il a etait fait pour cela'
]

{ #category : 'tests - breaklining' }
MicAbstractLaTexWriterTest >> testWriteAParagraphWithCrlfButNewLineIsCr [
	writer crAsNewLine.
	writer canvas nextPutAllLines: 'Je ne vois pas pourquoi
cela ne fonctionnerais pas
car il a etait fait pour cela'.
	self deny: writer canvas stream contents equals: 'Je ne vois pas pourquoi', String crlf ,
'cela ne fonctionnerais pas', String crlf,
'car il a etait fait pour cela'
]

{ #category : 'tests - breaklining' }
MicAbstractLaTexWriterTest >> testWriteAParagraphWithCrlfButNewLineIsLf [
	writer lfAsNewLine.
	writer canvas nextPutAllLines: 'Je ne vois pas pourquoi
cela ne fonctionnerais pas
car il a etait fait pour cela'.
	self deny: writer canvas stream contents equals: 'Je ne vois pas pourquoi', String crlf ,
'cela ne fonctionnerais pas', String crlf,
'car il a etait fait pour cela'
]

{ #category : 'tests - breaklining' }
MicAbstractLaTexWriterTest >> testWriteAParagraphWithLf [
	writer lfAsNewLine.
	writer canvas nextPutAllLines: 'Je ne vois pas pourquoi
cela ne fonctionnerais pas
car il a etait fait pour cela'.
	self assert: writer canvas stream contents equals: 'Je ne vois pas pourquoi', String lf ,
'cela ne fonctionnerais pas', String lf,
'car il a etait fait pour cela'
]

{ #category : 'tests - breaklining' }
MicAbstractLaTexWriterTest >> testWriteAParagraphWithLfButNewLineIsCr [
	writer crAsNewLine.
	writer canvas nextPutAllLines: 'Je ne vois pas pourquoi
cela ne fonctionnerais pas
car il a etait fait pour cela'.
	self deny: writer canvas stream contents equals: 'Je ne vois pas pourquoi', String lf ,
'cela ne fonctionnerais pas', String lf,
'car il a etait fait pour cela'
]

{ #category : 'tests - breaklining' }
MicAbstractLaTexWriterTest >> testWriteAParagraphWithLfButNewLineIsCrlf [
	writer crlfAsNewLine.
	writer canvas nextPutAllLines: 'Je ne vois pas pourquoi
cela ne fonctionnerais pas
car il a etait fait pour cela'.
	self deny: writer canvas stream contents equals: 'Je ne vois pas pourquoi', String lf ,
'cela ne fonctionnerais pas', String lf,
'car il a etait fait pour cela'
]

{ #category : 'tests' }
MicAbstractLaTexWriterTest >> writeFor: aString [ 
	| mic |
	mic := parser parse: aString.
	writer visit: mic.

]

{ #category : 'tests' }
MicAbstractLaTexWriterTest >> writeForElement: aNode [

	writer visit: aNode.

]

{ #category : 'accessing' }
MicAbstractLaTexWriterTest >> writer: aWriter [
	writer := aWriter new
]
