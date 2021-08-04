Class {
	#name : #MicLaTeXWriter,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'canvas',
		'stream',
		'nbListTab'
	],
	#category : #'Microdown-LaTeXExporter'
}

{ #category : #accessing }
MicLaTeXWriter class >> fileExtension [
	^ 'tex'
]

{ #category : #accessing }
MicLaTeXWriter class >> folderName [
	^ #latex
]

{ #category : #accessing }
MicLaTeXWriter class >> toLatexPath: aString [
	"Replace all (windows style) back slashes in paths by (unix style) forward slashes.
	This is required as path in latex only support unix style pathes like
	
	  /home/xxx
	
	or
	
	  C:/home/xxx
	
	See https://tex.stackexchange.com/questions/9363/how-does-one-insert-a-backslash-or-a-tilde-into-latex
	"
	^ aString copyReplaceAll: '\' with: '/'
]

{ #category : #accessing }
MicLaTeXWriter class >> writerName [
	^ #latex
]

{ #category : #accessing }
MicLaTeXWriter >> canvasClass [
	^ PRLaTeXCanvas initialize
]

{ #category : #templating }
MicLaTeXWriter >> chapterTemplateName [
	
	^ 'latexChapterTemplate'
]

{ #category : #accessing }
MicLaTeXWriter >> contents [
	^ stream contents
]

{ #category : #helpers }
MicLaTeXWriter >> createLinkToLabelWithAlias: anInternalLink [
	canvas command
		name: 'hyperref';
		optParameter: [ canvas nextPutAll: anInternalLink anchor ];
		parameter: [ 
					anInternalLink counter isValidCounter
						ifTrue: [ self writeCounter: anInternalLink counter ].
					canvas nextPutAll: anInternalLink alias ]
]

{ #category : #helpers }
MicLaTeXWriter >> createLinkToLabelWithoutAlias: anInternalLink [
	canvas command
		name: 'ref';
		parameter: [ canvas raw: anInternalLink substring ]
]

{ #category : #'visiting-document' }
MicLaTeXWriter >> getLevelFor: aHeader [
	^ aHeader level
]

{ #category : #blocks }
MicLaTeXWriter >> getStringForAll: aCollection [
	"Visit each element of aCollection and exports everything to a new stream. Answer the stream content."
		| visitor |
		visitor := self class new.
		aCollection do: [ :object | visitor visit: object ].
		^ visitor contents
]

{ #category : #'visiting-document' }
MicLaTeXWriter >> getTypeOfSectionFor: aHeader [
	| sections level section |
	sections := self sectioningCommands.
	level := self getLevelFor: aHeader.
	section := sections at: (level min: sections size max: 1).
	^ section
]

{ #category : #'visiting-document' }
MicLaTeXWriter >> includeGraphicsFor: aFigure [
	canvas command
		name: 'includegraphics';
		optParameter: [ self writeGraphicsParametersOfExternalLink: aFigure ];
		parameter: [ canvas raw: (aFigure localFileOrExternalReference) ]
]

{ #category : #initialization }
MicLaTeXWriter >> initialize [ 
	super initialize.
	stream := MicOutputStream new setStream: (WriteStream on: (String new: 1000)).
	canvas := self canvasClass on: stream.
	nbListTab := -1
]

{ #category : #protected }
MicLaTeXWriter >> monospaceMacro [
	^ 'code'
]

{ #category : #helpers }
MicLaTeXWriter >> protectUrl: aString [
	^ ((aString copyReplaceAll: '\' with: '\\') copyReplaceAll: '#' with: '\#') copyReplaceAll: '%' with: '\%'
]

{ #category : #helpers }
MicLaTeXWriter >> sectioningCommands [
	^ #('part' 'chapter' 'section' 'subsection' 'subsubsection' 'paragraph' 'subparagraph')
]

{ #category : #blocks }
MicLaTeXWriter >> tabList [

	0 to: nbListTab do: [ :nothing | canvas raw: '    ' ]
]

{ #category : #protected }
MicLaTeXWriter >> tabularEnvironment [
	^ 'tabular'
]

{ #category : #blocks }
MicLaTeXWriter >> visitAnchor: anAnchor [
	canvas command
		name: 'label';
		parameter: anAnchor label
]

{ #category : #'inline - blocks' }
MicLaTeXWriter >> visitAnchorReference: anAchorReference [
	self flag: 'it is still the pillar method' .
	self createLinkToLabelWithoutAlias: anAchorReference
	"
	(anAchorReference reference isNil or: [ self configuration separateOutputFiles not ])
		ifTrue: [ 
			anAchorReference hasAlias
				ifTrue: [ 
					anAchorReference hasAnchor
						ifTrue: [ self createLinkToLabelWithAlias: anAchorReference ]
						ifFalse: [ 
							PRLinkWarning
								signal:
									(PRPillarWriter write: anAchorReference)
										,
											' will not be render because you export without separate output files. If you want your link to be render add an anchor to the beginning of your file.'.
							canvas nextPutAll: anAchorReference alias ] ]
				ifFalse: [ 
					anAchorReference hasAnchor
						ifTrue: [ self createLinkToLabelWithoutAlias: anAchorReference ] ] ]
		ifFalse: [ 
			anAchorReference hasAlias
				ifTrue: [ 
					self flag: #todo.	""If we don't render the link we can put it as Footer. We need to do it.""
					canvas nextPutAll: anAchorReference alias ]
				ifFalse: [ 
					PRLinkWarning
						signal:
							(PRPillarWriter write: anAchorReference)
								,
									' will not be exported because LaTeX doesn''t support the inter-files links. Please add an Alias to keep this internal link.' ] ]"
]

{ #category : #'visiting-document' }
MicLaTeXWriter >> visitAnnotatedParagraph: anAnnotatedParagraph [
	"Annotations need to be defined as environments in LaTeX include files (e.g. common.tex)"

	canvas environment
		name: anAnnotatedParagraph annotation;
		with: [ super visitParagraph: anAnnotatedParagraph.
			canvas newLine ]
	"Attention: we do a super call on #visitParagraph: instead of #visitAnnotatedParagraph:. The goal of this hack is to avoid trailing new line characters. This is related to PRLaTeXWriterTest>>#testStrictLineBreaksInAnnotatedParagraphs"
]

{ #category : #'inline - blocks' }
MicLaTeXWriter >> visitBold: aBold [
	canvas command name: 'textbf'; parameter: [ super visitBold: aBold ]
]

{ #category : #'inline - blocks' }
MicLaTeXWriter >> visitCitation: aCitation [
	canvas command
		name: 'cite';
		parameter: aCitation ref.

]

{ #category : #blocks }
MicLaTeXWriter >> visitCode: aCodeBlock [
	| env parameters |
	parameters := OrderedCollection new.
	aCodeBlock hasCaption
		ifTrue: [ parameters add: 'caption={' , (self getStringForAll: aCodeBlock captionElements), '}' ].
	aCodeBlock language
		ifNotEmpty:
			[ parameters add: 'language=' , aCodeBlock language asString ].
	(aCodeBlock arguments includesKey: 'label')
		ifTrue: [ parameters add: 'label=' , (aCodeBlock arguments at: 'label') ].
	env := canvas environment
		name: 'listing';
		yourself.
	parameters ifNotEmpty: [ env optParameter: parameters asCommaString ].
	env
		with: [ canvas nextPutAllLines: aCodeBlock body.
			canvas newLine ]
]

{ #category : #'inline - blocks' }
MicLaTeXWriter >> visitFigure: aFigure [
	(aFigure hasCaption not and: [ aFigure hasLabel not ])
		ifTrue: [ 
			self includeGraphicsFor: aFigure.
			^ self ].
	canvas environment
		name: 'figure';
		with:
				[ 
			canvas environment
				name: 'center';
				with:
						[ 
					self includeGraphicsFor: aFigure.
					canvas command
						name: 'caption';
						parameter: [ 
							self
								writeCaptionOfExternalLink: aFigure;
								writeLabelOfExternalLink: aFigure ].
							canvas newLine ] ]
]

{ #category : #'inline - blocks' }
MicLaTeXWriter >> visitFootnote: aFootnote [
	canvas command name: 'footnote'; parameter: (aFootnote note)
]

{ #category : #blocks }
MicLaTeXWriter >> visitHeader: aHeader [
	| section |
	canvas newLine.
	section := self getTypeOfSectionFor: aHeader.
	canvas command
		name: section;
		parameter: [ super visitHeader: aHeader ]
]

{ #category : #blocks }
MicLaTeXWriter >> visitHorizontalLine: aHorizontalLine [

	canvas newLine; newLine.
	canvas raw: '\rule{\textwidth}{0.1pt}'.
	canvas newLine.
]

{ #category : #'inline - blocks' }
MicLaTeXWriter >> visitItalic: anItalic [
	canvas command name: 'textit'; parameter: [ super visitItalic: anItalic ]
]

{ #category : #'inline - blocks' }
MicLaTeXWriter >> visitLink: aLink [
	| text reference |
	reference := aLink localFileOrExternalReference.
	text := aLink text.
	(text isEmptyOrNil or: [ reference = text ])
		ifTrue: [ canvas command
				name: 'url';
				parameter: reference ]
		ifFalse: [
			canvas command
				name: 'href';
				parameter: reference;
				parameter: [ canvas nextPutAll: text ].
			canvas command
				name: 'footnote';
				parameter: [ canvas command name: 'url'; parameter: (self protectUrl: reference) ] ]
]

{ #category : #blocks }
MicLaTeXWriter >> visitListItem: anItem [
	self tabList.
	canvas command name: 'item'.
	canvas space.
	canvas raw: [ super visitListItem: anItem ].
	canvas newLine
]

{ #category : #'visiting-document' }
MicLaTeXWriter >> visitMailLink: aLink [
	canvas command
		name: 'href';
		parameter: aLink unscrambledUrl;
		parameter: aLink alias
]

{ #category : #'inline - blocks' }
MicLaTeXWriter >> visitMonospace: aMonospace [
	canvas command
		name: self monospaceMacro;
		parameter: [ super visitMonospace: aMonospace ]
]

{ #category : #blocks }
MicLaTeXWriter >> visitOrderedList: aList [
	"tabulation for  \begin{itemize} it can do in the environment of the canvas"
	canvas newLine.
	self tabList.
	canvas raw: '\begin{enumerate}'.
	canvas newLine.
	nbListTab := nbListTab + 1.
	super visitOrderedList: aList.
	nbListTab := nbListTab - 1.
	self tabList.
	canvas raw: '\end{enumerate}'.
	canvas newLine.
]

{ #category : #blocks }
MicLaTeXWriter >> visitParagraph: aParagraph [
	canvas newLine.
	super visitParagraph: aParagraph.
	canvas newLine.
]

{ #category : #blocks }
MicLaTeXWriter >> visitQuote: aQuote [
	canvas environment
		name: 'verbatim';
		with: [ aQuote children do: [ :child | 
						self visit: child.
						canvas newLine ] ]
]

{ #category : #'inline - blocks' }
MicLaTeXWriter >> visitStrike: aStrike [
	canvas command name: 'sout'; parameter: [ super visitStrike: aStrike ]
]

{ #category : #blocks }
MicLaTeXWriter >> visitTable: aTable [
	| environment |
	environment := canvas environment name: self tabularEnvironment.
	aTable rows size = 0
		ifTrue: [ environment with: [  ].
			^ self ].
	environment parameter: aTable latexSpecification.
	environment
		with: [ canvas command name: 'toprule'.
			canvas newLine.
			aTable rows doWithIndex: [ :row :i | self visitTableRow: row with: aTable hasHeader at: i].
			canvas command name: 'bottomrule'.
			canvas newLine ]
]

{ #category : #blocks }
MicLaTeXWriter >> visitTableCell: aCell [
	aCell isAligned
		ifFalse: [ self writeTableCellContent: aCell ]
		ifTrue: [ 
			canvas command
				name: 'multicolumn';
				parameter: '1';
				parameter: aCell latexAlignment;
				parameter: [ self writeTableCellContent: aCell ] ]
]

{ #category : #blocks }
MicLaTeXWriter >> visitTableCell: aCell with: aBool [
	self writeTableCellContent: aCell with: aBool 
]

{ #category : #blocks }
MicLaTeXWriter >> visitTableRow: aRow [
	self visitAll: aRow children separatedBy: [ canvas raw: ' & ' ].
	canvas
		raw: ' \\';
		newLine.
	aRow isHeading
		ifTrue: [ 
			canvas command name: 'midrule'.
			canvas newLine ]
]

{ #category : #blocks }
MicLaTeXWriter >> visitTableRow: aRow with: aBool at: anIndex [
	aRow do: [ :cell | self visitTableCell: cell with: (aBool and: [ anIndex = 1 ]) ] separatedBy: [ canvas raw: ' & ' ].
	canvas
		raw: ' \\';
		newLine.
	(aBool and: [ anIndex = 1 ])
		ifTrue: [ 
			canvas command name: 'midrule'.
			canvas newLine ]
]

{ #category : #visiting }
MicLaTeXWriter >> visitText: aText [
	canvas nextPutAllLines: aText substring
]

{ #category : #'visiting-document' }
MicLaTeXWriter >> visitUnderlineFormat: aFormat [
	canvas command
		name: 'uline';
		parameter: [ super visitUnderlineFormat: aFormat ]
]

{ #category : #blocks }
MicLaTeXWriter >> visitUnorderedList: aList [
	"tabulation for  \begin{itemize} it can do in the environment of the canvas"
	canvas newLine.
	self tabList.
	canvas raw: '\begin{itemize}'.
	canvas newLine.
	nbListTab := nbListTab + 1.
	super visitUnorderedList: aList.
	nbListTab := nbListTab - 1.
	self tabList.
	canvas raw: '\end{itemize}'.
	canvas newLine.
]

{ #category : #helpers }
MicLaTeXWriter >> writeCaptionOfExternalLink: anExternalLink [
	self visitAll: anExternalLink children
]

{ #category : #helpers }
MicLaTeXWriter >> writeGraphicsParametersOfExternalLink: anExternalLink [
	canvas
		nextPutAll: 'width=';
		nextPutAll: ((anExternalLink parameters at: 'width' ifAbsent: [ 100 ]) asNumber / 100.0) printString;
		raw: '\textwidth'
]

{ #category : #helpers }
MicLaTeXWriter >> writeLabelOfExternalLink: anExternalLink [
	| label |
	label := anExternalLink parameters at: 'label' ifAbsent: [ anExternalLink localFileOrExternalReference ].
	canvas command
		name: 'label';
		parameter: [ canvas raw: label ]
]

{ #category : #helpers }
MicLaTeXWriter >> writeTableCellContent: aCell [
	^ aCell isHeading
		ifTrue: [ 
			canvas command
				name: 'textbf';
				parameter: [ super visitTableCell: aCell ] ]
		ifFalse: [ super visitTableCell: aCell ]
]

{ #category : #blocks }
MicLaTeXWriter >> writeTableCellContent: aCell with: aBool [
	^ aBool
		ifTrue: [ 
			canvas command
				name: 'textbf';
				parameter: [ self visitAll: aCell ] ]
		ifFalse: [ self visitAll: aCell ]
]
