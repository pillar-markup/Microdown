Class {
	#name : #MicTemplatedWriterTest,
	#superclass : #TestCase,
	#instVars : [
		'textDocument'
	],
	#category : #'Microdown-Templated'
}

{ #category : #helpers }
MicTemplatedWriterTest >> assertTemplate: template writesValue: value forNode: node [

	self assertTemplatePath: Path * template writesValue: value forNode: node 
]

{ #category : #helpers }
MicTemplatedWriterTest >> assertTemplatePath: templatePath writesValue: contents forNode: node [

	self createTemplateFileAt: templatePath withContents: contents.
	self assertWritingNode: node writes: contents.
]

{ #category : #helpers }
MicTemplatedWriterTest >> assertWritingNode: node writes: contents [

	| document result |
	document := MicRootBlock new
		addChild: node;
		yourself.
	
	result := textDocument writer write: document.

	self assert: result equals: contents
]

{ #category : #helpers }
MicTemplatedWriterTest >> createTemplateFileAt: aPath withContents: contents [

	| templateFileReference |
	templateFileReference := textDocument templateDirectory resolve: aPath.
	templateFileReference parent ensureCreateDirectory.
	templateFileReference writeStreamDo: [ :stream | stream nextPutAll: contents ].
]

{ #category : #running }
MicTemplatedWriterTest >> setUp [

	super setUp.
	textDocument := MicTextDocumentMaker new
				baseDirectory: FileSystem memory;
				yourself.
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteAnchorUsesAnchorTemplate [

	self
		assertTemplate: 'todo.mustache'
		writesValue: 'annotated paragraph'
		forNode: (PRAnnotatedParagraph withAll: #() annotation: 'todo')
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteAnchorUsesDefaultIfNotSpecificIsDefinedTemplate [

	self
		assertTemplate: MicTemplatedWriter defaultAnnotatedParagraphTemplateFileName
		writesValue: 'annotated paragraph'
		forNode: (PRAnnotatedParagraph withAll: #() annotation: 'todo')
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteBoldUsesBoldTemplate [

	self
		assertTemplate: MicTemplatedWriter boldTemplateFileName
		writesValue: 'boldTemplate'
		forNode: (MicBoldFormatBlock new children: { MicTextBlock new substring: 'Bar'}) 
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteCodeBlockUsesCodeBlockTemplate [

	self
		assertTemplate: MicTemplatedWriter codeBlockTemplateFileName
		writesValue: 'codeBlockTemplate'
		forNode: (PRCodeblock content: '^ self')
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteCommentedLineUsesCommentedLineTemplate [

	self
		assertTemplate: MicTemplatedWriter commentedLineTemplateFileName
		writesValue: 'commented line'
		forNode: (PRCommentedLine content: 'some comment')
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteDataItemUsesDataItemTemplate [

	self
		assertTemplate: MicTemplatedWriter dataItemTemplateFileName
		writesValue: 'dataitem'
		forNode: PRDataItem new
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteDefinitionListUsesDefinitionListTemplate [

	self
		assertTemplate: MicTemplatedWriter definitionListTemplateFileName
		writesValue: 'definitionList'
		forNode: PRDefinitionList new
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteEmptyParagraphsUsesEmptyParagraphTemplate [

	self
		assertTemplate: MicTemplatedWriter emptyParagraphTemplateFileName
		writesValue: 'emptyParagraph'
		forNode: PREmptyParagraph new
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteEnvironmentItselfUsesMainTemplate [

	self
		assertTemplatePath: RelativePath * 'cards' / 'main.mustache'
		writesValue: 'Template for cards itself'
		forNode: ((PREnvironment named: 'cards')
						add: (PRParagraph new
							add: (PRText content: 'Foo');
							yourself);
			yourself)
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteEnvironmentUsesArguments [

	self
		createTemplateFileAt: RelativePath * 'card' / 'main.mustache'
		withContents: 'before {{{someArgument}}} after'.

	self
		assertWritingNode: ((PREnvironment named: 'card')
			propertyAt: 'someArgument' put: 'test';
			yourself)
		writes: 'before test after'
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteExternalLinkUsesExternalLinkTemplate [

	self
		assertTemplate: MicTemplatedWriter externalLinkTemplateFileName
		writesValue: 'external link'
		forNode: (PRExternalLink new reference: 'http://pharo.org')
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteFigureUsesFigureTemplate [

	self
		assertTemplate: MicTemplatedWriter figureTemplateFileName
		writesValue: 'figure'
		forNode: (PRFigure reference: 'bla.png')
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteHeaderUsesHeaderTemplate [

	self
		assertTemplate: MicTemplatedWriter headerTemplateFileName
		writesValue: 'aHeader'
		forNode: (PRHeader new
			level: 2;
			add: (PRText content: 'foo'))
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteHorizontalRuleUsesHorizontalRuleTemplate [

	self
		assertTemplate: MicTemplatedWriter horizontalRuleTemplateFileName
		writesValue: '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-='
		forNode: PRHorizontalRule new
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteInternalLinkUsesInternalLinkTemplate [

	self
		assertTemplate: MicTemplatedWriter internalLinkTemplateFileName
		writesValue: 'internal link'
		forNode: (PRInternalLink new reference: 'bla.pillar')
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteItalicUsesItalicTemplate [

	self
		assertTemplate: MicTemplatedWriter italicTemplateFileName
		writesValue: 'italicTemplate'
		forNode: (PRItalicFormat with: (PRText content: 'Bar'))
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteLineBreakUsesLineBreakTemplate [

	self
		assertTemplate: MicTemplatedWriter lineBreakTemplateFileName
		writesValue: 'line break'
		forNode: PRLineBreak new
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteListItemUsesListItemTemplate [

	self
		assertTemplate: MicTemplatedWriter listItemTemplateFileName
		writesValue: 'list item'
		forNode: PRListItem new
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteMailLinkUsesMailLinkTemplate [

	self
		assertTemplate: MicTemplatedWriter mailLinkTemplateFileName
		writesValue: 'a link'
		forNode: (PRMailLink reference: 'foo@bar.com')
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteMonospaceUsesMonospaceTemplate [

	self
		assertTemplate: MicTemplatedWriter monospaceTemplateFileName
		writesValue: 'monospace'
		forNode: (PRMonospaceFormat with: (PRText content: 'Bar'))
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteNestedEnvironmentItselfUsesMainTemplate [

	self
		assertTemplatePath: RelativePath * 'cards' / 'card' / 'main.mustache'
		writesValue: 'Template for the card itself'
		forNode: ((PREnvironment named: 'cards')
						add: ((PREnvironment named: 'card')
									add: (PRParagraph new add: (PRText content: 'Foo');
							yourself));
					yourself)
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteNestedEnvironmentWithChilds [

	self
		createTemplateFileAt: RelativePath * 'cards' / 'main.mustache'
		withContents: '{{{contents}}}'.
	self
		createTemplateFileAt: RelativePath * 'cards' / 'card' / 'main.mustache'
		withContents: '{{{contents}}}'.

	self
		assertTemplatePath: RelativePath * 'cards' / 'card' / 'paragraph.mustache'
		writesValue: 'Paragraph definition in cards/card'
		forNode: ((PREnvironment named: 'cards')
						add: ((PREnvironment named: 'card')
									add: (PRParagraph new add: (PRText content: 'Foo');
							yourself));
					yourself)
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteOrderedListUsesOrderedListTemplate [

	self
		assertTemplate: MicTemplatedWriter orderedListTemplateFileName
		writesValue: 'ordered list'
		forNode: PROrderedList new
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteParagraphUsesParagraphTemplate [

	self
		assertTemplate: MicTemplatedWriter paragraphTemplateFileName
		writesValue: 'unorderedList'
		forNode: PRParagraph new
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWritePreformattedUsesPreformattedTemplate [

	self
		assertTemplate: MicTemplatedWriter preformattedTemplateFileName
		writesValue: 'preformatted'
		forNode: (PRPreformatted with: (PRText content: 'Bar'))
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteSectionUsesSectionTemplate [

	self
		assertTemplate: MicTemplatedWriter sectionTemplateFileName
		writesValue: 'section'
		forNode: PRSection new
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteTextInsideEnvironmentLooksUpOutsideEnvironment [

	self
		assertTemplate: 'paragraph.mustache'
		writesValue: 'Paragraph outside card'
		forNode: ((PREnvironment named: 'card')
			add: (PRParagraph new
				add: (PRText content: 'Foo');
				yourself);
			yourself)
]

{ #category : #'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteTextInsideEnvironmentUsesTemplateInsideEnvironment [

	self
		assertTemplatePath: (Path * 'card' / 'paragraph.mustache')
		writesValue: 'Paragraph in card'
		forNode: ((PREnvironment named: 'card')
			add: (PRParagraph new
				add: (PRText content: 'Foo');
				yourself);
			yourself)
]
