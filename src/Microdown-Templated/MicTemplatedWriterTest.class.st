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

	fileSystem / MicTemplatedWriter codeBlockTemplateFileName 
		writeStreamDo: [ :s | s << self codeBlockContents ].
	fileSystem / MicTemplatedWriter boldTemplateFileName 
		writeStreamDo: [ :s | s << self boldContents ].
	fileSystem / MicTemplatedWriter italicTemplateFileName 
		writeStreamDo: [ :s | s << self italicContents ].
	fileSystem / MicTemplatedWriter monospaceTemplateFileName 
		writeStreamDo: [ :s | s << self monoContents ].
	
	fileSystem / MicTemplatedWriter headerTemplateFileName 
		writeStreamDo: [ :s | s << self headerBlockContents ].
	
	fileSystem / MicTemplatedWriter horizontalLineTemplateFileName 
		writeStreamDo: [ :s | s << self horizontalContents ].
	fileSystem / MicTemplatedWriter listItemTemplateFileName 
		writeStreamDo: [ :s | s << self listItemContents ].
	fileSystem / MicTemplatedWriter orderedListTemplateFileName 
		writeStreamDo: [ :s | s << self orderedListItemContents ].
	fileSystem / MicTemplatedWriter unorderedListTemplateFileName 
		writeStreamDo: [ :s | s << self unorderedListItemContents ].
	fileSystem / MicTemplatedWriter figureTemplateFileName 
		writeStreamDo: [ :s | s << self figureContents ].
	fileSystem / MicTemplatedWriter commentedLineTemplateFileName 
		writeStreamDo: [ :s | s << self commentContents ].	
	fileSystem / MicTemplatedWriter externalLinkTemplateFileName 
		writeStreamDo: [ :s | s << self externalLinkContents ].	


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

{ #category : 'running' }
MicTemplatedWriterTest >> commentContents [

	^ '%%% :- {{{contents}}}'
]

{ #category : 'helpers' }
MicTemplatedWriterTest >> createTemplateFileAt: aPath withContents: contents [

	| templateFileReference |
	templateFileReference := textDocument templateDirectory resolve: aPath.
	templateFileReference parent ensureCreateDirectory.
	templateFileReference writeStreamDo: [ :stream | stream nextPutAll: contents ].
]

{ #category : 'running' }
MicTemplatedWriterTest >> externalLinkContents [

	^ '<a href={{{contents}}}>{{{caption}}}</a>'
]

{ #category : 'running' }
MicTemplatedWriterTest >> figureContents [
	"<figure>
  <img
    src=""/shared-assets/images/examples/elephant.jpg""
    alt=""Elephant at sunset"" />
  <figcaption>An elephant at sunset</figcaption>
</figure>"

	^ '<figure><img src={{{ref}}}/><figcaption>{{{caption}}}</figcaption></figure>'
]

{ #category : 'running' }
MicTemplatedWriterTest >> headerBlockContents [

	^ '<h{{{level}}}>{{{contents}}}</h{{{level}}}>'
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
MicTemplatedWriterTest >> monoContents [

	^ '<tt>{{{contents}}}</tt>'
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
	self flag: #enh.
	"We could improve to make sure that the arguments are passed to the template too."
	
	self
		assertTemplate: MicTemplatedWriter codeBlockTemplateFileName
		writesValue: '<code>
^ self
^ self
</code>'
		forNode: (MicCodeBlock new body: '^ self'; yourself)
]

{ #category : 'new tests' }
MicTemplatedWriterTest >> testWriteCommentedLineUsesCommentedLineTemplate [

	self
		assertTemplate: MicTemplatedWriter commentedLineTemplateFileName
		writesValue: '%%% :- some comment'
		forNode: (MicCommentBlock new text: 'some comment')
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
		writesValue: 'http://pharo.org'
		forNode: (Microdown parse: '[Pharo url](http://www.pharo.org)')
]

{ #category : 'new tests' }
MicTemplatedWriterTest >> testWriteFigureUsesFigureTemplate [

	self
		assertTemplate: MicTemplatedWriter figureTemplateFileName
		writesValue: '<figure><img src=files/pharologo.png/><figcaption>This is a caption</figcaption></figure>'
		forNode: (Microdown parse: '![This is a caption](files/pharologo.png)') children first children first
]

{ #category : 'new tests' }
MicTemplatedWriterTest >> testWriteHeaderUsesHeaderTemplate [

	
	self
		assertTemplate: MicTemplatedWriter headerTemplateFileName
		writesValue: '<h2>foo</h2>'
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

{ #category : 'new tests' }
MicTemplatedWriterTest >> testWriteMonospaceUsesMonospaceTemplate [

	self
		assertTemplate: MicTemplatedWriter monospaceTemplateFileName
		writesValue: '<tt>Bar</tt>'
		forNode: (MicMonospaceFormatBlock new children:{(MicTextBlock new bodyString: 'Bar')})
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
