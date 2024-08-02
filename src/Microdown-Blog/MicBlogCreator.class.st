"
To debug it on a local machine

```
(ZnServer defaultOn: 9090) start.
ZnServer default
	delegate:
		(ZnStaticFileServerDelegate new
			directory: '/Users/ducasse/Documents/Pharo/images/P12PillarSlide/output/html' asFileReference;
			yourself).
```	



```
MicBlogCreator 
	createFrom: FileSystem workingDirectory / 'source'
	to:  FileSystem workingDirectory / 'html'
```


"
Class {
	#name : 'MicBlogCreator',
	#superclass : 'Object',
	#instVars : [
		'sourceDirectory',
		'targetDirectory',
		'root',
		'dateList',
		'cssFrameworkName',
		'sum',
		'recentPost'
	],
	#category : 'Microdown-Blog',
	#package : 'Microdown-Blog'
}

{ #category : 'API' }
MicBlogCreator class >> createFrom: sourceReference to: targetReference [

	| blogCreator |
	blogCreator := self new.
	blogCreator
		sourceDirectory: sourceReference;
		targetDirectory: targetReference;
		root: ''.
	blogCreator createAllHtmlFile
]

{ #category : 'API' }
MicBlogCreator class >> createFrom: sourceReference to: targetReference withRoot: rootPathString [

	| blogCreator |
	blogCreator := self new.
	blogCreator
		sourceDirectory: sourceReference;
		targetDirectory: targetReference;
		root: rootPathString.
	blogCreator createAllHtmlFile
]

{ #category : 'collect' }
MicBlogCreator >> collectAllMarkDownFile: aFileReference [

	^ aFileReference allFiles select: [ :each |
		  each fullName endsWith: '.md' ]
]

{ #category : 'collect' }
MicBlogCreator >> collectAndParseAllMarkdownFile [

	| allFile allFileParse |
	
	allFile := self collectAllMarkDownFile: targetDirectory.
	allFileParse := allFile collect: [ :each |
		                (Microdown parse: each asFileReference contents)
			                fromFile: each ].
	^ allFileParse
]

{ #category : 'copying' }
MicBlogCreator >> copySourceDirectoryInTarget [

	targetDirectory deleteAllChildren.

	sourceDirectory copyAllTo: targetDirectory
]

{ #category : 'rendering' }
MicBlogCreator >> createAllHtmlFile [

	| allFileParse listOfSingleSummary |
	self copySourceDirectoryInTarget.

	self downloadCSS.

	allFileParse := self collectAndParseAllMarkdownFile.

	"Create _monthListBlog"
	listOfSingleSummary := allFileParse collect: [ :each |
		                       MicSingleSummarizer new
			                       targetDirectory: targetDirectory;
			root: root;
			                       summarize: each ].
	self sortSingleSummarizedDocuments: listOfSingleSummary.
	self generateRecentpost: listOfSingleSummary.
	self initializeMonthList: listOfSingleSummary.

	"transform all markdown file into html file"
	allFileParse do: [ :each |
		self createHtmlFile: each toReplace: each fromFile ].

	self createHtmlSummarize: (sum summarize: listOfSingleSummary)
]

{ #category : 'rendering' }
MicBlogCreator >> createHtmlFile: aMicRoot toReplace: aFileReference [

	| visitor |

	visitor := (MicHTMLVisitor new visit: aMicRoot) first.

	self renameMarkdownIntoHtmlFile: aFileReference.

	aFileReference delete.

	self write: visitor to: (aFileReference fullName withoutPrefix:
			 self targetDirectory fullName , '/') asFileReference
]

{ #category : 'rendering' }
MicBlogCreator >> createHtmlGroupFile: aMicRoot at: aMonth [

	| visitor |
	visitor := (MicHTMLVisitor new visit: aMicRoot) first.
	self
		write: visitor
		to: 'monthBlog' asFileReference / (aMonth name, '_', aMonth year asString , '.html')
]

{ #category : 'rendering' }
MicBlogCreator >> createHtmlSummarize: aMicRoot [

	| visitor |

	visitor := (MicHTMLVisitor new visit: aMicRoot) first.

	self write: visitor to: 'index.html' asFileReference
]

{ #category : 'accessing' }
MicBlogCreator >> cssFrameworkName: aString [ 
	
	cssFrameworkName := aString 
]

{ #category : 'accessing' }
MicBlogCreator >> dateList: aDateList [

	dateList := aDateList.
]

{ #category : 'css' }
MicBlogCreator >> downloadCSS [

	| cssProvider |
	(targetDirectory / 'css') ensureCreateDirectory.
	cssProvider := MicCSSProvider new.
	cssProvider
		findCssNamed: cssFrameworkName;
		destinationPath: targetDirectory / 'css'.
	cssProvider cssDownloader downloadCSSFramework:
		(cssProvider findCssNamed: cssFrameworkName)
]

{ #category : 'rendering' }
MicBlogCreator >> generateRecentpost: listOfMicSingleSummarized [

	| rootBlock selectionSize unorderedList listElement link header |
	
	rootBlock := MicRootBlock new.
	
	selectionSize := 5 min: listOfMicSingleSummarized size.
	
	unorderedList := MicUnorderedListBlock new.
	1 to: selectionSize do: [ :each |
		listElement := MicListItemBlock new.
		link := (((listOfMicSingleSummarized at: each) children at: 2) children at: 1) copy.
		link parent: listElement.
		listElement parent: unorderedList ].
	
	header := MicHeaderBlock new.
	header level: 3.
	(MicTextBlock new bodyString: 'Recent Post') parent: header.
	
	recentPost := rootBlock
		  addChild: header;
		  addChild: unorderedList

	 
]

{ #category : 'initialization' }
MicBlogCreator >> initialize [

	super initialize.
	self cssFrameworkName: 'Axist'.
	sum := MicListSummarizer new.
]

{ #category : 'rendering' }
MicBlogCreator >> initializeMonthList: singleSummarizedDocuments [

	| summar monthList monthListCreator |
	monthListCreator := MicMonthListCreator new.
	monthListCreator root: root.
	
	monthList := monthListCreator createListOfMonthListFromSummarized:
		             singleSummarizedDocuments.

	dateList := monthListCreator
		            generateMicListBlockOfLinkDateWith: monthList.
		
	monthList do: [ :each |
		summar := sum group: singleSummarizedDocuments byDate: each.
		summar := sum summarize: summar.
		self createHtmlGroupFile: summar at: each ]
]

{ #category : 'rendering' }
MicBlogCreator >> mustacheAssembly: htmlString [

	| context |
	
	context := Dictionary new
    at: 'content' put: htmlString;
	 at: 'recentPost' put: (MicHTMLVisitor new visit: recentPost copy) first contents;
	 at: 'archive' put: (MicHTMLVisitor new visit: dateList copy) first contents;
    yourself.
	
	^  (MustacheTemplate on: self mustacheTemplate) value: context
]

{ #category : 'rendering' }
MicBlogCreator >> mustacheTemplate [

	^ '	<h1	><a href="/index.html" title="Weekly news about Pharo" rel="home">Weekly news about Pharo</a></h1>
		<p>Everything you wanted to know about http://www.pharo.org without being forced to read 1000 mails</p>
		<table>
		<tr>
			<td><a href="http://www.mirandabanda.org">Cog Blog</a></td>
			<td><a href="http://clementbera.wordpress.com">Smalltalk, Tips&#8217;n Tricks</a></td>
			<td><a href="http://astares.blogspot.fr">Hitchhiker&#8217;s guide to &#8230;</a></td>
			<td><a href="https://wordpress.com/view/masteringobjects.wordpress.com">Masteringobjects @ PharoDev</a></td>
			<td><a href="https://pharoweekly.wordpress.com/about/">About</a></td>
		</tr>
	</table>
	{{{content}}}
	<table>
		<tr>
			<td>{{{recentPost}}}</td>
			<td>{{{archive}}}</td>
		</tr>
	</table>'
]

{ #category : 'accessing' }
MicBlogCreator >> recentPost [

	^ recentPost
]

{ #category : 'rendering' }
MicBlogCreator >> renameMarkdownIntoHtmlFile: aFileReference [

	| newPath |

	newPath := aFileReference fullName copyReplaceAll: '.md' with: '.html'.
	
	aFileReference renameTo: newPath
]

{ #category : 'accessing' }
MicBlogCreator >> root [

	^ root
]

{ #category : 'accessing' }
MicBlogCreator >> root: aString [

	root := aString.
	sum root: root
]

{ #category : 'sorting' }
MicBlogCreator >> sortSingleSummarizedDocuments: singleSummarizedDocuments [

	singleSummarizedDocuments sort: [ :each1 :each2 |
		| date1 date2 |
		date1 := each1 children first atKey: #date.
		date1 := Date readFrom: date1 pattern: 'y/m/d'.
		date2 := each2 children first atKey: #date.
		date2 := Date readFrom: date2 pattern: 'y/m/d'.
		date1 < date2 ]
]

{ #category : 'accessing' }
MicBlogCreator >> sourceDirectory [

	^ sourceDirectory
]

{ #category : 'accessing' }
MicBlogCreator >> sourceDirectory: aFileReferenceOrAString [

	sourceDirectory := aFileReferenceOrAString asFileReference
]

{ #category : 'accessing' }
MicBlogCreator >> targetDirectory [

	^ targetDirectory
]

{ #category : 'accessing' }
MicBlogCreator >> targetDirectory: aFileReferenceOrAString [

	targetDirectory := aFileReferenceOrAString asFileReference.
	targetDirectory ensureDeleteAll.
	targetDirectory ensureCreateDirectory.
	sum targetDirectory: targetDirectory
]

{ #category : 'rendering' }
MicBlogCreator >> write: aMicHTMLVisitor to: aFileReference [

	| htmlDocument cssFramework htmlContent |
	cssFramework := MicCSSProvider forCSSNamed: cssFrameworkName.
	cssFramework basePath: root, '/css/'.

	htmlDocument := MicHTMLDocument new.
	htmlDocument configuration: aMicHTMLVisitor configuration.
	htmlDocument configuration document: htmlDocument.
	htmlContent := self mustacheAssembly: aMicHTMLVisitor contents.
	htmlDocument
		setCharSetUTF8;
		addCSS: cssFramework;
		destinationPath: targetDirectory. 
	^ htmlDocument
		  fileName: aFileReference path pathString;
		  writeDocument: htmlContent;
		  contents
]
