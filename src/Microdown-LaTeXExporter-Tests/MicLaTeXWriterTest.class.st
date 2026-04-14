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
MicLaTeXWriterTest >> testBold [
	| document result |

	document := Microdown parse: 'Texte **gras**'.
	
	writer visit: document.
	result := writer contents.
	
	self assert: result trimBoth equals: 'Texte \textbf{gras}'.
]

{ #category : 'tests' }
MicLaTeXWriterTest >> testCodeBlock [
	| document result expected microdownText tab |
	
	tab := Character tab asString.
	
	microdownText := '```', newLine,
	tab, 'x := 1.', newLine,
	tab, 'y := 2.', newLine,
	'```'.
	
	document := Microdown parse: microdownText.
	writer visit: document.
	result := writer contents. 
	
	expected := '\begin{listing}', newLine,
	'x := 1.', newLine,
	'y := 2.', newLine,
	'\end{listing}'.
	
	self assert: result trimBoth equals: expected trimBoth.
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

{ #category : 'tests' }
MicLaTeXWriterTest >> testEscapeSpecialCharacters [ 
	| document result |
	document := Microdown parse: 'Texte avec % # $ & '.
	
	writer visit: document.
	result := writer contents.
	
	self assert: result trimBoth equals: 'Texte avec \% \# \$ \&'.
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
MicLaTeXWriterTest >> testHeaderLevel1 [ 
	| document result |

	document := Microdown parse: '# Titre'.
	
	writer visit: document.
	result := writer contents.
	
	self assert: result trimBoth equals: '\part{Titre}'.
]

{ #category : 'tests' }
MicLaTeXWriterTest >> testHeaderLevel2 [ 
	| document result |
	document := Microdown parse: '## Titre'.
	
	writer visit: document.
	result := writer contents.
	
	self assert: result trimBoth equals: '\chapter{Titre}'.
]

{ #category : 'tests' }
MicLaTeXWriterTest >> testItalic [ 
	| document result |
	document := Microdown parse: 'Texte *italic*'.
	
	writer visit: document.
	result := writer contents.
	
	self assert: result trimBoth equals: 'Texte \textit{italic}'.
]

{ #category : 'tests' }
MicLaTeXWriterTest >> testMonospace [ 
	| document result |
	document := Microdown parse: 'Texte `monospace` inline '.
	
	writer visit: document.
	result := writer contents.
	
	self assert: result trimBoth equals: 'Texte \code{monospace} inline'.
]

{ #category : 'tests' }
MicLaTeXWriterTest >> testNote [

	self parseInlined: '{!note|contents=Duca99a!}' andCheckWeGet: '\comment{Duca99a}'
	
]

{ #category : 'tests' }
MicLaTeXWriterTest >> testOrderedList [
	| document result expected |
	
	document := Microdown parse: '1. Premier
2. Second'.
	
	writer visit: document.
	result := writer contents. 
	
	expected := newLine, '\begin{enumerate}', newLine,
'    \item Premier', newLine,
'    \item Second', newLine,
'\end{enumerate}'.
	
	self assert: result trimBoth equals: expected trimBoth.
]

{ #category : 'tests' }
MicLaTeXWriterTest >> testUnorderedList [
	| document result expected |
	
	document := Microdown parse: '- Premier
- Second'.
	
	writer visit: document.
	result := writer contents. 
	
	expected := '\begin{itemize}', newLine,
'    \item Premier', newLine,
'    \item Second', newLine,
'\end{itemize}'.
	
	self assert: result trimBoth equals: expected trimBoth.
]
