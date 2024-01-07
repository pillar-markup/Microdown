"
I'm producing a textual latex version of a microdown document.
"
Class {
	#name : #MicLaTeXWriter,
	#superclass : #MicDocumentWriter,
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
	^ #miclatex
]

{ #category : #accessing }
MicLaTeXWriter >> canvas [
	^ canvas
]

{ #category : #accessing }
MicLaTeXWriter >> canvasClass [
	^ MicLaTeXCanvas
]

{ #category : #templating }
MicLaTeXWriter >> chapterTemplateName [
	
	^ 'latexChapterTemplate'
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

{ #category : #helpers }
MicLaTeXWriter >> getStringForAll: aCollection [
	"Visit each element of aCollection and exports everything to a new stream. Answer the stream content."
		| visitor |
		visitor := self class new.
		aCollection do: [ :object | visitor visit: object ].
		^ visitor contents
]

{ #category : #'visiting-document' }
MicLaTeXWriter >> includeGraphicsFor: aFigure [

	canvas command
		name: 'includegraphics';
		optParameter: [ self writeGraphicsParametersOfExternalLink: aFigure ];
		parameter: [ canvas raw: aFigure fullName ]
	"we should see when the reference is resolved if we really emit well figures in the case of file://figures/logo.png"
	
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

{ #category : #helpers }
MicLaTeXWriter >> tabList [

	0 to: nbListTab do: [ :nothing | canvas raw: '    ' ]
]

{ #category : #protected }
MicLaTeXWriter >> tabularEnvironment [
	^ 'tabular'
]

{ #category : #'visiting-document' }
MicLaTeXWriter >> typeOfSectionFor: aHeader [
	| sections level section |
	sections := self sectioningCommands.
	level := aHeader level.
	section := sections at: (level min: sections size max: 1).
	^ section
]

{ #category : #blocks }
MicLaTeXWriter >> visitAnchor: anAnchor [
	canvas command
		name: 'label';
		parameter: anAnchor label
]

{ #category : #'blocks - inline' }
MicLaTeXWriter >> visitAnchorReference: anAchorReference [

	self createLinkToLabelWithoutAlias: anAchorReference
	
]

{ #category : #'blocks - inline' }
MicLaTeXWriter >> visitBold: aBold [
	canvas command name: 'textbf'; parameter: [ super visitBold: aBold ]
]

{ #category : #'blocks - inline' }
MicLaTeXWriter >> visitCitation: aCitation [
	canvas command
		name: 'cite';
		parameter: aCitation ref.

]

{ #category : #'blocks - code' }
MicLaTeXWriter >> visitCode: aCodeBlock [
	| env parameters |
	parameters := OrderedCollection new.
	aCodeBlock hasCaption
		ifTrue: [ parameters add: 'caption={' , (self getStringForAll: aCodeBlock captionElements), '}' ].
	aCodeBlock hasNonDefaultLanguage 
		ifTrue: [parameters add: 'language=' , aCodeBlock language asString].
	aCodeBlock hasLabel
		ifTrue: [ parameters add: 'label=' , aCodeBlock label ].
	env := canvas environment
		name: 'listing';
		yourself.
	parameters ifNotEmpty: [ env optParameter: parameters asCommaString ].
	env
		with: [ 
			canvas nextPutAllLines: aCodeBlock body.
			canvas newLine ]
]

{ #category : #'blocks - inline' }
MicLaTeXWriter >> visitFigure: aFigure [

	(aFigure hasCaption not and: [ aFigure hasLabel not ]) ifTrue: [ 
		self includeGraphicsFor: aFigure.
		^ self ].
	canvas environment
		name: 'figure';
		optParameter: [ canvas raw: 'htpb' ];
		with: [ 
			canvas environment
				name: 'center';
				with: [ 
					self includeGraphicsFor: aFigure.
					canvas newLine.
					canvas command
						name: 'caption';
						parameter: [ self writeCaptionOfExternalLink: aFigure ].
					self writeLabelOfExternalLink: aFigure.
					canvas newLine ] ]
]

{ #category : #'blocks - inline' }
MicLaTeXWriter >> visitFootnote: aFootnote [
	canvas command name: 'footnote'; parameter: (aFootnote note)
]

{ #category : #blocks }
MicLaTeXWriter >> visitHeader: aHeader [
	| section |
	canvas newLine.
	section := self typeOfSectionFor: aHeader.
	canvas command
		name: section;
		parameter: [ super visitHeader: aHeader ]
]

{ #category : #blocks }
MicLaTeXWriter >> visitHorizontalLine: aHorizontalLine [

	canvas newLine.
	canvas raw: '\rule{\textwidth}{0.1pt}'.
	canvas newLine.
]

{ #category : #'blocks - inline' }
MicLaTeXWriter >> visitItalic: anItalic [
	canvas command name: 'textit'; parameter: [ super visitItalic: anItalic ]
]

{ #category : #'blocks - inline' }
MicLaTeXWriter >> visitLink: aLink [
	| reference |
	reference := aLink fileStringWithoutHostFile.
	canvas command
		name: 'href';
		parameter: reference;
		parameter: [ self visitAll: aLink children ].
	canvas command
		name: 'footnotesize';
		parameter: [ canvas command name: 'url'; parameter: (self protectUrl: reference) ]
]

{ #category : #'blocks - list' }
MicLaTeXWriter >> visitListItem: anItem [
	self tabList.
	canvas command name: 'item'.
	canvas space.
	canvas raw: [ super visitListItem: anItem ].
	canvas newLine
]

{ #category : #'blocks - inline' }
MicLaTeXWriter >> visitMonospace: aMonospace [
	canvas command
		name: self monospaceMacro;
		parameter: [ super visitMonospace: aMonospace ]
]

{ #category : #'blocks - list' }
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
	nbListTab = -1 ifTrue: [canvas newLine]
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

{ #category : #'blocks - inline' }
MicLaTeXWriter >> visitStrike: aStrike [
	canvas command name: 'sout'; parameter: [ super visitStrike: aStrike ]
]

{ #category : #'blocks - table' }
MicLaTeXWriter >> visitTable: aTable [
	| environment |
	canvas newLine.
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

{ #category : #'blocks - table' }
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

{ #category : #'blocks - table' }
MicLaTeXWriter >> visitTableCell: aCell with: aBool [
	self writeTableCellContent: aCell with: aBool 
]

{ #category : #'blocks - table' }
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

{ #category : #'blocks - table' }
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

{ #category : #blocks }
MicLaTeXWriter >> visitText: aText [

	canvas nextPutAllLines: aText bodystring
]

{ #category : #'blocks - list' }
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
	nbListTab = -1 ifTrue: [canvas newLine]
]

{ #category : #helpers }
MicLaTeXWriter >> writeCaptionOfExternalLink: anExternalLink [

	self visitAll: anExternalLink children
]

{ #category : #helpers }
MicLaTeXWriter >> writeGraphicsParametersOfExternalLink: anExternalLink [

	canvas
		nextPutAll: 'width=';
		nextPutAll:
			((anExternalLink arguments at: 'width' ifAbsent: [ 100 ]) asNumber
			 / 100.0) printString;
		raw: '\textwidth'
]

{ #category : #helpers }
MicLaTeXWriter >> writeLabelOfExternalLink: anExternalLink [
	"we decided not to create an arbitrary label when there is none specified.
	This decision should be changed but we need to find a way to uniquely identify a figure, math, ..."
	
	| label |
	label := anExternalLink arguments
		         at: 'label'
		         ifAbsent: [ nil ].
	label ifNotNil: [ 
		canvas command
			name: 'label';
			parameter: [ canvas raw: label ] ]
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

{ #category : #'blocks - table' }
MicLaTeXWriter >> writeTableCellContent: aCell with: aBool [
	^ aBool
		ifTrue: [ 
			canvas command
				name: 'textbf';
				parameter: [ self visitAll: aCell ] ]
		ifFalse: [ self visitAll: aCell ]
]
