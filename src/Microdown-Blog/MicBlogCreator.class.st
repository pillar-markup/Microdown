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
		'targetDirectory'
	],
	#category : 'Microdown-Blog',
	#package : 'Microdown-Blog'
}

{ #category : 'as yet unclassified' }
MicBlogCreator class >> createFrom: source to: target [

	| tmp1 |
	tmp1 := self new.
	tmp1
		sourceDirectory:  source;
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

	sourceDirectory copyAllTo: targetDirectory
]

{ #category : 'rendering' }
MicBlogCreator >> createAllHtmlFile [

	| allFile allFileParse sum summar |
	self copySourceDirectoryInTarget.
	allFile := self collectAllMarkDownFile: targetDirectory.
	allFileParse := allFile collect: [ :each |
		                Microdown parse: each asFileReference contents ].

	1 to: allFile size do: [ :index |
		self
			createHtmlFile: (allFileParse at: index)
			toReplace: (allFile at: index) ].



	sum := MicSummarizer new.
	sum targetDirectory: targetDirectory.

	self createHtmlSummarize: (sum summarizeFile: allFile).

	"JUSQUE LA CA MARCHE"
	targetDirectory fileSystem createDirectory: '/html/_monthBlog'.

	MicMonthListCreator new generateDateListSince2014 do: [ :each |
		summar := sum group: allFileParse byDate: each.
		summar isNotEmpty ifTrue: [
			summar := sum summarize: summar.
			self createHtmlGroupFile: summar at: each ] ]
]

{ #category : 'rendering' }
MicBlogCreator >> createHtmlFile: aMicRoot toReplace: aFileReference [

	| html |
	self rootAssembly: aMicRoot.
	html := (MicHTMLVisitor new visit: aMicRoot) at: 1.
	
	self renameMarkdownIntoHtmlFile: aFileReference.

	aFileReference delete.

	self
		write: html
		to: aFileReference parent
		named: (aFileReference fullName substrings: '/') last
]

{ #category : 'rendering' }
MicBlogCreator >> createHtmlGroupFile: aMicRoot at: aDate [

	| a fileRef |
	self rootAssembly: aMicRoot.

	a := (MicHTMLVisitor new visit: aMicRoot) at: 1.

	fileRef := targetDirectory / '_monthBlog'.

	self write: a to: fileRef named: aDate asString,'.html'
]

{ #category : 'rendering' }
MicBlogCreator >> createHtmlSummarize: aMicRoot [

	| a fileRef |
	self rootAssembly: aMicRoot.

	a := (MicHTMLVisitor new visit: aMicRoot) at: 1.

	fileRef := targetDirectory copyWithPath:
		           targetDirectory fullPath asUrl path.

	self write: a to: fileRef named: 'index.html'
]

{ #category : 'rendering' }
MicBlogCreator >> renameMarkdownIntoHtmlFile: aFileReference [

	| newPath |

	newPath := aFileReference fullName copyReplaceAll: '.md' with: '.html'.
	
	aFileReference renameTo: newPath
]

{ #category : 'as yet unclassified' }
MicBlogCreator >> rootAssembly: aMicRoot [

	aMicRoot addChild: (MicMonthListCreator new generateMicListBlockOfLinkDateTo: targetDirectory).
	^ aMicRoot

	
	
]

{ #category : 'accessing' }
MicBlogCreator >> sourceDirectory [

	^ sourceDirectory
]

{ #category : 'accessing' }
MicBlogCreator >> sourceDirectory: source [

	sourceDirectory := source.
]

{ #category : 'accessing' }
MicBlogCreator >> targetDirectory [

	^ targetDirectory
]

{ #category : 'accessing' }
MicBlogCreator >> targetDirectory: target [

	targetDirectory := target
]

{ #category : 'rendering' }
MicBlogCreator >> write: aMicHTMLVisitor to: aPath named: aName [

	| htmlDocument |
	htmlDocument := MicHTMLDocument new.
	htmlDocument configuration: aMicHTMLVisitor configuration.
	htmlDocument configuration document: htmlDocument.
	htmlDocument
		setCharSetUTF8;
		destinationPath: aPath.
	^ htmlDocument
		  fileName: aName;
		  writeDocument: aMicHTMLVisitor contents;
		  contents
]
