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

	self collectAllFile do: [ :each | self createHtmlFile: (Microdown parse: each asFileReference contents) ]

	
]

{ #category : 'rendering' }
MicBlogCreator >> createHtmlFile: aMicRoot [

	| a q date header filePath |
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
	filePath := q destinationPath , header text , '.html'.
	^ q
		  fileName: header text , '.html';
		  writeDocument: a contents;
		  contents
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
