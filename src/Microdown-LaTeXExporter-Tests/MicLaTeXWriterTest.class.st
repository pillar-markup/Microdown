Class {
	#name : 'MicLaTeXWriterTest',
	#superclass : 'MicAbstractLaTexWriterTest',
	#category : 'Microdown-LaTeXExporter-Tests',
	#package : 'Microdown-LaTeXExporter-Tests'
}

{ #category : 'as yet unclassified' }
MicLaTeXWriterTest >> testCodeblock [

	self writeFor: (factory codeblockNoParamBody: 'this is a code').
	self assert: writer contents equals: '\begin{listing}', newLine ,
													'this is a code', newLine ,
													'\end{listing}', newLine
]

{ #category : 'as yet unclassified' }
MicLaTeXWriterTest >> testCodeblockWithCaption [

	self writeFor: (factory codeblock: 'caption=Pharo is **cool**' body: 'this is a code').
	self assert: writer contents equals: '\begin{listing}[caption={Pharo is \textbf{cool}}]', newLine,
													'this is a code', newLine,
													'\end{listing}', newLine
]

{ #category : 'as yet unclassified' }
MicLaTeXWriterTest >> testCodeblockWithLabel [

	self writeFor: (factory codeblock: 'label=Pharo' body: 'this is a code').
	self assert: writer contents equals: '\begin{listing}[label=Pharo]', newLine ,
													'this is a code', newLine ,
													'\end{listing}', newLine 
]
