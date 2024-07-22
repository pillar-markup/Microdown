Class {
	#name : 'MicBeamerWriter2Test',
	#superclass : 'MicLaTeXWriterTest',
	#category : 'Microdown-BeamerExporter-Tests',
	#package : 'Microdown-BeamerExporter-Tests'
}

{ #category : 'tests - full' }
MicBeamerWriter2Test >> doc [

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
MicBeamerWriter2Test >> docWithRealMetaData [

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

{ #category : 'tests - full' }
MicBeamerWriter2Test >> testOneSlideInExtensionProducesNiceBeamer [

	| beamer |
	"this is not realy good since the meta data are ignored so far. 
	But let us see if we can get pillar produces any first version."
	beamer := MicBeamerWriter new.
	beamer crlfAsNewLine.
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
MicBeamerWriter2Test >> testOneSlideInExtensionSyntaxParseWell [


	| doc | 
	doc := self doc.
	self assert: doc children first class equals: MicMetaDataBlock.
	self assert: doc children second class equals: MicSlideBlock.
	self assert: doc children second children second class equals: MicUnorderedListBlock 
	
	


]

{ #category : 'tests - full' }
MicBeamerWriter2Test >> testParserSetTheDocumentProperties [

	| doc |
	doc := self docWithRealMetaData.
	self assert: doc hasProperties. 
	
]
