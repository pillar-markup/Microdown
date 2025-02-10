Class {
	#name : 'MicLaTeXWriterTest',
	#superclass : 'MicAbstractLaTexWriterTest',
	#category : 'Microdown-LaTeXExporter-Tests',
	#package : 'Microdown-LaTeXExporter-Tests'
}

{ #category : 'asserting' }
MicLaTeXWriterTest class >> isAbstract [ 

	^ false
]

{ #category : 'asserting' }
MicLaTeXWriterTest class >> shouldInheritSelectors [

	^ true
]

{ #category : 'tests' }
MicLaTeXWriterTest >> testCodeblock [

	self writeFor: (factory codeblockNoParamBody: 'this is a code').
	self assert: writer contents equals: '\begin{listing}', newLine ,
													'this is a code', newLine ,
													'\end{listing}', newLine
]

{ #category : 'tests' }
MicLaTeXWriterTest >> testCodeblockWithCaption [

	self writeFor: (factory codeblock: 'caption=Pharo is **cool**' body: 'this is a code').
	self assert: writer contents equals: '\begin{listing}[caption={Pharo is \textbf{cool}}]', newLine,
													'this is a code', newLine,
													'\end{listing}', newLine
]

{ #category : 'tests' }
MicLaTeXWriterTest >> testCodeblockWithLabel [

	self writeFor: (factory codeblock: 'label=Pharo' body: 'this is a code').
	self assert: writer contents equals: '\begin{listing}[label=Pharo]', newLine ,
													'this is a code', newLine ,
													'\end{listing}', newLine 
]

{ #category : 'tests - figure/link' }
MicLaTeXWriterTest >> testFigureWithEmptyCaption [

	self writeFor: '![](figures/f.png)'.
	self
		assert: writer contents   
		equals:
			newLine, '\begin{figure}[htpb]', newLine , '\begin{center}', newLine, '\includegraphics[width=1.0\textwidth]{figures/f.png}', newLine, '\caption{}', newLine, 
			 '\end{center}', newLine, '\end{figure}', newLine,  newLine  
			
]

{ #category : 'tests' }
MicLaTeXWriterTest >> testNote [

	self parseInlined: '{!note|contents=Duca99a!}' andCheckWeGet: '\comment{Duca99a}'
	
]

{ #category : 'accessing' }
MicLaTeXWriterTest >> writer: aWriterClass [

	writer := aWriterClass new.
]
