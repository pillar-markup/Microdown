Class {
	#name : #MicSBALaTeXWriterTest,
	#superclass : #MicLaTeXWriterTest,
	#category : #'Microdown-LaTeXExporter-Tests'
}

{ #category : #tests }
MicSBALaTeXWriterTest class >> testParameters [

	^ ParametrizedTestMatrix new
		  forSelector: #writer addOptions: { MicSBALaTeXWriter };
		  forSelector: #factory addOptions: { MicMicrodownSnippetFactory };
		  forSelector: #parser addOptions: { Microdown };
		  forSelector: #newLine addOptions: { String cr . String lf };
		  yourself
]

{ #category : #private }
MicSBALaTeXWriterTest >> actualClass [
	^ MicSBALaTeXWriter
]

{ #category : #tests }
MicSBALaTeXWriterTest >> testCodeblock [

	self writeFor: (factory codeblockNoParamBody: 'this is a code').
	self assert: writer contents equals: '\begin{displaycode}{smalltalk}', newLine,
													'this is a code', newLine ,
													'\end{displaycode}', newLine
]

{ #category : #tests }
MicSBALaTeXWriterTest >> testCodeblockWithCaption [

	self writeFor: (factory codeblock: 'caption=Pharo is **cool**' body: 'this is a code').
	self assert: writer contents equals: '\begin{listing}[float]{smalltalk}{Pharo is \textbf{cool}}', newLine ,
'this is a code', newLine ,
'\end{listing}', newLine
]

{ #category : #tests }
MicSBALaTeXWriterTest >> testCodeblockWithChevron [

	self writeFor:
		(factory
			 codeblock: 'caption=Pharo is **cool**'
			 body: 'MyClass >> foo
 this is a code').
	self
		assert: writer contents
		equals:
			'\begin{listing}[float]{smalltalk}{Pharo is \textbf{cool}}'
			, newLine , 'MyClass >> foo' , newLine , ' this is a code'
			, newLine , '\end{listing}' , newLine
]

{ #category : #tests }
MicSBALaTeXWriterTest >> testCodeblockWithLabel [

	self writeFor: (factory codeblock: 'label=Pharo' body: 'this is a code').
	self assert: writer contents equals: '\begin{listing}[float, label=Pharo]{smalltalk}{}', newLine ,
													'this is a code', newLine ,
													'\end{listing}', newLine
]

{ #category : #tests }
MicSBALaTeXWriterTest >> testFloatingWithBothLabelAndCaption [
	| codeBlock |
	codeBlock := (MicCodeBlock new body: 'foo')
					label: 'myScript';
					caption: 'a caption';
					yourself.
	self assertWriting: codeBlock includesTexts: #('label=myScript')
]

{ #category : #tests }
MicSBALaTeXWriterTest >> testInFlowOnTwoLines [
	| codeBlock |
	codeBlock := MicCodeBlock new body: 'foo', newLine , 'bar on another line'.
	self writeForElement: codeBlock.	
	self assert: writer contents equals: '\begin{displaycode}{smalltalk}', newLine ,
'foo', newLine ,
'bar on another line', newLine ,
'\end{displaycode}', newLine
]

{ #category : #tests }
MicSBALaTeXWriterTest >> testMonospace [

	self parseInlined: factory monospaceFormatSample andCheckWeGet: '\textcode{Foo}'
]

{ #category : #tests }
MicSBALaTeXWriterTest >> testParagraphWithChevron [

	self writeFor: (factory textWithChevron).
	self assert: writer contents equals: newLine ,
'Pilou \textgreater{}\textgreater{} bla', newLine
]

{ #category : #tests }
MicSBALaTeXWriterTest >> testParagraphWithMonospace [
	
	self parse: factory paragraphMonospaceSample andCheckWeGet: newLine,
'this is a \textcode{paragraph}', newLine
]

{ #category : #tests }
MicSBALaTeXWriterTest >> testSimpleFloating [
	| codeBlock |
	codeBlock := (MicCodeBlock new body: 'foo')
		caption: 'A caption.';
		yourself.
	self writeForElement: codeBlock.
	self assert: writer contents equals: '\begin{listing}[float]{smalltalk}{A caption.}', newLine ,
'foo', newLine ,
'\end{listing}', newLine
]

{ #category : #tests }
MicSBALaTeXWriterTest >> testSimpleFloatingNoLanguage [
	| codeBlock |
	codeBlock := (MicCodeBlock new body: 'foo')
		caption: 'A caption.';
		yourself.
	self writeForElement: codeBlock.
	self flag: #languageSupport. "smalltalk -> plain"
	self assertWriting: codeBlock includesText: '{smalltalk}'
]

{ #category : #tests }
MicSBALaTeXWriterTest >> testTable [
	self writeFor: factory tableSample.
	self assert: writer contents equals: '\begin{fullwidthtabular}{ll}', newLine ,
'\toprule', newLine ,
'\textbf{aaab} & \textbf{jkhjh} \\', newLine ,
'\midrule', newLine ,
'bar & rab \\', newLine ,
'\bottomrule', newLine ,
'\end{fullwidthtabular}', newLine
]

{ #category : #tests }
MicSBALaTeXWriterTest >> testTableWhithoutHeader [
	
	self writeFor: (factory simpleTableWithoutHeaderTable).
	self assert: writer contents equals: '\begin{fullwidthtabular}{ll}', newLine ,
'\toprule', newLine ,
'aaab & jkhjh \\', newLine ,
'bar & rab \\', newLine ,
'\bottomrule', newLine ,
'\end{fullwidthtabular}', newLine
]
