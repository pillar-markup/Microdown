"
I am a pillar document writer that wraps a normal wrapper.
When writing one element, I first check if there is a file in the current template that overrides the default writing. If so, I use that file to template the contents.
Otherwise I simply delegate the writing to the wrapped one.

I am carefully designed so if an element X is delegated to the wrapped writer, it should delegate the writing of X's children back to myself.
"
Class {
	#name : 'MicTemplatedWriter',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'outputDocument',
		'defaultWriter',
		'environmentStack'
	],
	#category : 'Microdown-Templated',
	#package : 'Microdown-Templated'
}

{ #category : 'templates' }
MicTemplatedWriter class >> anchorTemplateFileName [
	
	^ 'anchor.mustache'
]

{ #category : 'templates' }
MicTemplatedWriter class >> boldTemplateFileName [
	
	^ 'bold.mustache'
]

{ #category : 'templates' }
MicTemplatedWriter class >> codeBlockTemplateFileName [
	
	^ 'codeBlock.mustache'
]

{ #category : 'templates' }
MicTemplatedWriter class >> commentedLineTemplateFileName [
	
	^ 'commentedLine.mustache'
]

{ #category : 'templates' }
MicTemplatedWriter class >> dataItemTemplateFileName [
	
	^ 'dataItem.mustache'
]

{ #category : 'templates' }
MicTemplatedWriter class >> defaultAnnotatedParagraphTemplateFileName [
	
	^ 'defaultAnnotatedParagraph.mustache'
]

{ #category : 'templates' }
MicTemplatedWriter class >> definitionListTemplateFileName [
	
	^ 'definitionList.mustache'
]

{ #category : 'templates' }
MicTemplatedWriter class >> emptyParagraphTemplateFileName [

	^ 'emptyParagraph.mustache'
]

{ #category : 'templates' }
MicTemplatedWriter class >> externalLinkTemplateFileName [
	
	^ 'externalLink.mustache'
]

{ #category : 'templates' }
MicTemplatedWriter class >> figureTemplateFileName [

	^ 'figure.mustache'
]

{ #category : 'templates' }
MicTemplatedWriter class >> headerTemplateFileName [
	
	^ 'header.mustache'
]

{ #category : 'templates' }
MicTemplatedWriter class >> horizontalRuleTemplateFileName [
	
	^ 'horizontalRule.mustache'
]

{ #category : 'templates' }
MicTemplatedWriter class >> internalLinkTemplateFileName [
	
	^ 'internalLink.mustache'
]

{ #category : 'templates' }
MicTemplatedWriter class >> italicTemplateFileName [
	
	^ 'italic.mustache'
]

{ #category : 'templates' }
MicTemplatedWriter class >> lineBreakTemplateFileName [
	
	^ 'lineBreak.mustache'
]

{ #category : 'templates' }
MicTemplatedWriter class >> listItemTemplateFileName [

	^ 'listItem.mustache'
]

{ #category : 'templates' }
MicTemplatedWriter class >> mailLinkTemplateFileName [
	
	^ 'mailLink.mustache'
]

{ #category : 'templates' }
MicTemplatedWriter class >> monospaceTemplateFileName [

	^ 'monospace.mustache'
]

{ #category : 'templates' }
MicTemplatedWriter class >> orderedListTemplateFileName [
	
	^ 'orderedList.mustache'
]

{ #category : 'templates' }
MicTemplatedWriter class >> paragraphTemplateFileName [
	
	^ 'paragraph.mustache'
]

{ #category : 'templates' }
MicTemplatedWriter class >> preformattedTemplateFileName [
	
	^ 'preformatted.mustache'
]

{ #category : 'templates' }
MicTemplatedWriter class >> sectionTemplateFileName [
	
	^ 'section.mustache'
]

{ #category : 'templates' }
MicTemplatedWriter class >> unorderedListTemplateFileName [

	^ 'unorderedList.mustache'
]

{ #category : 'accessing' }
MicTemplatedWriter class >> writerName [

	^ #templatedWriter
]

{ #category : 'accessing - templates' }
MicTemplatedWriter >> anchorTemplateFileName [

	^ self class anchorTemplateFileName
]

{ #category : 'accessing - templates' }
MicTemplatedWriter >> boldTemplateFileName [

	^ self class boldTemplateFileName
]

{ #category : 'accessing - templates' }
MicTemplatedWriter >> codeBlockTemplateFileName [

	^ self class codeBlockTemplateFileName
]

{ #category : 'accessing - templates' }
MicTemplatedWriter >> commentedLineTemplateFileName [

	^ self class commentedLineTemplateFileName
]

{ #category : 'accessing' }
MicTemplatedWriter >> contents [
	
	^ defaultWriter contents
]

{ #category : 'environment' }
MicTemplatedWriter >> currentEnvironmentPath [
	
	^ RelativePath withAll: (environmentStack collect: [:each | each name]) reversed
]

{ #category : 'accessing - templates' }
MicTemplatedWriter >> dataItemTemplateFileName [

	^ self class dataItemTemplateFileName
]

{ #category : 'accessing - templates' }
MicTemplatedWriter >> defaultAnnotatedParagraphTemplateFileName [

	^ self class defaultAnnotatedParagraphTemplateFileName
]

{ #category : 'accessing' }
MicTemplatedWriter >> defaultWriter [
	^ defaultWriter
]

{ #category : 'accessing' }
MicTemplatedWriter >> defaultWriter: anObject [
	defaultWriter := anObject
]

{ #category : 'accessing - templates' }
MicTemplatedWriter >> definitionListTemplateFileName [

	^ self class definitionListTemplateFileName
]

{ #category : 'accessing - templates' }
MicTemplatedWriter >> emptyParagraphTemplateFileName [

	^ self class emptyParagraphTemplateFileName
]

{ #category : 'accessing' }
MicTemplatedWriter >> environmentStack: aCollection [ 
	environmentStack := aCollection
]

{ #category : 'accessing - templates' }
MicTemplatedWriter >> externalLinkTemplateFileName [

	^ self class externalLinkTemplateFileName
]

{ #category : 'accessing - templates' }
MicTemplatedWriter >> figureTemplateFileName [

	^ self class figureTemplateFileName
]

{ #category : 'accessing' }
MicTemplatedWriter >> folderName [

	^ defaultWriter folderName
]

{ #category : 'accessing - templates' }
MicTemplatedWriter >> headerTemplateFileName [

	^ self class headerTemplateFileName
]

{ #category : 'accessing - templates' }
MicTemplatedWriter >> horizontalRuleTemplateFileName [

	^ self class horizontalRuleTemplateFileName
]

{ #category : 'initialization' }
MicTemplatedWriter >> initialize [

	super initialize.
	environmentStack := OrderedCollection new.
]

{ #category : 'accessing - templates' }
MicTemplatedWriter >> internalLinkTemplateFileName [

	^ self class internalLinkTemplateFileName
]

{ #category : 'accessing - templates' }
MicTemplatedWriter >> italicTemplateFileName [
		
	^ self class italicTemplateFileName
]

{ #category : 'accessing - templates' }
MicTemplatedWriter >> lineBreakTemplateFileName [

	^ self class lineBreakTemplateFileName
]

{ #category : 'accessing - templates' }
MicTemplatedWriter >> listItemTemplateFileName [

	^ self class listItemTemplateFileName
]

{ #category : 'accessing - templates' }
MicTemplatedWriter >> mailLinkTemplateFileName [

	^ self class mailLinkTemplateFileName
]

{ #category : 'accessing - templates' }
MicTemplatedWriter >> monospaceTemplateFileName [

	^ self class monospaceTemplateFileName
]

{ #category : 'accessing - templates' }
MicTemplatedWriter >> orderedListTemplateFileName [

	^ self class orderedListTemplateFileName
]

{ #category : 'accessing' }
MicTemplatedWriter >> outputDocument [
	^ outputDocument
]

{ #category : 'accessing' }
MicTemplatedWriter >> outputDocument: anObject [
	outputDocument := anObject
]

{ #category : 'accessing - templates' }
MicTemplatedWriter >> paragraphTemplateFileName [

	^ self class paragraphTemplateFileName
]

{ #category : 'environment' }
MicTemplatedWriter >> popEnvironment [
	
	environmentStack removeFirst
]

{ #category : 'accessing - templates' }
MicTemplatedWriter >> preformattedTemplateFileName [

	^ self class preformattedTemplateFileName
]

{ #category : 'environment' }
MicTemplatedWriter >> pushEnvironment: aPREnvironment [ 
	
	environmentStack addFirst: aPREnvironment
]

{ #category : 'accessing - templates' }
MicTemplatedWriter >> sectionTemplateFileName [

	^ self class sectionTemplateFileName
]

{ #category : 'accessing' }
MicTemplatedWriter >> templateForConfiguration: aConfiguration [

	^ defaultWriter templateForConfiguration: aConfiguration
]

{ #category : 'accessing - templates' }
MicTemplatedWriter >> unorderedListTemplateFileName [

	^ self class unorderedListTemplateFileName
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitAnchor: aPRAnchor [

	self
		writeRawText: ''
		withTemplateFileName: self anchorTemplateFileName
		extraArguments: { 'name' -> aPRAnchor name }
		ifAbsent: [ defaultWriter visitAnchor: aPRAnchor ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitAnnotatedParagraph: anAnnotatedParagraph [

	| arguments |
	arguments := { 'annotation' -> anAnnotatedParagraph annotation }.
	self
		write: anAnnotatedParagraph
		withTemplateFileName: anAnnotatedParagraph annotation , '.mustache'
		extraArguments: arguments 
		ifAbsent: [
			self
				write: anAnnotatedParagraph
				withTemplateFileName: self defaultAnnotatedParagraphTemplateFileName
				extraArguments: arguments 
				ifAbsent: [ defaultWriter visitAnnotatedParagraph: anAnnotatedParagraph ] ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitBoldFormat: aPRBoldFormat [

	self
		write: aPRBoldFormat
		withTemplateFileName: self boldTemplateFileName
		ifAbsent: [ defaultWriter visitBoldFormat: aPRBoldFormat ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitCodeblock: aPRCodeblock [ 

	self
		writeRawText: aPRCodeblock text
		withTemplateFileName: self codeBlockTemplateFileName
		extraArguments: { 'language' -> (defaultWriter languageForScript: aPRCodeblock) }
		ifAbsent: [ defaultWriter visitCodeblock: aPRCodeblock ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitCommentedLine: aPRText [ 

	self
		writeRawText: aPRText text
		withTemplateFileName: self commentedLineTemplateFileName
		ifAbsent: [ defaultWriter visitCommentedLine: aPRText  ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitDataItem: aPRListItem [

	self
		write: aPRListItem
		withTemplateFileName: self dataItemTemplateFileName
		ifAbsent: [ defaultWriter visitDataItem: aPRListItem ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitDefinitionList: aPRList [

	self
		write: aPRList
		withTemplateFileName: self definitionListTemplateFileName
		ifAbsent: [ defaultWriter visitDefinitionList: aPRList ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitEmptyParagraph: anEmptyParagraph [
	
	self
		writeRawText: anEmptyParagraph text
		withTemplateFileName: self emptyParagraphTemplateFileName
		ifAbsent: [ defaultWriter visitEmptyParagraph: anEmptyParagraph ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitEnvironment: anEnvironment [

	self pushEnvironment: anEnvironment.
	self
		write: anEnvironment
		withTemplateFileName: 'main.mustache'
		extraArguments: anEnvironment properties associations
		ifAbsent: [ self visitDocumentGroup: anEnvironment ].
	self popEnvironment.
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitExternalLink: aPRExternalLink [

	self
		write: aPRExternalLink
		withTemplateFileName: self externalLinkTemplateFileName
		extraArguments: { 'reference' -> aPRExternalLink reference }
		ifAbsent: [ defaultWriter visitExternalLink: aPRExternalLink ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitFigure: aFigure [

	self
		write: aFigure
		withTemplateFileName: self figureTemplateFileName
		extraArguments: {
			'ref' -> aFigure fileStringWithoutHostFile.
			'caption' -> (aFigure hasChildren ifTrue: [ aFigure text ] ifFalse: [ '' ]) }
		ifAbsent: [ defaultWriter visitFigure: aFigure ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitHeader: aHeader [

	self
		write: aHeader
		withTemplateFileName: self headerTemplateFileName
		extraArguments: { 'level' -> (aHeader level min: 7 max: 1) }
		ifAbsent: [ defaultWriter visitHeader: aHeader ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitHorizontalRule: aPRHorizontalRule [

	self
		writeRawText: ''
		withTemplateFileName: self horizontalRuleTemplateFileName
		ifAbsent: [ defaultWriter visitHorizontalRule: aPRHorizontalRule ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitInternalLink: aPRInternalLink [

	self
		write: aPRInternalLink
		withTemplateFileName: self internalLinkTemplateFileName
		extraArguments: { 'reference' -> aPRInternalLink reference }
		ifAbsent: [ defaultWriter visitInternalLink: aPRInternalLink ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitItalicFormat: aPRItalicFormat [ 
	
	self
		write: aPRItalicFormat
		withTemplateFileName: self italicTemplateFileName
		ifAbsent: [ defaultWriter visitItalicFormat: aPRItalicFormat ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitLineBreak: aPRLineBreak [

	self
		writeRawText: ''
		withTemplateFileName: self lineBreakTemplateFileName
		ifAbsent: [ defaultWriter visitLineBreak: aPRLineBreak ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitListItem: aPRListItem [

	self
		write: aPRListItem
		withTemplateFileName: self listItemTemplateFileName
		ifAbsent: [ defaultWriter visitListItem: aPRListItem ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitMailLink: aPRMailLink [

	self
		write: aPRMailLink
		withTemplateFileName: self mailLinkTemplateFileName
		extraArguments: { 'reference' -> aPRMailLink reference }
		ifAbsent: [ defaultWriter visitExternalLink: aPRMailLink ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitMonospaceFormat: aPRMonospaceFormat [ 
	
	self
		write: aPRMonospaceFormat
		withTemplateFileName: self monospaceTemplateFileName
		ifAbsent: [ defaultWriter visitMonospaceFormat: aPRMonospaceFormat ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitOrderedList: aPROrderedList [

	self
		write: aPROrderedList
		withTemplateFileName: self orderedListTemplateFileName
		ifAbsent: [ defaultWriter visitOrderedList: aPROrderedList ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitParagraph: aParagraph [

	self
		write: aParagraph
		withTemplateFileName: self paragraphTemplateFileName
		ifAbsent: [ defaultWriter visitParagraph: aParagraph ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitPreformatted: aPRPreformatted [

	self
		write: aPRPreformatted
		withTemplateFileName: self preformattedTemplateFileName
		ifAbsent: [ defaultWriter visitPreformatted: aPRPreformatted ]
]

{ #category : 'delegating' }
MicTemplatedWriter >> visitRaw: aPRRaw [ 
	
	defaultWriter visitRaw: aPRRaw
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitSection: aPRSection [

	self
		write: aPRSection
		withTemplateFileName: self sectionTemplateFileName
		ifAbsent: [ defaultWriter visitSection: aPRSection ]
]

{ #category : 'delegating' }
MicTemplatedWriter >> visitText: aPRText [ 
	
	defaultWriter visitText: aPRText
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitUnorderedList: aPRUnorderedList [ 

	self
		write: aPRUnorderedList
		withTemplateFileName: self unorderedListTemplateFileName
		ifAbsent: [ defaultWriter visitUnorderedList: aPRUnorderedList ]
]

{ #category : 'writing' }
MicTemplatedWriter >> write: aMicElement [ 
	
	aMicElement accept: self.
	^ defaultWriter contents
]

{ #category : 'writing' }
MicTemplatedWriter >> write: aMicElement 
	withTemplateFileName: templateFileName 
	extraArguments: arguments 
	ifAbsent: aBlock [

	self
		writeRawText: [ | subWriter |
			subWriter := outputDocument writer.
			subWriter environmentStack: environmentStack. 
			subWriter visitChildrenOf: aMicElement.
			subWriter contents ]
		withTemplateFileName: templateFileName
		extraArguments: arguments
		ifAbsent: aBlock
]

{ #category : 'writing' }
MicTemplatedWriter >> write: aDocumentItem withTemplateFileName: templateFileName ifAbsent: aBlock [

	self
		write: aDocumentItem
		withTemplateFileName: templateFileName
		extraArguments: #()
		ifAbsent: aBlock
]

{ #category : 'writing' }
MicTemplatedWriter >> writeRawText: aText withTemplateFileName: templateFileName extraArguments: arguments ifAbsent: aBlock [

	| templateFile result environmentPath foundPath |
	environmentPath := self currentEnvironmentPath.
	
	foundPath := environmentPath
		lookup: [ :path | ((outputDocument templateDirectory resolve: path) / templateFileName) exists ]
		ifNone: [ ^ aBlock value ].
	
	templateFile := outputDocument templateDirectory resolve: foundPath / templateFileName.
		
	result := templateFile asMustacheTemplate value: ({ 'contents' -> aText value }, arguments) asDictionary.
	self visitRaw: (PRRaw content: result type: defaultWriter writerName)
]

{ #category : 'writing' }
MicTemplatedWriter >> writeRawText: aText withTemplateFileName: templateFileName ifAbsent: aBlock [

	^ self
		writeRawText: aText
		withTemplateFileName: templateFileName
		extraArguments: #()
		ifAbsent: aBlock
]
