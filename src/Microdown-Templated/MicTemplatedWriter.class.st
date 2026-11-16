"
I am a Microdown writer that lets Mustache templates decide how elements are styled. I wrap a default writer (`MicHTMLVisitor`, `MicTextualMicrodownExporter`). For each element I look for its template file (e.g. `bold.mustache`) in the template directory of my document maker:
- if there is one, I write the children of the element through myself, put their text in the template as `{{{contents}}}` with arguments specific to the element, and let the default writer write the result as is;
- if there is none, the default writer writes the element and gives its children back to me (ping pong), so the templates of nested elements still apply. This is why I'm passed as argument to the visitX:from: messages.

## Life cycle: who creates me and who uses me

1. A document maker (a subclass of `MicAbstractOutputDocumentMaker`, such as `MicTHTMLDocumentMaker` or `MicTextDocumentMaker`) creates me in `MicAbstractOutputDocumentMaker>>writer`, giving me itself as output document and a new default writer from its `basicWriter`.
2. `MicTHTMLDocumentMaker>>write:` sends me `write:` with a document and answers my `contents`.
3. To get the text of the children of an element before templating it, I ask my document maker for a new writer and share my environment stack with it (`contentsOfChildrenOf:`).
4. When I write an environment (`<!card ... !>`), I push it on my environment stack while I write it, then pop it.

## Responsibility:

- I decide for each element whether a template overrides how it is written.
- I find templates in the folder of the current environments (e.g. `cards/card/` inside `<!cards <!card ... !> !>`), then in its parent folders up to the template directory.
- I apply a template with `contents` and the arguments of the element: `level` for a header, `ref` and `caption` for a link or a figure, `label` for an annotated paragraph or an anchor, the arguments of an environment (`<!card|someArgument=test`).

## Collaborators: 

- `MicAbstractOutputDocumentMaker` subclasses: create me, and give me the template directory (`templateDirectory`) and new writers.
- The default writer: writes the elements without template, and the results of templates.
- Mustache (`asMustacheTemplate`): applies the templates.
- `MicEnvironmentBlock`: its name is the folder where templates are looked up first.

## Public API and Key Messages

- `write: aMicElement` writes aMicElement and answers the text.
- `contents` answers the text written so far.
- The template file names are on my class side, e.g. `MicTemplatedWriter boldTemplateFileName` (`bold.mustache`). An environment uses `environment.mustache`; an annotated paragraph uses `<label>.mustache`, then `defaultAnnotatedParagraph.mustache`.

### What a default writer must understand

A default writer is a `MicrodownVisitor` that also implements (see the `templating ping pong` protocol of `MicHTMLVisitor` and `MicTextualMicrodownExporter`):
- `writeTemplatedText: aString`: write the result of a template as is, without escaping or turning line ends into breaks.
- `visitX: anElement from: templated`, for each element that has elements inside: root, paragraph, header, bold, italic, strike, link, figure, quote, annotated paragraph, environment, ordered list, unordered list and list item. It writes the markup of the element itself and sends `templated visitChildrenOf: anElement` for its children.

The elements that have no element inside (code, table, math, metadata, anchor, ...) are written by its usual `visit…` methods.

## Examples

```
MicTemplatedWriter scriptHTMLWithABoldTemplate
```

## Internal Representation

- `outputDocument`: the document maker that created me.
- `defaultWriter`: the writer I delegate to.
- `environmentStack`: the environments I am in, innermost first.

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
MicTemplatedWriter class >> anchorReferenceTemplateFileName [
	
	^ 'anchorReference.mustache'
]

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
MicTemplatedWriter class >> defaultAnnotatedParagraphTemplateFileName [
	
	^ 'defaultAnnotatedParagraph.mustache'
]

{ #category : 'templates' }
MicTemplatedWriter class >> environmentTemplateFileName [
	"ideally we would like to have the name of the environment as template."
	^ 'environment.mustache'
]

{ #category : 'templates' }
MicTemplatedWriter class >> externalLinkTemplateFileName [
	"this is for [](https://....)"

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
MicTemplatedWriter class >> horizontalLineTemplateFileName [
	
	^ 'horizontalLine.mustache'
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

{ #category : 'accessing - templates' }
MicTemplatedWriter class >> rootTemplateFileName [
	^ 'root.mustache'
]

{ #category : 'script' }
MicTemplatedWriter class >> scriptHTMLWithABoldTemplate [
	"Write a Microdown document to HTML where bold text goes through a bold.mustache template kept in a memory file system. The other elements have no template and are written by MicHTMLVisitor; the bold text inside the paragraph still gets its template."

	<example>
	| maker html |
	maker := MicTHTMLDocumentMaker new
		         baseDirectory: FileSystem memory root;
		         yourself.
	maker templateDirectory ensureCreateDirectory.
	maker templateDirectory / self boldTemplateFileName writeStreamDo: [ :stream |
		stream nextPutAll: '<span class="strong">{{{contents}}}</span>' ].
	html := maker write: (Microdown parse: '# Title

Some **bold** text.').
	html inspect.
	^ html
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
MicTemplatedWriter >> anchorReferenceTemplateFileName [

	^ self class anchorReferenceTemplateFileName
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

{ #category : 'writing' }
MicTemplatedWriter >> contentsOfChildrenOf: aMicElement [
	"Answer the text of the children of aMicElement, each written with its own template."

	| subWriter |
	subWriter := outputDocument writer.
	subWriter environmentStack: environmentStack.
	subWriter visitChildrenOf: aMicElement.
	^ subWriter contents
]

{ #category : 'environment' }
MicTemplatedWriter >> currentEnvironmentPath [
	
	^ RelativePath withAll: (environmentStack collect: [:each | each name]) reversed
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
MicTemplatedWriter >> horizontalLineTemplateFileName [

	^ self class horizontalLineTemplateFileName
]

{ #category : 'initialization' }
MicTemplatedWriter >> initialize [

	super initialize.
	environmentStack := OrderedCollection new.
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
MicTemplatedWriter >> rootTemplateFileName [

	^ self class rootTemplateFileName
]

{ #category : 'accessing' }
MicTemplatedWriter >> templateForConfiguration: aConfiguration [
   "Probably used by pillar."
	^ defaultWriter templateForConfiguration: aConfiguration
]

{ #category : 'accessing - templates' }
MicTemplatedWriter >> unorderedListTemplateFileName [

	^ self class unorderedListTemplateFileName
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitAnchor: anAnchor [

	self
		writeRawText: anAnchor label
		withTemplateFileName: self class anchorTemplateFileName
		extraArguments: { ('label' -> anAnchor label) }
		ifAbsent: [ defaultWriter visitAnchor: anAnchor ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitAnchorReference: aReference [
	
	self
		writeRawText: aReference anchorLabel
		withTemplateFileName: self anchorReferenceTemplateFileName
		ifAbsent: [ defaultWriter visitAnchorReference: aReference ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitAnnotated: anAnnotatedParagraph [

	| arguments |
	arguments := { ('label' -> anAnnotatedParagraph label) }.
	self
		write: anAnnotatedParagraph
		withTemplateFileName: anAnnotatedParagraph label , '.mustache'
		extraArguments: arguments
		ifAbsent: [
				self
					write: anAnnotatedParagraph
					withTemplateFileName: self defaultAnnotatedParagraphTemplateFileName
					extraArguments: arguments
					ifAbsent: [ defaultWriter visitAnnotated: anAnnotatedParagraph from: self ] ]
]

{ #category : 'visiting - inline elements' }
MicTemplatedWriter >> visitAnnotation: anAnnotation [

	defaultWriter visitAnnotation: anAnnotation
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitBold: aMicBold [
	
	self
		write: aMicBold
		withTemplateFileName: self boldTemplateFileName
		ifAbsent: [ defaultWriter visitBold: aMicBold from: self ]
]

{ #category : 'visiting - extensions' }
MicTemplatedWriter >> visitCitation: aCitation [

	defaultWriter visitCitation: aCitation
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitCode: aCodeBlock [  
	
	self
		writeRawText: aCodeBlock body
		withTemplateFileName: self codeBlockTemplateFileName
		extraArguments: { 'language' -> defaultWriter class name }
		ifAbsent: [ defaultWriter visitCode: aCodeBlock ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitComment: aCommentBlock [

	self
		writeRawText: aCommentBlock text
		withTemplateFileName: self commentedLineTemplateFileName
		ifAbsent: [ defaultWriter visitComment: aCommentBlock  ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitEnvironment: anEnvironment [
	"The template of an environment gets its arguments, e.g. someArgument in <!card|someArgument=test"

	self pushEnvironment: anEnvironment.
	self
		write: anEnvironment
		withTemplateFileName: self class environmentTemplateFileName
		extraArguments: anEnvironment arguments associations
		ifAbsent: [ defaultWriter visitEnvironment: anEnvironment from: self ].
	self popEnvironment
]

{ #category : 'visiting - inline elements' }
MicTemplatedWriter >> visitFigure: aFigure [

	self
		write: aFigure
		withTemplateFileName: self figureTemplateFileName
		extraArguments: {
				('ref' -> aFigure fileStringWithoutHostFile).
				('caption' -> (aFigure hasChildren
					  ifTrue: [ aFigure caption ]
					  ifFalse: [ '' ])) }
		ifAbsent: [ defaultWriter visitFigure: aFigure from: self ]
]

{ #category : 'visiting - html extensions' }
MicTemplatedWriter >> visitHTMLTagParagraph: anHTMLTagParagraph [

	defaultWriter visitHTMLTagParagraph: anHTMLTagParagraph
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitHeader: aHeader [

	self
		write: aHeader
		withTemplateFileName: self headerTemplateFileName
		extraArguments: { ('level' -> (aHeader level min: 7 max: 1)) }
		ifAbsent: [ defaultWriter visitHeader: aHeader from: self ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitHorizontalLine: aPRHorizontalRule [

	self
		writeRawText: ''
		withTemplateFileName: self horizontalLineTemplateFileName
		ifAbsent: [ defaultWriter visitHorizontalLine: aPRHorizontalRule ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitInputFile: anInputFile [

	defaultWriter visitInputFile: anInputFile
]

{ #category : 'visiting - inline elements' }
MicTemplatedWriter >> visitItalic: aMicItalicFormat [

	self
		write: aMicItalicFormat
		withTemplateFileName: self italicTemplateFileName
		ifAbsent: [ defaultWriter visitItalic: aMicItalicFormat from: self ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitLink: aLink [
	"could be
	 
		externalLinkContents

				^ '<a href={{{ref}}}>{{{caption}}}</a>'
	"
	
	self
		write: aLink
		withTemplateFileName: self externalLinkTemplateFileName
		extraArguments: {
			'ref' -> aLink reference uri.
			'caption' -> aLink caption }
		ifAbsent: [ defaultWriter visitLink: aLink from: self ]
]

{ #category : 'visiting - list' }
MicTemplatedWriter >> visitListItem: aListItem [

	self
		write: aListItem
		withTemplateFileName: self listItemTemplateFileName
		ifAbsent: [ defaultWriter visitListItem: aListItem from: self ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitMath: aMath [

	defaultWriter visitMath: aMath
]

{ #category : 'visiting - inline elements' }
MicTemplatedWriter >> visitMathInline: aMathInline [

	defaultWriter visitMathInline: aMathInline
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitMetaData: aMetaData [
	"Metadata holds no elements, so there is nothing to template inside: the default writer writes it all."

	defaultWriter visitMetaData: aMetaData
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitMonospace: aMicMonospaceFormat [ 
	
	self
		write: aMicMonospaceFormat
		withTemplateFileName: self monospaceTemplateFileName
		ifAbsent: [ defaultWriter visitMonospace: aMicMonospaceFormat ]
]

{ #category : 'visiting - list' }
MicTemplatedWriter >> visitOrderedList: anOrderedList [

	self
		write: anOrderedList
		withTemplateFileName: self orderedListTemplateFileName
		ifAbsent: [ defaultWriter visitOrderedList: anOrderedList from: self ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitParagraph: aParagraph [ 

	self
		write: aParagraph
		withTemplateFileName: self paragraphTemplateFileName
		ifAbsent: [ defaultWriter visitParagraph: aParagraph from: self ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitPreformatted: aPreformatted [

	self
		write: aPreformatted
		withTemplateFileName: self preformattedTemplateFileName
		ifAbsent: [ defaultWriter visitPreformatted: aPreformatted ]
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitQuote: aQuote [

	defaultWriter visitQuote: aQuote from: self
]

{ #category : 'delegating' }
MicTemplatedWriter >> visitRaw: aPRRaw [ 
	
	defaultWriter visitRaw: aPRRaw
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitRoot: aRoot [

	self
		write: aRoot
		withTemplateFileName: self rootTemplateFileName
		extraArguments: {  }
		ifAbsent: [ defaultWriter visitRoot: aRoot from: self  ].

]

{ #category : 'visiting - inline elements' }
MicTemplatedWriter >> visitStrike: aStrike [

	defaultWriter visitStrike: aStrike from: self
]

{ #category : 'visiting' }
MicTemplatedWriter >> visitTable: aTable [
	"The cells of a table are texts, not elements, so there is nothing to template inside: the default writer writes it all."

	defaultWriter visitTable: aTable
]

{ #category : 'delegating' }
MicTemplatedWriter >> visitText: aPRText [ 

	defaultWriter visitText: aPRText
]

{ #category : 'visiting - list' }
MicTemplatedWriter >> visitUnorderedList: anUnorderedList [

	self
		write: anUnorderedList
		withTemplateFileName: self unorderedListTemplateFileName
		ifAbsent: [ defaultWriter visitUnorderedList: anUnorderedList from: self ]
]

{ #category : 'writing' }
MicTemplatedWriter >> write: aMicElement [ 

	aMicElement accept: self.
	^ defaultWriter contents
]

{ #category : 'writing' }
MicTemplatedWriter >> write: aMicElement withTemplateFileName: templateFileName extraArguments: arguments ifAbsent: aBlock [
	"Get templated text of children of aMicElement and template it with its template"

	self
		writeRawText: [ self contentsOfChildrenOf: aMicElement ]
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

	"grab the text, apply the template to it and let the default writer write the result as is"
	templateFile := outputDocument templateDirectory resolve: foundPath / templateFileName.
	result := templateFile asMustacheTemplate value: ({ ('contents' -> aText value) } , arguments) asDictionary.
	defaultWriter writeTemplatedText: result
]

{ #category : 'writing' }
MicTemplatedWriter >> writeRawText: aText withTemplateFileName: templateFileName ifAbsent: aBlock [

	^ self
		writeRawText: aText
		withTemplateFileName: templateFileName
		extraArguments: #()
		ifAbsent: aBlock
]
