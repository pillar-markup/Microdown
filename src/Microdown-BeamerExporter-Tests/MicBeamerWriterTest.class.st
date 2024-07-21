Class {
	#name : 'MicBeamerWriterTest',
	#superclass : 'MicLaTeXWriterTest',
	#category : 'Microdown-BeamerExporter-Tests',
	#package : 'Microdown-BeamerExporter-Tests'
}

{ #category : 'tests' }
MicBeamerWriterTest class >> testParameters [

	^ ParametrizedTestMatrix new
		  forSelector: #writer addOptions: { MicBeamerWriter };
		  forSelector: #factory addOptions: { MicMicrodownSnippetFactory };
		  forSelector: #parser addOptions: { Microdown };
		  forSelector: #newLine addOptions: { String cr . String lf };
		  yourself
]

{ #category : 'running' }
MicBeamerWriterTest >> actualClass [ 
	^ MicBeamerWriter 
]

{ #category : 'tests - full' }
MicBeamerWriterTest >> doc [

	^ Microdown parse: 
'{
	"title":"Pharo Features (part)"
}

<!slide|title=This is a cool title&tag=nh5p

Pharo benefits from an elegant design that enables a relatively simple implementation of many advanced programming techniques. 


- a list of bullet
- bullet 2
- bullet 3
!>'

]

{ #category : 'tests - full' }
MicBeamerWriterTest >> docWithRealMetaData [

	^ Microdown parse: 
'{
	"title":"Parametrized Tests",
	"subtitle":"Getting more tests out of test cases",
	"slidesid":"M2-5"
}

<!slide|title=This is a cool title&tag=nh5p

Pharo benefits from an elegant design that enables a relatively simple implementation of many advanced programming techniques. 


- a list of bullet
- bullet 2
- bullet 3
!>'

]

{ #category : 'tests' }
MicBeamerWriterTest >> testCode [

	self writeFor: (factory codeblockNoParamBody: 'this is a code').
	self assert: writer contents equals: '\begin{listing}', newLine ,
													'this is a code', newLine ,
													'\end{listing}', newLine
]

{ #category : 'tests' }
MicBeamerWriterTest >> testCodeWithCaption [

	self writeFor: (factory codeblock: 'caption=Pharo is **cool**' body: 'this is a code').
	self assert: writer contents equals: '\begin{listing}[caption={Pharo is \textbf{cool}}]', newLine ,
													'this is a code', newLine ,
													'\end{listing}', newLine
]

{ #category : 'tests' }
MicBeamerWriterTest >> testCodeWithLabel [

	self writeFor: (factory codeblock: 'label=Pharo' body: 'this is a code').
	self assert: writer contents equals: '\begin{listing}[label=Pharo]', newLine ,
'this is a code', newLine ,
'\end{listing}', newLine
]

{ #category : 'tests' }
MicBeamerWriterTest >> testColumn [

	self writeFor: factory columnSample.
	self assert: writer contents equals:'\begin{column}{0.42\textwidth}', newLine , newLine, 
'this is a \textbf{text}', newLine ,
'\end{column}', newLine, newLine
]

{ #category : 'tests' }
MicBeamerWriterTest >> testColumns [

	self writeFor: factory columnsSample.
	self assert: writer contents equals:'\begin{columns}', newLine ,
'\end{columns}', newLine , newLine
]

{ #category : 'tests' }
MicBeamerWriterTest >> testColumnsWithChildren [

	self writeFor: factory columnsWithChildrenSample.
	self assert: writer contents equals:'\begin{columns}', newLine ,
'\begin{column}{0.42\textwidth}', newLine , newLine ,
'this is a \textbf{text}', newLine ,
'\end{column}', newLine , newLine ,
'\begin{column}{0.42\textwidth}', newLine, newLine,
'this is a \textbf{text}', newLine ,
'\end{column}', newLine , newLine ,
'\end{columns}', newLine , newLine
]

{ #category : 'tests - figure/link' }
MicBeamerWriterTest >> testFigure [

	self writeFor: factory figureSample.
	self assert: writer contents equals: newLine,
'\begin{center}', newLine ,
'\includegraphics[width=0.8\textwidth]{/anUrl}\end{center}', newLine, newLine
]

{ #category : 'tests - figure/link' }
MicBeamerWriterTest >> testFigureBold [
	"in beamer we do not display caption so bld and the rest goes away."
	self writeFor: factory figureBoldSample.
	self assert: writer contents equals: newLine ,
'\begin{center}', newLine ,
'\includegraphics[width=0.8\textwidth]{/anUrl}\end{center}', newLine , newLine
]

{ #category : 'tests - figure/link' }
MicBeamerWriterTest >> testFigureRealSample [

	self writeFor: factory figureRealSample.
	self assert: writer contents equals: newLine ,
'\begin{center}', newLine ,
'\includegraphics[width=0.8\textwidth]{figures/logo.png}\end{center}', newLine , newLine
]

{ #category : 'tests' }
MicBeamerWriterTest >> testFrameWithoutOption [

	self
		parse: '<!slide|title=Slide title', newLine ,
						'Presentation text', newLine
		andCheckWeGet: newLine ,
'\begin{frame}[fragile]', newLine ,
newLine ,
'\frametitle{Slide title}', newLine ,
newLine ,
'Presentation text', newLine ,
'\end{frame}', newLine, newLine
]

{ #category : 'tests - full' }
MicBeamerWriterTest >> testOneSlideInExtensionProducesNiceBeamer [

	| beamer |
	"this is not realy good since the meta data are ignored so far. 
	But let us see if we can get pillar produces any first version."
	beamer := MicBeamerWriter new.
	beamer visit: self doc.
	self 
		assert: beamer contents  
		equals:
'
\begin{frame}[fragile]

\frametitle{This is a cool title}

Pharo benefits from an elegant design that enables a relatively simple implementation of many advanced programming techniques.

\begin{itemize}
    \item a list of bullet
    \item bullet 2
    \item bullet 3
\end{itemize}
\end{frame}

'

]

{ #category : 'tests - full' }
MicBeamerWriterTest >> testOneSlideInExtensionSyntaxParseWell [


	| doc | 
	doc := self doc.
	self assert: doc children first class equals: MicMetaDataBlock.
	self assert: doc children second class equals: MicSlideBlock.
	self assert: doc children second children second class equals: MicUnorderedListBlock 
	
	


]

{ #category : 'tests - full' }
MicBeamerWriterTest >> testParserSetTheDocumentProperties [

	| doc |
	doc := self docWithRealMetaData.
	self assert: doc hasProperties. 
	
]
