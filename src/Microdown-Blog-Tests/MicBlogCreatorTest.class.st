Class {
	#name : 'MicBlogCreatorTest',
	#superclass : 'TestCase',
	#instVars : [
		'fileSystem'
	],
	#category : 'Microdown-Blog-Tests',
	#package : 'Microdown-Blog-Tests'
}

{ #category : 'as yet unclassified' }
MicBlogCreatorTest >> fileContent1 [

^ '{
    "date" : "8 January 2019"
}
# A Cool Story

Pharo is cool but _this is_ a superlong _paragraph_ Simple powerful language: No constructors, no types declaration, no interfaces, no primitive types. Yet a powerful and elegant language with a full syntax fitting in one postcard! Pharo is objects and messages all the way down. _Live_, immersive environment: Immediate feedback at any moment of your development: _Developing_, testing, debugging. Even in production environments, you will never be stuck in compiling and deploying steps again!
    

Amazing debugging experience: The Pharo environment includes a debugger unlike anything you''ve seen before. It allows you to step through code, restart the execution of methods, create methods on the fly, and much more!
' 
	
]

{ #category : 'as yet unclassified' }
MicBlogCreatorTest >> fileContent2 [

^ '{
    "date" : "22 January 2019"
}
# Pharo is cool

If you are either a beginner or an expert in object-oriented programming, _this MOOC_ will change the way you program with objects: come and learn or rediscover _object-oriented programming_ with Pharo!

Pharo is a pure _object-oriented programming language_ in the tradition of Smalltalk. It offers a unique developing experience in constant interaction with live objects. Pharo is elegant, fun to use and very powerful. It is very easy to learn and enables to understand advanced concept in a natural way. When programming in Pharo, you are immersed in a world of live objects. You have immediate feedback at any moment of your development on objects representing web applications, code itself, graphics, network. More…
'

	
]

{ #category : 'as yet unclassified' }
MicBlogCreatorTest >> fileContent3 [

	^ '{
    "date" : "29 January 2018"
}
# Mooc Pharo

Welcome to the Pharo Mooc (a set of videos, exercises, challenges, and miniprojects). 

The Pharo Mooc is fully dubbed in french and english. It comes with subtitles in Japanese, english, french and spanish. This web site contains all the material of this Mooc in free access.

In addition, in average every 18 months the Mooc is proposed and run on the France Université Numérique platform (Even if the platform is french the mooc is run in both languages). 

When you participate to the mooc you get access to the quizz and the credit validation. 
'
]

{ #category : 'as yet unclassified' }
MicBlogCreatorTest >> generateArchitecture [

	| ref1 ref2 ref3 |
	fileSystem := FileSystem memory.
	fileSystem createDirectory: '/html'.
	fileSystem createDirectory: '/source'.

	ref1 := fileSystem workingDirectory / 'source/anExample1.md'.
	ref1 writeStreamDo: [ :stream | stream nextPutAll: self fileContent1 ].

	ref2 := fileSystem workingDirectory / 'source/anExample2.md'.
	ref2 writeStreamDo: [ :stream | stream nextPutAll: self fileContent2 ].

	ref3 := fileSystem workingDirectory / 'source/anExample3.md'.
	ref3 writeStreamDo: [ :stream | stream nextPutAll: self fileContent3 ].

]

{ #category : 'as yet unclassified' }
MicBlogCreatorTest >> listOfFile [ 

	^ (fileSystem / 'source') allChildren select: [ :each | each isFile ]
]

{ #category : 'running' }
MicBlogCreatorTest >> setUp [

	super setUp.

	"Put here a common initialization logic for tests"
	self generateArchitecture
]

{ #category : 'tests' }
MicBlogCreatorTest >> testCollectAllFile [

	| blog fileList |
	blog := MicBlogCreator new.
	blog sourceDirectory: fileSystem workingDirectory / 'source'.
	fileList := blog collectAllFile.

	self assert: fileList size equals: 3
]

{ #category : 'tests' }
MicBlogCreatorTest >> testCreateAllHtmlFile [

	| blog allFile |
	blog := MicBlogCreator new.
	blog
		targetDirectory: fileSystem / 'html';
		sourceDirectory: fileSystem / 'source';
		createAllHtmlFile.

	allFile := (fileSystem / 'html') allChildren select: [ :each |
		           each isFile ].

	self assert: allFile size equals: 6
]

{ #category : 'tests' }
MicBlogCreatorTest >> testCreateHtmlFile [

	| root blog |
	root := Microdown parse:
		        (fileSystem / 'source/anExample1.md') readStream.
	blog := MicBlogCreator new.
	blog
		targetDirectory: fileSystem / 'html';
		createHtmlFile: root.

	self assert: (fileSystem / 'html/2019/January/8/A Cool Story.html') exists
]

{ #category : 'tests' }
MicBlogCreatorTest >> testCreateHtmlGroupFileAt [

	| root blog summarizer allFileParse |
	summarizer := MicSummarizer new.
	summarizer targetDirectory: 'html'.

	allFileParse := self listOfFile collect: [ :each |
		                Microdown parse: each asFileReference contents ].

	root := summarizer
		        group: allFileParse
		        byDate: (Month year: 2019 month: 'January').
	root := summarizer summarize: root.

	blog := MicBlogCreator new.
	blog
		targetDirectory: fileSystem / 'html';
		createHtmlGroupFile: root at: (Month year: 2019 month: 'January').

	self assert: (fileSystem / 'html/2019/January/index.html') exists
]

{ #category : 'tests' }
MicBlogCreatorTest >> testCreateHtmlSummarize [

	| root blog summarizer |
	summarizer := MicSummarizer new.
	summarizer targetDirectory: 'html'. 
	root := summarizer summarizeFile: self listOfFile.
	blog := MicBlogCreator new.
	blog
		targetDirectory: fileSystem / 'html';
		createHtmlSummarize: root.

	self assert: (fileSystem / 'html/index.html') exists
]
