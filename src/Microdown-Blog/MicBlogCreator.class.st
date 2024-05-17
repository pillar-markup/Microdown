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
		  sourceDirectory: source;
		  targetDirectory: target.
	tmp1 createAllHtmlFile.
]

{ #category : 'as yet unclassified' }
MicBlogCreator >> collectAllFile [

	^ (FileReference / sourceDirectory) allChildren select: [ :each | each isFile ]
]

{ #category : 'rendering' }
MicBlogCreator >> createAllHtmlFile [

	| allFile allFileParse sum summar |
	allFile := self collectAllFile.
	allFileParse := allFile collect: [ :each |
		                Microdown parse: each asFileReference contents ].

	allFileParse do: [ :each | self createHtmlFile: each ].

	sum := MicSummarizer new.
	sum targetDirectory: targetDirectory .

	self createHtmlSummarize: (sum summarizeFile: allFile).

	MicCreateMonth generateDateListSince2014 do: [ :each |
		summar := sum group: allFileParse byDate: each.
		summar isNotEmpty ifTrue: [
			summar := sum summarize: summar.
			self createHtmlGroupFile: summar at: each ] ]
]

{ #category : 'rendering' }
MicBlogCreator >> createHtmlFile: aMicRoot [

	| a q date header |
	
	self rootAssembly: aMicRoot.
	
	a := (MicHTMLVisitor new visit: aMicRoot) at: 1.

	date := (aMicRoot children at: 1) body at: #date.
	date := date asDate.
	header := MicSingleSummarizer new firstHeaderBlockOf: aMicRoot.

	q := MicHTMLDocument new.
	q configuration: a configuration.
	q configuration document: q.
	q
		setCharSetUTF8;
		destinationPath:
			targetDirectory , '\' , date year asString , '\' , date monthName
			, '\' , date day asString , '\'.
	^ q
		  fileName: header text , '.html';
		  writeDocument: a contents;
		  contents
]

{ #category : 'rendering' }
MicBlogCreator >> createHtmlGroupFile: aMicRoot at: aDate [

	| a q |
	self rootAssembly: aMicRoot.
	
	a := (MicHTMLVisitor new visit: aMicRoot) at: 1.

	q := MicHTMLDocument new.
	q configuration: a configuration.
	q configuration document: q.
	q
		setCharSetUTF8;
		destinationPath:
			targetDirectory , '\' , aDate year asString , '\' , aDate monthName
			, '\'.
	^ q
		  writeDocument: a contents;
		  contents
]

{ #category : 'rendering' }
MicBlogCreator >> createHtmlSummarize: aMicRoot [

	| a q |
	
	self rootAssembly: aMicRoot.
	
	a := (MicHTMLVisitor new visit: aMicRoot) at: 1.

	q := MicHTMLDocument new.
	q configuration: a configuration.
	q configuration document: q.
	q
		setCharSetUTF8;
		destinationPath: targetDirectory.
	^ q
		  writeDocument: a contents;
		  contents
]

{ #category : 'as yet unclassified' }
MicBlogCreator >> rootAssembly: aMicRoot [

	aMicRoot addChild: (MicCreateMonth generateMicListBlockOfLinkDateTo: targetDirectory).
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
