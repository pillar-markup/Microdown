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
MicBeamerWriterTest >> testOneSlideInExtensionSyntaxParseWell [


	| doc | 
	doc := Microdown parse: 
'{
	"title":"Pharo Features (part)"
}

<!slide|title=This is a cool title&tag=nh5p

Pharo benefits from an elegant design that enables a relatively simple implementation of many advanced programming techniques. 


- a list of bullet
- bullet 2
- bullet 3
!>'.
	self assert: doc children first class equals: MicMetaDataBlock.
	self assert: doc children second class equals: MicSlideBlock.
	self assert: doc children second children second class equals: MicUnorderedListBlock 
	
	


]
