"
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
		'cssFrameworkName'
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

{ #category : 'as yet unclassified' }
MicBlogCreator >> collectAllMarkDownFile: aFileReference [

	^ aFileReference allFiles select: [ :each |
		  each fullName endsWith: '.md' ]
]

{ #category : 'copying' }
MicBlogCreator >> copySourceDirectoryInTarget [

	targetDirectory deleteAllChildren.

	sourceDirectory copyAllTo: targetDirectory
]

{ #category : 'rendering' }
MicBlogCreator >> createAllHtmlFile [

	| allFile allFileParse sum summar listOfSingleSummarize |
	dateList := MicMonthListCreator new
		            generateMicListBlockOfLinkDateTo: targetDirectory.
	"Copy the source directory in the target directory"
	self copySourceDirectoryInTarget.

	"Download the CSS"
	self downloadCSS.
	
	"Collect and parse all Markdown file of targetDirectory"
	allFile := self collectAllMarkDownFile: targetDirectory.
	allFileParse := allFile collect: [ :each |
		                (Microdown parse: each asFileReference contents)
			                fromFile: each ].
		
	"transform all markdown file into html file"
	allFileParse do: [ :each |
		self createHtmlFile: each toReplace: each fromFile ].
	
	"create summarizer html file"
	sum := MicSummarizer new.
	sum targetDirectory: targetDirectory.
	listOfSingleSummarize := allFileParse collect: [ :each |
		                         MicSingleSummarizer new summarize: each ].
	self createHtmlSummarize: (sum summarize: listOfSingleSummarize).
	
	"Create the directory with all month summarizer in html"
	targetDirectory fileSystem createDirectory:
		targetDirectory fullName , '/_monthBlog'.
		
	MicMonthListCreator new generateDateListSince2014 do: [ :each |
		summar := sum group: listOfSingleSummarize byDate: each.
		summar isNotEmpty
			ifTrue: [
				summar := sum summarize: summar.
				self createHtmlGroupFile: summar at: each ]
			ifFalse: [ self createHtmlEmptyGroupFileAt: each ] ]
]

{ #category : 'rendering' }
MicBlogCreator >> createHtmlEmptyGroupFileAt: aMonth [

	| a fileRef root |
	root := Microdown parse: 'No files found'.
	self rootAssembly: root.

	a := (MicHTMLVisitor new visit: root) at: 1.

	fileRef := targetDirectory / '_monthBlog'.

	self write: a to: fileRef named: aMonth name , '_' , aMonth year asString , '.html'
]

{ #category : 'rendering' }
MicBlogCreator >> createHtmlFile: aMicRoot toReplace: aFileReference [

	| html |
	self rootAssembly: aMicRoot.
	html := (MicHTMLVisitor new visit: aMicRoot) first.
	self renameMarkdownIntoHtmlFile: aFileReference.
	aFileReference delete.
	self 
		write: html
		to: targetDirectory 
		named:
		(aFileReference fullName withoutPrefix:
self targetDirectory fullName)
]

{ #category : 'rendering' }
MicBlogCreator >> createHtmlGroupFile: arg1 at: arg2 [

	| tmp1 tmp2 |
	self rootAssembly: arg1.
	tmp1 := (MicHTMLVisitor new visit: arg1) at: 1.
	tmp2 := targetDirectory / '_monthBlog'.
	self
		write: tmp1
		to: tmp2
		named: arg2 name , '_' , arg2 year asString , '.html'
]

{ #category : 'rendering' }
MicBlogCreator >> createHtmlSummarize: aMicRoot [

	| a |
	self rootAssembly: aMicRoot.

	a := (MicHTMLVisitor new visit: aMicRoot) at: 1.

	self write: a to: targetDirectory named: 'index.html'
]

{ #category : 'as yet unclassified' }
MicBlogCreator >> cssFrameworkName: aString [ 
	
	cssFrameworkName := aString 
]

{ #category : 'accessing' }
MicBlogCreator >> dateList: aDateList [

	dateList := aDateList.
]

{ #category : 'css' }
MicBlogCreator >> downloadCSS [

	| a |
	(targetDirectory / 'css') ensureCreateDirectory.
	a := MicCSSProvider new.
	a
		findCssNamed: cssFrameworkName;
		destinationPath: targetDirectory / 'css'.
	a cssDownloader downloadCSSFramework:
		(MicCSSProvider forCSSNamed: cssFrameworkName)
]

{ #category : 'initialization' }
MicBlogCreator >> initialize [

	super initialize.
	self cssFrameworkName: 'Axist'.
]

{ #category : 'as yet unclassified' }
MicBlogCreator >> levelPathDifferenceForCSS: aStringPath [

	| result string |
	string := aStringPath copyReplaceAll: '\' with: '/'.

	result := ''.

	2 to: (string substrings: '/') size do: [ :each |
	result := result , '../' ].

	^ result
]

{ #category : 'rendering' }
MicBlogCreator >> renameMarkdownIntoHtmlFile: aFileReference [

	| newPath |

	newPath := aFileReference fullName copyReplaceAll: '.md' with: '.html'.
	
	aFileReference renameTo: newPath
]

{ #category : 'as yet unclassified' }
MicBlogCreator >> rootAssembly: aMicRoot [

	aMicRoot addChild: dateList copy.
	^ aMicRoot
]

{ #category : 'accessing' }
MicBlogCreator >> sourceDirectory [

	^ sourceDirectory
]

{ #category : 'accessing' }
MicBlogCreator >> sourceDirectory: arg1 [

	sourceDirectory := arg1
]

{ #category : 'accessing' }
MicBlogCreator >> targetDirectory [

	^ targetDirectory
]

{ #category : 'accessing' }
MicBlogCreator >> targetDirectory: arg1 [

	targetDirectory := arg1
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
		  fileName: aName;
		  writeDocument: aMicHTMLVisitor contents;
		  contents
]
