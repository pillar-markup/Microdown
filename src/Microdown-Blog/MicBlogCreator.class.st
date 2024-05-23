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
MicBlogCreator >> collectAllFile [

	^ sourceDirectory allChildren select: [ :each |
		  each isFile ]
]

{ #category : 'rendering' }
MicBlogCreator >> createAllHtmlFile [

	| allFile allFileParse sum summar |
	allFile := self collectAllFile.
	allFileParse := allFile collect: [ :each |
		                Microdown parse: each asFileReference contents ].

	allFileParse do: [ :each | self createHtmlFile: each ].

	sum := MicSummarizer new.
	sum targetDirectory: targetDirectory.

	self createHtmlSummarize: (sum summarizeFile: allFile).

	MicMonthListCreator new generateDateListSince2014 do: [ :each |
		summar := sum group: allFileParse byDate: each.
		summar isNotEmpty ifTrue: [
			summar := sum summarize: summar.
			self createHtmlGroupFile: summar at: each ] ]
]

{ #category : 'rendering' }
MicBlogCreator >> createHtmlFile: aMicRoot [

	| a q date header fileRef|
	self rootAssembly: aMicRoot.

	a := (MicHTMLVisitor new visit: aMicRoot) at: 1.

	date := (aMicRoot children at: 1) body at: #date.
	date := date asDate.
	header := MicSingleSummarizer new firstHeaderBlockOf: aMicRoot.
	
	fileRef := targetDirectory copyWithPath: (targetDirectory fullPath asUrl path , '/' , date year asString
			, '/' , date monthName , '/' , date day asString , '/').

	q := MicHTMLDocument new.
	q configuration: a configuration.
	q configuration document: q.
	q
		setCharSetUTF8;
		destinationPath: fileRef .
	^ q
		  fileName: header text , '.html';
		  writeDocument: a contents;
		  contents
]

{ #category : 'rendering' }
MicBlogCreator >> createHtmlGroupFile: aMicRoot at: aDate [

	| a q fileRef |
	self rootAssembly: aMicRoot.

	a := (MicHTMLVisitor new visit: aMicRoot) at: 1.

	fileRef := targetDirectory copyWithPath:
		           targetDirectory fullPath asUrl path , '/'
		           , aDate year asString , '/' , aDate monthName , '/'.

	q := MicHTMLDocument new.
	q configuration: a configuration.
	q configuration document: q.
	q
		setCharSetUTF8;
		destinationPath: fileRef.
	^ q
		  writeDocument: a contents;
		  contents
]

{ #category : 'rendering' }
MicBlogCreator >> createHtmlSummarize: aMicRoot [

	| a q fileRef |
	self rootAssembly: aMicRoot.

	a := (MicHTMLVisitor new visit: aMicRoot) at: 1.
	
	fileRef := targetDirectory copyWithPath:
		           targetDirectory fullPath asUrl path.

	q := MicHTMLDocument new.
	q configuration: a configuration.
	q configuration document: q.
	q
		setCharSetUTF8;
		destinationPath: fileRef.
	^ q
		  writeDocument: a contents;
		  contents
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
