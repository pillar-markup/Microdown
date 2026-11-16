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

	textDocument templateDirectory ensureCreateDirectory.
	textDocument templateDirectory / MicTemplatedWriter rootTemplateFileName writeStreamDo: [ :s | s << self rootContents ].

	#( #header #bold #italic #figure #externalLink #environment #paragraph #commentedLine #unorderedList #orderedList #listItem
	   #monospace #codeBlock #horizontalLine #anchorReference ) do: [ :each |
			| fileNameSelector contentsSelector |
			fileNameSelector := (String streamContents: [ :s | s << each << 'TemplateFileName' ]) asSymbol.
			contentsSelector := (String streamContents: [ :s | s << each << 'Contents' ]) asSymbol.
			textDocument templateDirectory / (MicTemplatedWriter perform: fileNameSelector) writeStreamDo: [ :s |
				s << (self perform: contentsSelector) ] ]
]

{ #category : 'contents' }
MicTemplatedWriterTest >> anchorReferenceContents [

	^ '<a>*
{{{contents}}}
*</a>'
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

	self assert: (textDocument templateDirectory resolve: templatePath) exists.
	self assertWritingNode: node writes: contents
]

{ #category : 'helpers' }
MicTemplatedWriterTest >> assertWritingNode: node writes: contents [

	| result |
	result := textDocument writer write: node.

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
MicTemplatedWriterTest >> commentedLineContents [

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
MicTemplatedWriterTest >> defaultAnnotatedParagraphContents [

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
MicTemplatedWriterTest >> headerContents [

	^ '<h{{{level}}}>{{{contents}}}</h{{{level}}}>'
]

{ #category : 'contents' }
MicTemplatedWriterTest >> horizontalLineContents [

	^  '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-='
]

{ #category : 'contents' }
MicTemplatedWriterTest >> importantContents [

	^ '<b>{{{contents}}}</b>'
	


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
MicTemplatedWriterTest >> monospaceContents [

	^ '<tt>{{{contents}}}</tt>'
]

{ #category : 'contents' }
MicTemplatedWriterTest >> orderedListContents [

	^ '<o>{{{contents}}}</o>'

]

{ #category : 'contents' }
MicTemplatedWriterTest >> paragraphContents [

	^ '<p>{{{contents}}}</p>'
	


]

{ #category : 'contents' }
MicTemplatedWriterTest >> rootContents [

	^ '<header>
{{{contents}}}
</header>'
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

{ #category : 'tests - annotated' }
MicTemplatedWriterTest >> testAnnotatedParagraphUsesTemplateNamedAfterItsLabel [

	self createTemplateFileAt: Path * 'important.mustache' withContents: '<b>{{{label}}}</b>{{{contents}}}'.
	self
		assertWritingNode: (Microdown parse: '!!important this is important') children first
		writes: '<b>important</b>this is important'
]

{ #category : 'tests - annotated' }
MicTemplatedWriterTest >> testAnnotatedParagraphWithoutLabelTemplateUsesDefaultTemplate [
	"An unknown label such as Tintin becomes note (see MicAnnotatedParagraphBlock>>verifyLabel), and there is no note template."

	self
		createTemplateFileAt: Path * MicTemplatedWriter defaultAnnotatedParagraphTemplateFileName
		withContents: '<i>{{{label}}}</i>{{{contents}}}'.
	self assertWritingNode: (Microdown parse: '!!Tintin this is important') children first writes: '<i>note</i>this is important'
]

{ #category : 'tests-setup' }
MicTemplatedWriterTest >> testDirectory [
	
	self 
		assert: textDocument templateDirectory printString 
		equals:  'memory:///mic/_support/templates/mic'.
	self assert: (textDocument templateDirectory / 'codeBlock.mustache') exists
]

{ #category : 'new tests' }
MicTemplatedWriterTest >> testWriteAnchorReference [
	
	"I do not see why this is not working"
	
	self
		assertTemplate: 'anchorReference.mustache'
		writesValue: '<p><a>*
ThisIsAnchor
*</a></p>'
		forNode: (Microdown parse: '*@ThisIsAnchor@*') children first
]

{ #category : 'tests' }
MicTemplatedWriterTest >> testWriteAnchorReferenceUsesAnchorReferenceTemplate [

	self assertWritingNode: (Microdown parse: '*@ThisReferenceAnchor@*') children first children first writes: '<a>*
ThisReferenceAnchor
*</a>'
]

{ #category : 'tests' }
MicTemplatedWriterTest >> testWriteAnchorUsesAnchorTemplate [

	self createTemplateFileAt: Path * MicTemplatedWriter anchorTemplateFileName withContents: '<a id="{{{label}}}"/>'.
	self assertWritingNode: (Microdown parse: '@anchor') children first writes: '<a id="anchor"/>'
]

{ #category : 'tests - without template' }
MicTemplatedWriterTest >> testWriteAnchorWithoutTemplateIsWrittenByTheDefaultWriter [

	self assertWritingNode: (Microdown parse: '@anchor') children first writes: '@anchor'
]

{ #category : 'tests - without template' }
MicTemplatedWriterTest >> testWriteAnnotatedWithoutTemplateWritesChildrenWithTheirTemplates [

	self assertWritingNode: (Microdown parse: '!!note An **annotated** paragraph') children first writes: '>[!note]
> An <b>
> annotated
> </b> paragraph

'
]

{ #category : 'new tests' }
MicTemplatedWriterTest >> testWriteBoldInParagraphUsesBoldTemplate [

	self
		assertTemplate: MicTemplatedWriter boldTemplateFileName 
		writesValue: '<p><b>
Bar
</b></p>'
		forNode: (Microdown parse: '**Bar**') children first 
]

{ #category : 'new tests' }
MicTemplatedWriterTest >> testWriteBoldUsesBoldTemplate [

	self
		assertTemplate: MicTemplatedWriter boldTemplateFileName 
		writesValue: '<b>
Bar
</b>'
		forNode: (MicBoldFormatBlock new children: { (MicTextBlock new bodyString: 'Bar') }).
	
]

{ #category : 'new tests' }
MicTemplatedWriterTest >> testWriteBoldUsesBoldTemplate2 [

	self
		assertTemplate: MicTemplatedWriter boldTemplateFileName 
		writesValue: '<b>
Bar
</b>'
		forNode: (Microdown parse: '**Bar**') children first children first
]

{ #category : 'tests - without template' }
MicTemplatedWriterTest >> testWriteBoldWithoutTemplateWritesChildrenWithTheirTemplates [

	(textDocument templateDirectory / MicTemplatedWriter boldTemplateFileName) delete.
	self assertWritingNode: (Microdown parse: '**_it_**') children first writes: '<p>**<em>
it
</em>**</p>'
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

{ #category : 'tests - environments' }
MicTemplatedWriterTest >> testWriteEnvironmentUsesArguments [

	self
		createTemplateFileAt: RelativePath * 'card' / MicTemplatedWriter environmentTemplateFileName
		withContents: 'before {{{someArgument}}} after'.
	self
		assertWritingNode: (Microdown parse: '<!card|someArgument=test
Foo
!>') children first
		writes: 'before test after'
]

{ #category : 'tests - environments' }
MicTemplatedWriterTest >> testWriteEnvironmentUsesItsOwnTemplate [

	self
		createTemplateFileAt: RelativePath * 'cards' / MicTemplatedWriter environmentTemplateFileName
		withContents: '[cards]{{{contents}}}'.
	self
		assertWritingNode: (Microdown parse: '<!cards
This is a paragraph
!>') children first
		writes: '[cards]<p>This is a paragraph</p>'
]

{ #category : 'tests - without template' }
MicTemplatedWriterTest >> testWriteEnvironmentWithoutTemplateWritesItsChildren [

	(textDocument templateDirectory / MicTemplatedWriter environmentTemplateFileName) delete.
	self
		assertWritingNode: (Microdown parse: '<!card
Inside
!>') children first
		writes: '
<!card|
<p>Inside</p>
!>'
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

{ #category : 'tests - without template' }
MicTemplatedWriterTest >> testWriteFigureWithoutTemplateWritesCaptionWithItsTemplates [

	(textDocument templateDirectory / MicTemplatedWriter figureTemplateFileName) delete.
	self assertWritingNode: (Microdown parse: '![c **b**](fig.png)') children first children first writes: '
![c <b>
b
</b>](fig.png)'
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

{ #category : 'tests - without template' }
MicTemplatedWriterTest >> testWriteHeaderWithoutTemplateWritesChildrenWithTheirTemplates [

	(textDocument templateDirectory / MicTemplatedWriter headerTemplateFileName) delete.
	self assertWritingNode: (Microdown parse: '# T **b**') children first writes: '
# T <b>
b
</b>
'
]

{ #category : 'new tests' }
MicTemplatedWriterTest >> testWriteHorizontalRuleUsesHorizontalRuleTemplate [

	self
		assertTemplate: MicTemplatedWriter horizontalLineTemplateFileName
		writesValue: '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-='
		forNode: MicHorizontalLineBlock new
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

{ #category : 'tests - without template' }
MicTemplatedWriterTest >> testWriteItalicWithoutTemplateWritesChildrenWithTheirTemplates [

	(textDocument templateDirectory / MicTemplatedWriter italicTemplateFileName) delete.
	self assertWritingNode: (Microdown parse: '_a **b**_') children first children first writes: '_a <b>
b
</b>_'
]

{ #category : 'tests - without template' }
MicTemplatedWriterTest >> testWriteLinkWithoutTemplateWritesChildrenWithTheirTemplates [

	(textDocument templateDirectory / MicTemplatedWriter externalLinkTemplateFileName) delete.
	self assertWritingNode: (Microdown parse: '[**a**](http://pharo.org)') children first writes: '<p>[<b>
a
</b>](http://pharo.org)</p>'
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

{ #category : 'tests - without template' }
MicTemplatedWriterTest >> testWriteListItemWithoutTemplateWritesChildrenWithTheirTemplates [

	(textDocument templateDirectory / MicTemplatedWriter listItemTemplateFileName) delete.
	self
		assertWritingNode: (Microdown parse: '- one
- **two**') children first
		writes: '<u>one
<b>
two
</b>
</u>'
]

{ #category : 'tests - without template' }
MicTemplatedWriterTest >> testWriteMathInlineIsWrittenByTheDefaultWriter [

	self assertWritingNode: (Microdown parse: 'a $x$ b') children first writes: '<p>a $x$ b</p>'
]

{ #category : 'tests - without template' }
MicTemplatedWriterTest >> testWriteMetaDataIsWrittenByTheDefaultWriter [

	self
		assertWritingNode: (Microdown parse: '{
"title" : "T"
}') children first
		writes: '{
"title" : "T"
}'
]

{ #category : 'new tests' }
MicTemplatedWriterTest >> testWriteMonospaceUsesMonospaceTemplate [

	self
		assertTemplate: MicTemplatedWriter monospaceTemplateFileName
		writesValue: '<tt>Bar</tt>'
		forNode: (MicMonospaceFormatBlock new children:{(MicTextBlock new bodyString: 'Bar')})
]

{ #category : 'tests - environments' }
MicTemplatedWriterTest >> testWriteNestedEnvironmentUsesItsOwnTemplate [

	self
		createTemplateFileAt: RelativePath * 'cards' / 'card' / MicTemplatedWriter environmentTemplateFileName
		withContents: '[card in cards]'.
	self
		assertWritingNode: (Microdown parse: '<!cards
<!card
Foo
!>
!>') children first
		writes: '?
[card in cards]
?'
]

{ #category : 'new tests' }
MicTemplatedWriterTest >> testWriteOrderedListUsesOrderedListTemplate [

	self
		assertTemplate: MicTemplatedWriter orderedListTemplateFileName
		writesValue: '<o></o>'
		forNode: MicOrderedListBlock new
]

{ #category : 'tests - without template' }
MicTemplatedWriterTest >> testWriteOrderedListWithoutTemplateWritesItemsWithTheirTemplates [

	(textDocument templateDirectory / MicTemplatedWriter orderedListTemplateFileName) delete.
	self
		assertWritingNode: (Microdown parse: '1. first
2. **second**') children first
		writes: '
1. <li>first</li>
1. <li><b>
second
</b></li>
'
]

{ #category : 'tests - environments' }
MicTemplatedWriterTest >> testWriteParagraphInsideNestedEnvironmentUsesTemplateOfNestedEnvironment [

	self createTemplateFileAt: RelativePath * 'cards' / MicTemplatedWriter environmentTemplateFileName withContents: '{{{contents}}}'.
	self
		createTemplateFileAt: RelativePath * 'cards' / 'card' / MicTemplatedWriter environmentTemplateFileName
		withContents: '{{{contents}}}'.
	self
		createTemplateFileAt: RelativePath * 'cards' / 'card' / MicTemplatedWriter paragraphTemplateFileName
		withContents: '[paragraph in cards/card]'.
	self
		assertWritingNode: (Microdown parse: '<!cards
<!card
With a paragraph
!>
!>') children first
		writes: '[paragraph in cards/card]'
]

{ #category : 'new tests' }
MicTemplatedWriterTest >> testWriteParagraphUsesParagraphTemplate [

	self
		assertTemplate: MicTemplatedWriter paragraphTemplateFileName
		writesValue: '<p>This is a paragraph</p>'
		forNode: (Microdown parse: 'This is a paragraph') children first 
]

{ #category : 'tests - without template' }
MicTemplatedWriterTest >> testWriteParagraphWithoutTemplateWritesChildrenWithTheirTemplates [

	(textDocument templateDirectory / MicTemplatedWriter paragraphTemplateFileName) delete.
	self assertWritingNode: (Microdown parse: 'some **bold**') children first writes: '
some <b>
bold
</b>
'
]

{ #category : 'tests - without template' }
MicTemplatedWriterTest >> testWriteQuoteWithoutTemplateWritesChildrenWithTheirTemplates [

	self assertWritingNode: (Microdown parse: '> a **quote**') children first writes: '>  a <b>
quote
</b>'
]

{ #category : 'new tests' }
MicTemplatedWriterTest >> testWriteRoot [

	self
		assertTemplate: 'root.mustache'
		writesValue: '<header>
<p>This is a paragraph not a root</p>
</header>'
		forNode: (Microdown parse: 'This is a paragraph not a root') 
]

{ #category : 'tests - without template' }
MicTemplatedWriterTest >> testWriteRootWithoutTemplateWritesChildrenWithTheirTemplates [

	(textDocument templateDirectory / MicTemplatedWriter rootTemplateFileName) delete.
	self assertWritingNode: (Microdown parse: 'Plain text') writes: '<p>Plain text</p>'
]

{ #category : 'tests - without template' }
MicTemplatedWriterTest >> testWriteStrikeWithoutTemplateWritesChildrenWithTheirTemplates [

	self assertWritingNode: (Microdown parse: '~a **b**~') children first writes: '<p>~a <b>
b
</b>~</p>'
]

{ #category : 'tests - without template' }
MicTemplatedWriterTest >> testWriteTableIsWrittenByTheDefaultWriter [

	self
		assertWritingNode: (Microdown parse: '| a | b |
| --- | --- |
| 1 | 2 |') children first
		writes: '
| a | b |
| --- | --- |
| 1 | 2 |'
]

{ #category : 'tests - environments' }
MicTemplatedWriterTest >> testWriteTextInsideEnvironmentLooksUpOutsideEnvironment [

	self
		assertWritingNode: (Microdown parse: '<!card
Foo
!>') children first
		writes: '?
<p>Foo</p>
?'
]

{ #category : 'tests - environments' }
MicTemplatedWriterTest >> testWriteTextInsideEnvironmentUsesTemplateInsideEnvironment [

	self
		createTemplateFileAt: RelativePath * 'card' / MicTemplatedWriter paragraphTemplateFileName
		withContents: '[paragraph in card]'.
	self
		assertWritingNode: (Microdown parse: '<!card
Foo
!>') children first
		writes: '?
[paragraph in card]
?'
]

{ #category : 'tests - without template' }
MicTemplatedWriterTest >> testWriteUnorderedListWithoutTemplateWritesItemsWithTheirTemplates [

	(textDocument templateDirectory / MicTemplatedWriter unorderedListTemplateFileName) delete.
	self
		assertWritingNode: (Microdown parse: '- one
- **two**') children first
		writes: '
- <li>one</li>
- <li><b>
two
</b></li>
'
]

{ #category : 'contents' }
MicTemplatedWriterTest >> unorderedListContents [

	^ '<u>{{{contents}}}</u>'

]
