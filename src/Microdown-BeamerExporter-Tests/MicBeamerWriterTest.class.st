Class {
	#name : #MicBeamerWriterTest,
	#superclass : #MicLaTeXWriterTest,
	#category : #'Microdown-BeamerExporter-Tests'
}

{ #category : #accessing }
MicBeamerWriterTest >> actualClass [ 
	^ MicBeamerWriter 
]

{ #category : #accessing }
MicBeamerWriterTest >> testCode [

	self writeFor: (factory codeblockNoParamBody: 'this is a code').
	self assert: writer contents equals: '
\begin{listing}
this is a code
\end{listing}
'
]

{ #category : #accessing }
MicBeamerWriterTest >> testCodeWithCaption [

	self writeFor: (factory codeblock: 'caption=Pharo is **cool**' body: 'this is a code').
	self assert: writer contents equals: '
\begin{listing}[caption={Pharo is \textbf{cool}}]
this is a code
\end{listing}
'
]

{ #category : #accessing }
MicBeamerWriterTest >> testCodeWithLabel [

	self writeFor: (factory codeblock: 'label=Pharo' body: 'this is a code').
	self assert: writer contents equals: '
\begin{listing}[label=Pharo]
this is a code
\end{listing}
'
]

{ #category : #accessing }
MicBeamerWriterTest >> testColumn [

	self writeFor: (factory columnSample).
	self assert: writer contents equals:'
\begin{column}{0.42\textwidth}

this is a \textbf{text}
\end{column}

'
]

{ #category : #accessing }
MicBeamerWriterTest >> testColumns [

	self writeFor: (factory columnsSample).
	self assert: writer contents equals:'
\begin{columns}
\end{columns}

'
]

{ #category : #accessing }
MicBeamerWriterTest >> testColumnsWithChildren [

	self writeFor: factory columnsWithChildrenSample.
	self assert: writer contents equals:'
\begin{columns}

\begin{column}{0.42\textwidth}

this is a \textbf{text}
\end{column}


\begin{column}{0.42\textwidth}

this is a \textbf{text}
\end{column}

\end{columns}

'
]

{ #category : #accessing }
MicBeamerWriterTest >> testFigure [

	self writeFor: factory figureSample.
	self assert: writer contents equals: '

\begin{center}
\includegraphics[width=0.8\textwidth]{/anUrl}\end{center}

'
]

{ #category : #accessing }
MicBeamerWriterTest >> testFigureBold [
	"in beamer we do not display caption so bld and the rest goes away."
	self writeFor: factory figureBoldSample.
	self assert: writer contents equals:'

\begin{center}
\includegraphics[width=0.8\textwidth]{/anUrl}\end{center}

'
]

{ #category : #accessing }
MicBeamerWriterTest >> testFigureRealSample [

	self writeFor: factory figureRealSample.
	self assert: writer contents equals: '

\begin{center}
\includegraphics[width=0.8\textwidth]{figures/logo.png}\end{center}

'
]

{ #category : #accessing }
MicBeamerWriterTest >> testFrameWithoutOption [

	self
		parse: '<!slide|title=Slide title
						Presentation text
						'
		andCheckWeGet: '

\begin{frame}[fragile]

\frametitle{Slide title}

Presentation text
\end{frame}

'
]
