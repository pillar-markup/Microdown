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
		'dateList',
		'cssFrameworkName',
		'sum'
	],
	#category : 'Microdown-Blog',
	#package : 'Microdown-Blog'
}

{ #category : 'API' }
MicBlogCreator class >> createFrom: sourceReference to: targetReference [
"Create a HTML blog to targetReference directory with the markdown file in sourceDirectory "

	| blogCreator |
	blogCreator := self new.
	blogCreator
		sourceDirectory: sourceReference;
		targetDirectory: targetReference.
	blogCreator createAllHtmlFile
]

{ #category : 'collect' }
MicBlogCreator >> collectAllMarkDownFile: aFileReference [

	^ aFileReference allFiles select: [ :each |
		  each fullName endsWith: '.md' ]
]

{ #category : 'collect' }
MicBlogCreator >> collectAndParseAllMarkdownFile [

"Collect all markdown file from targetDirectory and parse them with Microdown parser"

	| allFile allFileParse |
	allFile := self collectAllMarkDownFile: targetDirectory.
	allFileParse := allFile collect: [ :each |
		                (Microdown parse: each asFileReference contents)
			                fromFile: each ].
	^ allFileParse
]

{ #category : 'copying' }
MicBlogCreator >> copySourceDirectoryInTarget [

"delete all files in target Directory and copi all file of source directory into th target directory"

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
			                       summarize: each ].
	self sortSingleSummarizedDocuments: listOfSingleSummary.
	self initializeMonthList: listOfSingleSummary.

	"transform all markdown file into html file"
	allFileParse do: [ :each |
		self createHtmlFile: each toReplace: each fromFile ].

	self createHtmlSummarize: (sum summarize: listOfSingleSummary)
]

{ #category : 'rendering' }
MicBlogCreator >> createHtmlFile: aMicRoot toReplace: aFileReference [

	| visitor |
	self rootAssembly: aMicRoot.

	visitor := (MicHTMLVisitor new visit: aMicRoot) first.

	self renameMarkdownIntoHtmlFile: aFileReference.

	aFileReference delete.

	self write: visitor to: (aFileReference fullName withoutPrefix:
			 self targetDirectory fullName , '/') asFileReference
]

{ #category : 'rendering' }
MicBlogCreator >> createHtmlGroupFile: aMicRoot at: aMonth [

	| visitor |
	self rootAssembly: aMicRoot.
	visitor := (MicHTMLVisitor new visit: aMicRoot) first.
	self
		write: visitor
		to: '_monthBlog' asFileReference / (aMonth name , '_'
			, aMonth year asString , '.html')
]

{ #category : 'rendering' }
MicBlogCreator >> createHtmlSummarize: aMicRoot [

	| visitor |
	self rootAssembly: aMicRoot.

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

"Download the css in cssFrameworkName instance variable in the folder css at root of the blog"
	| cssProvider |
	(targetDirectory / 'css') ensureCreateDirectory.
	cssProvider := MicCSSProvider new.
	cssProvider
		findCssNamed: cssFrameworkName;
		destinationPath: targetDirectory / 'css'.
	cssProvider cssDownloader downloadCSSFramework:
		(cssProvider findCssNamed: cssFrameworkName)
]

{ #category : 'initialization' }
MicBlogCreator >> initialize [

	super initialize.
	self cssFrameworkName: 'Axist'.
	sum := MicListSummarizer new.
]

{ #category : 'rendering' }
MicBlogCreator >> initializeMonthList: singleSummarizedDocuments [
"initialize month list from a list of single summarized documents and create all of month summarize"

	| summar monthList monthListCreator |
	monthListCreator := MicMonthListCreator new.

	monthList := monthListCreator createListOfMonthListFromSummarized:
		             singleSummarizedDocuments.

	dateList := monthListCreator generateMicListBlockOfLinkDateWith:
		            monthList.

	monthList do: [ :each |
		summar := sum group: singleSummarizedDocuments byDate: each.
		summar := sum summarize: summar.
		self createHtmlGroupFile: summar at: each ]
]

{ #category : 'rendering' }
MicBlogCreator >> renameMarkdownIntoHtmlFile: aFileReference [

	| newPath |

	newPath := aFileReference fullName copyReplaceAll: '.md' with: '.html'.
	
	aFileReference renameTo: newPath
]

{ #category : 'rendering' }
MicBlogCreator >> rootAssembly: aMicRoot [

"Add to a mic root the list of month list generate by MicMonthListCreator"

	aMicRoot addChild: dateList copy.
	^ aMicRoot
]

{ #category : 'sorting' }
MicBlogCreator >> sortSingleSummarizedDocuments: singleSummarizedDocuments [

"sort a list of single summarized documents from newest to oldest"

	singleSummarizedDocuments sort: [ :each1 :each2 |
		| date1 date2 |
		date1 := each1 children first atKey: #date.
		date1 := Date readFrom: date1 pattern: 'y/m/d'.
		date2 := each2 children first atKey: #date.
		date2 := Date readFrom: date2 pattern: 'y/m/d'.
		date1 > date2 ]
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
	aFileReferenceOrAString ensureDeleteAll.
	aFileReferenceOrAString ensureCreateDirectory.
	sum targetDirectory: targetDirectory
]

{ #category : 'rendering' }
MicBlogCreator >> write: aMicHTMLVisitor to: aFileReference [

"Create a HTML file with the MicHTMLVisitor for contents and a FileReference for the path of the file from the root of the blog"

	| htmlDocument cssFramework |
	cssFramework := MicCSSProvider forCSSNamed: cssFrameworkName.
	cssFramework basePath: '/css/'.

	htmlDocument := MicHTMLDocument new.
	htmlDocument configuration: aMicHTMLVisitor configuration.
	htmlDocument configuration document: htmlDocument.
	htmlDocument
		setCharSetUTF8;
		addCSS: cssFramework;
		destinationPath: targetDirectory.
	^ htmlDocument
		  fileName: aFileReference path pathString;
		  writeDocument: aMicHTMLVisitor contents;
		  contents
]
