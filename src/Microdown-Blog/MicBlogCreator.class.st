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

{ #category : 'as yet unclassified' }
MicBlogCreator class >> createFrom: source to: target [

	| tmp1 |
	(source fileSystem store isKindOf: WindowsStore) ifTrue: [
		source fileSystem store currentDisk ].
	(target fileSystem store isKindOf: WindowsStore) ifTrue: [
		target fileSystem store currentDisk ].
	tmp1 := self new.
	tmp1
		sourceDirectory: source;
		targetDirectory: target.
	tmp1 createAllHtmlFile
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
		                       MicSingleSummarizer new summarize: each ].
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

	self
		write: visitor
		to: targetDirectory
		named:
		(aFileReference fullName withoutPrefix:
			 self targetDirectory fullName)
]

{ #category : 'rendering' }
MicBlogCreator >> createHtmlGroupFile: aMicRoot at: aMonth [

	| visitor  |
	self rootAssembly: aMicRoot.
	visitor := (MicHTMLVisitor new visit: aMicRoot) first.
	self
		write: visitor
		to: targetDirectory
		named: '_monthBlog/' ,aMonth name , '_' , aMonth year asString , '.html'
]

{ #category : 'rendering' }
MicBlogCreator >> createHtmlSummarize: aMicRoot [

	| visitor |
	self rootAssembly: aMicRoot.

	visitor := (MicHTMLVisitor new visit: aMicRoot) first.

	self write: visitor to: targetDirectory named: 'index.html'
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

{ #category : 'initialization' }
MicBlogCreator >> initialize [

	super initialize.
	self cssFrameworkName: 'Axist'.
	sum := MicListSummarizer new.
]

{ #category : 'rendering' }
MicBlogCreator >> initializeMonthList: listOfSingleSummarize [

	| summar dateListCopy |

	dateList := MicMonthListCreator new generateDateListSince2014.
	dateListCopy := dateList copy.

	dateListCopy do: [ :each |
		summar := sum group: listOfSingleSummarize byDate: each.
		summar isEmpty ifTrue: [ dateList := dateList copyWithout: each ] ].
	
	dateListCopy := dateList copy.
	
	dateList := MicMonthListCreator new
		            generateMicListBlockOfLinkDateWith: dateList
		            To: targetDirectory.

	dateListCopy do: [ :each |
		summar := sum group: listOfSingleSummarize byDate: each.
		summar := sum summarize: summar.
		self createHtmlGroupFile: summar at: each ]
]

{ #category : 'css' }
MicBlogCreator >> levelPathDifferenceForCSS: aStringPath [

	| result string |
	string := aStringPath copyReplaceAll: '\' with: '/'.

	result := '' writeStream.

	2 to: (string substrings: '/') size do: [ :each |
	result nextPutAll: '../' ].

	result close.

	^ result contents
]

{ #category : 'rendering' }
MicBlogCreator >> renameMarkdownIntoHtmlFile: aFileReference [

	| newPath |

	newPath := aFileReference fullName copyReplaceAll: '.md' with: '.html'.
	
	aFileReference renameTo: newPath
]

{ #category : 'rendering' }
MicBlogCreator >> rootAssembly: aMicRoot [

	aMicRoot addChild: dateList copy.
	^ aMicRoot
]

{ #category : 'accessing' }
MicBlogCreator >> sourceDirectory [

	^ sourceDirectory
]

{ #category : 'accessing' }
MicBlogCreator >> sourceDirectory: aFileReference [

	sourceDirectory := aFileReference
]

{ #category : 'accessing' }
MicBlogCreator >> targetDirectory [

	^ targetDirectory
]

{ #category : 'accessing' }
MicBlogCreator >> targetDirectory: aFileReference [

	targetDirectory := aFileReference.

	sum targetDirectory: targetDirectory
]

{ #category : 'rendering' }
MicBlogCreator >> write: aMicHTMLVisitor to: aPath named: aName [

	| htmlDocument fileName cssFramework |
	fileName := aName withoutPrefix: '/'.
	fileName := fileName withoutPrefix: '\'.

	cssFramework := MicCSSProvider forCSSNamed: cssFrameworkName.
	cssFramework basePath:
		(self levelPathDifferenceForCSS: fileName) , 'css/'.

	htmlDocument := MicHTMLDocument new.
	htmlDocument configuration: aMicHTMLVisitor configuration.
	htmlDocument configuration document: htmlDocument.
	htmlDocument
		setCharSetUTF8;
		addCSS: cssFramework;
		destinationPath: aPath.
	^ htmlDocument
		  fileName: fileName;
		  writeDocument: aMicHTMLVisitor contents;
		  contents
]
