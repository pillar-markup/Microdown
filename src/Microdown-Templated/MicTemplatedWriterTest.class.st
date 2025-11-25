Class {
	#name : 'MicTemplatedWriterTest',
	#superclass : 'TestCase',
	#instVars : [
		'textDocument',
		'fileSystem'
	],
	#category : 'Microdown-Templated',
	#package : 'Microdown-Templated'
}

{ #category : 'running' }
MicTemplatedWriterTest >> addTemplateFiles [

	fileSystem / MicTemplatedWriter codeBlockTemplateFileName writeStreamDo: [ :s | s << self codeBlockContents ].
	fileSystem / MicTemplatedWriter boldTemplateFileName writeStreamDo: [ :s | s << self boldContents ].
	fileSystem / MicTemplatedWriter italicTemplateFileName writeStreamDo: [ :s | s << self italicContents ].
	fileSystem / MicTemplatedWriter headerTemplateFileName writeStreamDo: [ :s | s << self headerBlockContents ].
	
	fileSystem / MicTemplatedWriter horizontalLineTemplateFileName writeStreamDo: [ :s | s << self horizontalContents ].
	fileSystem / MicTemplatedWriter listItemTemplateFileName writeStreamDo: [ :s | s << self listItemContents ].
	fileSystem / MicTemplatedWriter orderedListTemplateFileName writeStreamDo: [ :s | s << self orderedListItemContents ].
	fileSystem / MicTemplatedWriter unorderedListTemplateFileName writeStreamDo: [ :s | s << self unorderedListItemContents ].
]

{ #category : 'helpers' }
MicTemplatedWriterTest >> assertTemplate: template writesValue: value forNode: node [

	self 
		assertTemplatePath: Path * template 
		writesValue: value 
		forNode: node 
]

{ #category : 'helpers' }
MicTemplatedWriterTest >> assertTemplatePath: templatePath writesValue: contents forNode: node [

	self 
		createTemplateFileAt: templatePath 
		withContents: (fileSystem / templatePath basename) contents.
	
	self assertWritingNode: node writes: contents.
]

{ #category : 'helpers' }
MicTemplatedWriterTest >> assertWritingNode: node writes: contents [

	| document result |
	document := MicRootBlock new
		addChild: node;
		yourself.
	result := textDocument writer write: document.

	self assert: result equals: contents
]

{ #category : 'running' }
MicTemplatedWriterTest >> boldContents [

	^ '<b>
{{{contents}}}
</b>'
]

{ #category : 'running' }
MicTemplatedWriterTest >> codeBlockContents [

	^ '<code>
{{{contents}}}
{{{contents}}}
</code>'
]

{ #category : 'helpers' }
MicTemplatedWriterTest >> createTemplateFileAt: aPath withContents: contents [

	| templateFileReference |
	templateFileReference := textDocument templateDirectory resolve: aPath.
	templateFileReference parent ensureCreateDirectory.
	templateFileReference writeStreamDo: [ :stream | stream nextPutAll: contents ].
]

{ #category : 'running' }
MicTemplatedWriterTest >> headerBlockContents [

	^ '<h1>{{{contents}}}</h1>'
]

{ #category : 'running' }
MicTemplatedWriterTest >> horizontalContents [

	^  '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-='
]

{ #category : 'running' }
MicTemplatedWriterTest >> italicContents [

	^ '<em>
{{{contents}}}
</em>'
]

{ #category : 'running' }
MicTemplatedWriterTest >> listItemContents [

	^ '<li>{{{contents}}}</li>'

]

{ #category : 'running' }
MicTemplatedWriterTest >> orderedListItemContents [

	^ '<o>{{{contents}}}</o>'

]

{ #category : 'running' }
MicTemplatedWriterTest >> setUp [

	super setUp.
	fileSystem := FileSystem memory.
	textDocument := MicTextDocumentMaker new
				baseDirectory: fileSystem;
				yourself.
	self addTemplateFiles.
]

{ #category : 'tests-setup' }
MicTemplatedWriterTest >> testDirectory [
	
	self flag: #comeBack.
	"it sucks but I'm always lost in file API"
	self 
		assert: textDocument templateDirectory printString 
		equals: 'memory:///mic'.
	self assert: (fileSystem / 'codeBlock.mustache') exists
]

{ #category : 'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteAnchorUsesDefaultIfNotSpecificIsDefinedTemplate [

	self
		assertTemplate: MicTemplatedWriter defaultAnnotatedParagraphTemplateFileName
		writesValue: 'annotated paragraph'
		forNode: (PRAnnotatedParagraph withAll: #() annotation: 'todo')
]

{ #category : 'new tests' }
MicTemplatedWriterTest >> testWriteBoldUsesBoldTemplate [

	self
		assertTemplate: MicTemplatedWriter boldTemplateFileName 
		writesValue: '<b>
Bar
</b>'
		forNode: (MicBoldFormatBlock new children:
				 { (MicTextBlock new bodyString: 'Bar') })
]

{ #category : 'new tests' }
MicTemplatedWriterTest >> testWriteCodeBlockUsesCodeBlockTemplate [

	self
		assertTemplate: MicTemplatedWriter codeBlockTemplateFileName
		writesValue: '<code>
^ self
^ self
</code>'
		forNode: (MicCodeBlock new body: '^ self'; yourself)
]

{ #category : 'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteCommentedLineUsesCommentedLineTemplate [

	self
		assertTemplate: MicTemplatedWriter commentedLineTemplateFileName
		writesValue: 'commented line'
		forNode: (PRCommentedLine content: 'some comment')
]

{ #category : 'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteEmptyParagraphsUsesEmptyParagraphTemplate [

	self
		assertTemplate: MicTemplatedWriter emptyParagraphTemplateFileName
		writesValue: 'emptyParagraph'
		forNode: PREmptyParagraph new
]

{ #category : 'tests-templatefiles' }
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

{ #category : 'tests-templatefiles' }
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

{ #category : 'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteExternalLinkUsesExternalLinkTemplate [

	self
		assertTemplate: MicTemplatedWriter externalLinkTemplateFileName
		writesValue: 'external link'
		forNode: (PRExternalLink new reference: 'http://pharo.org')
]

{ #category : 'tests-setup' }
MicTemplatedWriterTest >> testWriteFigureUsesFigureTemplate [

	self
		assertTemplate: MicTemplatedWriter figureTemplateFileName
		writesValue: 'figure'
		forNode: (MicFigureBlock new reference: 'bla.png')
]

{ #category : 'new tests' }
MicTemplatedWriterTest >> testWriteHeaderUsesHeaderTemplate [

	self
		assertTemplate: MicTemplatedWriter headerTemplateFileName
		writesValue: '<h1>foo</h1>'
		forNode: (MicHeaderBlock new
			level: 2;
			headerElements: {(MicTextBlock new bodyString: 'foo'; yourself)})
]

{ #category : 'new tests' }
MicTemplatedWriterTest >> testWriteHorizontalRuleUsesHorizontalRuleTemplate [

	self
		assertTemplate: MicTemplatedWriter horizontalLineTemplateFileName
		writesValue: '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-='
		forNode: MicHorizontalLineBlock new
]

{ #category : 'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteInternalLinkUsesInternalLinkTemplate [

	self
		assertTemplate: MicTemplatedWriter internalLinkTemplateFileName
		writesValue: 'internal link'
		forNode: (PRInternalLink new reference: 'bla.pillar')
]

{ #category : 'new tests' }
MicTemplatedWriterTest >> testWriteItalicUsesItalicTemplate [

	self
		assertTemplate: MicTemplatedWriter italicTemplateFileName
		writesValue: '<em>
Bar
</em>'
		forNode: (MicItalicFormatBlock new 
						children: { (MicTextBlock new bodyString: 'Bar') };
						yourself )
]

{ #category : 'new tests' }
MicTemplatedWriterTest >> testWriteListItemUsesListItemTemplate [

	self
		assertTemplate: MicTemplatedWriter listItemTemplateFileName
		writesValue: '<li></li>'
		forNode: MicListItemBlock new
]

{ #category : 'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteMailLinkUsesMailLinkTemplate [

	self
		assertTemplate: MicTemplatedWriter mailLinkTemplateFileName
		writesValue: 'a link'
		forNode: (PRMailLink reference: 'foo@bar.com')
]

{ #category : 'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteMonospaceUsesMonospaceTemplate [

	self
		assertTemplate: MicTemplatedWriter monospaceTemplateFileName
		writesValue: 'monospace'
		forNode: (MicMonospaceFormatBlock new bodyString: 'Bar'; yourself)
]

{ #category : 'tests-templatefiles' }
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

{ #category : 'tests-templatefiles' }
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

{ #category : 'new tests' }
MicTemplatedWriterTest >> testWriteOrderedListUsesOrderedListTemplate [

	self
		assertTemplate: MicTemplatedWriter orderedListTemplateFileName
		writesValue: '<o></o>'
		forNode: MicOrderedListBlock new
]

{ #category : 'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteParagraphUsesParagraphTemplate [

	self
		assertTemplate: MicTemplatedWriter paragraphTemplateFileName
		writesValue: 'unorderedList'
		forNode: PRParagraph new
]

{ #category : 'tests-templatefiles' }
MicTemplatedWriterTest >> testWritePreformattedUsesPreformattedTemplate [

	self
		assertTemplate: MicTemplatedWriter preformattedTemplateFileName
		writesValue: 'preformatted'
		forNode: (PRPreformatted with: (PRText content: 'Bar'))
]

{ #category : 'tests-templatefiles' }
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

{ #category : 'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteTextInsideEnvironmentUsesTemplateInsideEnvironment [

	self
		assertTemplatePath: (Path * 'card' / 'paragraph.mustache')
		writesValue: 'Paragraph in card'
		forNode: ((MicEnvironmentBlock named: 'card')
			add: (MicParagraphBlock new
				add: (MicTextBlock content: 'Foo');
				yourself);
			yourself)
]

{ #category : 'running' }
MicTemplatedWriterTest >> unorderedListItemContents [

	^ '<u>{{{contents}}}</u>'

]
