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

	fileSystem / MicTemplatedWriter anchorReferenceTemplateFileName 
		writeStreamDo: [ :s | s << self anchorContents ].
	
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
	fileSystem / MicTemplatedWriter internalLinkTemplateFileName 
		writeStreamDo: [ :s | s << self internalLinkContents ].	
	fileSystem / MicTemplatedWriter paragraphTemplateFileName
		writeStreamDo: [ :s | s << self paragraphContents ].	
	fileSystem / MicTemplatedWriter environmentTemplateFileName
		writeStreamDo: [ :s | s << self environmentContents ].		
	
	"Pay attention here this is the note label that determines the template name"
	fileSystem / 'important.mustache'
		writeStreamDo: [ :s | s << self annotatedParagraphContents ].		

	fileSystem / MicTemplatedWriter defaultAnnotatedParagraphTemplateFileName 
		writeStreamDo: [ :s | s << self annotatedParagraphContents ].		
]

{ #category : 'contents' }
MicTemplatedWriterTest >> anchorContents [

	^ '<b>*
{{{contents}}}
*</b>'
]

{ #category : 'contents' }
MicTemplatedWriterTest >> annotatedParagraphContents [

	^ '<b>{{{label}}}</b>{{{contents}}}'
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
	self halt.
	result := textDocument writer write: document.

	self assert: result equals: contents
]

{ #category : 'contents' }
MicTemplatedWriterTest >> boldContents [

	^ '<b>
{{{contents}}}
</b>'
]

{ #category : 'contents' }
MicTemplatedWriterTest >> codeBlockContents [

	^ '<code>
{{{contents}}}
{{{contents}}}
</code>'
]

{ #category : 'contents' }
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
MicTemplatedWriterTest >> defaultAnnotatedParagraph [

	^ '<b>{{{label}}}</b>{{{contents}}}'
]

{ #category : 'contents' }
MicTemplatedWriterTest >> environmentContents [
	"Ideally we should be able to have template for each of the different environment based on their names."
	^ '?
{{{contents}}}
?'
]

{ #category : 'contents' }
MicTemplatedWriterTest >> externalLinkContents [

	^ '<a href={{{ref}}}>{{{caption}}}</a>'
]

{ #category : 'contents' }
MicTemplatedWriterTest >> figureContents [
	"<figure>
  <img
    src=""/shared-assets/images/examples/elephant.jpg""
    alt=""Elephant at sunset"" />
  <figcaption>An elephant at sunset</figcaption>
</figure>"

	^ '<figure><img src={{{ref}}}/><figcaption>{{{caption}}}</figcaption></figure>'
]

{ #category : 'contents' }
MicTemplatedWriterTest >> headerBlockContents [

	^ '<h{{{level}}}>{{{contents}}}</h{{{level}}}>'
]

{ #category : 'contents' }
MicTemplatedWriterTest >> horizontalContents [

	^  '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-='
]

{ #category : 'contents' }
MicTemplatedWriterTest >> importantContents [

	^ '<b>{{{contents}}}</b>'
	


]

{ #category : 'contents' }
MicTemplatedWriterTest >> internalLinkContents [

	^ 'See {{{contents}}}'
]

{ #category : 'contents' }
MicTemplatedWriterTest >> italicContents [

	^ '<em>
{{{contents}}}
</em>'
]

{ #category : 'contents' }
MicTemplatedWriterTest >> listItemContents [

	^ '<li>{{{contents}}}</li>'

]

{ #category : 'contents' }
MicTemplatedWriterTest >> monoContents [

	^ '<tt>{{{contents}}}</tt>'
]

{ #category : 'contents' }
MicTemplatedWriterTest >> orderedListItemContents [

	^ '<o>{{{contents}}}</o>'

]

{ #category : 'contents' }
MicTemplatedWriterTest >> paragraphContents [

	^ '<p>{{{contents}}}</p>'
	


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

{ #category : 'new tests' }
MicTemplatedWriterTest >> testAnnotatedParagraphImportant [

	self
		assertTemplate: 'important.mustache'
		writesValue: '<b>important</b>this is important'
		forNode: (Microdown parse: '!!important this is important') children first
]

{ #category : 'new tests' }
MicTemplatedWriterTest >> testAnnotatedParagraphUnsupportedIsThenDefault [
	
	self skip. "To be investigated."
	self
		assertTemplate: 'important.mustache'
		writesValue: '<b>Tintin</b>this is important'
		forNode: (Microdown parse: '!!Tintin this is important') children first
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
MicTemplatedWriterTest >> testWriteAnchorReference [
	self skip.
	"I do not see why this is not working"
	
	self
		assertTemplate: 'anchorReference.mustache'
		writesValue: '<b>
*ThisIsAnchor*
</b>'
		forNode: (Microdown parse: '*@ThisIsAnchor@*') children first
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

{ #category : 'new tests' }
MicTemplatedWriterTest >> testWriteEnvironmentItselfUsesMainTemplate [

	"I do not get why we have extra newlines. But this will be for the next iteration."
	self
		assertTemplatePath: RelativePath * 'cards' / 'environment.mustache'
		writesValue: '?

This is a paragraph

?'
		forNode: (Microdown parse: '<!cards
This is a paragraph
!>') children first
]

{ #category : 'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteEnvironmentUsesArguments [
	self skip.
	self
		createTemplateFileAt: RelativePath * 'card' / 'main.mustache'
		withContents: 'before {{{someArgument}}} after'.

	self
		assertWritingNode: ((PREnvironment named: 'card')
			propertyAt: 'someArgument' put: 'test';
			yourself)
		writes: 'before test after'
]

{ #category : 'new tests' }
MicTemplatedWriterTest >> testWriteExternalLinkUsesExternalLinkTemplate [

	self
		assertTemplate: MicTemplatedWriter externalLinkTemplateFileName
		writesValue: '<a href=https://www.pharo.org/>Pharo url</a>'
		forNode: (Microdown parse: '[Pharo url](https://www.pharo.org)') children first children first
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

{ #category : 'new tests' }
MicTemplatedWriterTest >> testWriteInternalLinkUsesInternalLinkTemplate [

	self skip. 
	"I do not get the difference with bold or other simple ones."
	self 
		assert: (Microdown parse: '*@ThisReferenceAnchor@*)') children first children first bodyString
		equals: 'ThisReferenceAnchor'.
	self
		assertTemplate: MicTemplatedWriter internalLinkTemplateFileName
		writesValue: 'See ThisReferenceAnchor'
		forNode: (Microdown parse: '*@ThisReferenceAnchor@*)') children first children first.
		
	
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

{ #category : 'new tests' }
MicTemplatedWriterTest >> testWriteListItemUsesListItemTemplateWithBody [

	self
		assertTemplate: MicTemplatedWriter listItemTemplateFileName
		writesValue: '<li>this is an item</li>'
		forNode: (MicListItemBlock new 
			addChild: (MicTextBlock new 
				bodyString: 'this is an item'; yourself) ; 
			yourself)
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
	self skip.
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
	self skip.
	self
		createTemplateFileAt: RelativePath * 'cards' / 'main.mustache'
		withContents: '{{{contents}}}'.
	self
		createTemplateFileAt: RelativePath * 'cards' / 'card' / 'main.mustache'
		withContents: '{{{contents}}}'.

	self
		assertTemplatePath: RelativePath * 'cards' / 'card' / 'paragraph.mustache'
		writesValue: 'Paragraph definition in cards/card'
		forNode: (Microdown parse: '<!card
<!card
With a paragraph
!>
!>') children first
]

{ #category : 'new tests' }
MicTemplatedWriterTest >> testWriteOrderedListUsesOrderedListTemplate [

	self
		assertTemplate: MicTemplatedWriter orderedListTemplateFileName
		writesValue: '<o></o>'
		forNode: MicOrderedListBlock new
]

{ #category : 'new tests' }
MicTemplatedWriterTest >> testWriteParagraphUsesParagraphTemplate [

	self
		assertTemplate: MicTemplatedWriter paragraphTemplateFileName
		writesValue: '<p>This is a paragraph</p>'
		forNode: (Microdown parse: 'This is a paragraph') children first 
]

{ #category : 'tests-templatefiles' }
MicTemplatedWriterTest >> testWritePreformattedUsesPreformattedTemplate [
	self skip.
	self
		assertTemplate: MicTemplatedWriter preformattedTemplateFileName
		writesValue: 'preformatted'
		forNode: (PRPreformatted with: (PRText content: 'Bar'))
]

{ #category : 'tests-templatefiles' }
MicTemplatedWriterTest >> testWriteTextInsideEnvironmentLooksUpOutsideEnvironment [
	self skip.
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
	self skip.
	self
		assertTemplatePath: (Path * 'card' / 'paragraph.mustache')
		writesValue: 'Paragraph in card'
		forNode: ((MicEnvironmentBlock named: 'card')
			add: (MicParagraphBlock new
				add: (MicTextBlock content: 'Foo');
				yourself);
			yourself)
]

{ #category : 'contents' }
MicTemplatedWriterTest >> unorderedListItemContents [

	^ '<u>{{{contents}}}</u>'

]
