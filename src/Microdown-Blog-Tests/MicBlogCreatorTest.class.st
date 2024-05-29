Class {
	#name : 'MicBlogCreatorTest',
	#superclass : 'TestCase',
	#instVars : [
		'fileSystem',
		'blog'
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

	| ref1 ref2 ref3 ref4 |
	fileSystem := FileSystem memory.
	fileSystem createDirectory: '/html'.
	fileSystem createDirectory: '/source'.
	fileSystem createDirectory: '/source/test'.

	ref1 := fileSystem workingDirectory / 'source/anExample1.md'.
	ref1 writeStreamDo: [ :stream | stream nextPutAll: self fileContent1 ].

	ref2 := fileSystem workingDirectory / 'source/anExample2.md'.
	ref2 writeStreamDo: [ :stream | stream nextPutAll: self fileContent2 ].

	ref3 := fileSystem workingDirectory / 'source/test/anExample3.md'.
	ref3 writeStreamDo: [ :stream | stream nextPutAll: self fileContent3 ].
	
	ref4 := fileSystem workingDirectory / 'source/anExample4.java'.
	ref4 writeStreamDo: [ :stream | stream nextPutAll: 'Du java' ]
]

{ #category : 'as yet unclassified' }
MicBlogCreatorTest >> listOfFile [

	^ (fileSystem / 'source') allFiles
]

{ #category : 'running' }
MicBlogCreatorTest >> setUp [

	super setUp.

	"Put here a common initialization logic for tests"
	self generateArchitecture.
	blog := MicBlogCreator new.
	blog
		targetDirectory: fileSystem / 'html';
		sourceDirectory: fileSystem / 'source'.
]

{ #category : 'tests' }
MicBlogCreatorTest >> testCollectAllMarkDownFile [

	| fileList |
	
	fileList := blog collectAllMarkDownFile: blog sourceDirectory.

	self assert: fileList size equals: 3
]

{ #category : 'tests' }
MicBlogCreatorTest >> testCopySourceDirectoryInTarget [

	blog copySourceDirectoryInTarget.

	self
		assert: (fileSystem / 'html') children size equals: 4;
		assert: (fileSystem / 'html/anExample1.md') exists;
		assert: (fileSystem / 'html/anExample2.md') exists;
		assert: (fileSystem / 'html/test/anExample3.md') exists;
		assert: (fileSystem / 'html/anExample4.java') exists
]

{ #category : 'tests' }
MicBlogCreatorTest >> testCreateAllHtmlFile [

	| allFile |
	blog createAllHtmlFile.

	allFile := (fileSystem / 'html') allFiles.

	self assert: allFile size equals: 7;
		assert: (fileSystem / 'html/index.html') exists;
		assert: (fileSystem / 'html/anExample1.html') exists;
		assert: (fileSystem / 'html/anExample2.html') exists;
		assert: (fileSystem / 'html/test/anExample3.html') exists;
		assert: (fileSystem / 'html/anExample4.java') exists
]

{ #category : 'tests' }
MicBlogCreatorTest >> testCreateFromTo [

	| allFile |
	MicBlogCreator createFrom: fileSystem / 'source' to: fileSystem / 'html'.

	allFile := (fileSystem / 'html') allFiles.

	self assert: allFile size equals: 7
]

{ #category : 'tests' }
MicBlogCreatorTest >> testCreateHtmlEmptyGroupFileAt [

| file |

	blog
		createHtmlEmptyGroupFileAt: (Month year: 2019 month: 'January').
		
		file := fileSystem / 'html/_monthBlog/January 2019.html'.

	self assert:
		file exists;
		assert: (file contents findString: 'No files found') = 0 equals: false.
]

{ #category : 'tests' }
MicBlogCreatorTest >> testCreateHtmlFileToReplace [

	| root file |
	file := self listOfFile at: 1.

	root := Microdown parse: file contents.

	blog createHtmlFile: root toReplace: file.

	self assert: file basename equals: 'anExample1.html'
]

{ #category : 'tests' }
MicBlogCreatorTest >> testCreateHtmlGroupFileAt [

	| root summarizer singleSummarizer allFileParse |
	summarizer := MicSummarizer new.
	summarizer targetDirectory: 'html'.
	
	singleSummarizer := MicSingleSummarizer new.
	
	allFileParse := self listOfFile collect: [ :each | singleSummarizer summarizeFile: each ].

	root := summarizer
		        group: allFileParse
		        byDate: (Month year: 2019 month: 'January').
	root := summarizer summarize: root.

	blog
		createHtmlGroupFile: root
		at: (Month year: 2019 month: 'January').

	self assert:
		(fileSystem / 'html/_monthBlog/January 2019.html') exists
]

{ #category : 'tests' }
MicBlogCreatorTest >> testCreateHtmlSummarize [

	| root summarizer |
	summarizer := MicSummarizer new.
	summarizer targetDirectory: 'html'.
	root := summarizer summarizeFile: self listOfFile.
	blog createHtmlSummarize: root.

	self assert: (fileSystem / 'html/index.html') exists
]

{ #category : 'tests' }
MicBlogCreatorTest >> testRenameMarkdownIntoHtmlFile [

	| fileRef |
	fileRef := MicBlogCreator new renameMarkdownIntoHtmlFile:
		           fileSystem / 'source/anExample1.md'.

	self assert: (fileSystem / 'source/anExample1.html') exists.
	self assert: (fileSystem / 'source/anExample1.md') exists not
]

{ #category : 'tests' }
MicBlogCreatorTest >> testRootAssembly [

	| root file |
	file := self listOfFile at: 1.
	root := Microdown parse: file contents.

	blog rootAssembly: root.

	self assert: root children size equals: 5
]

{ #category : 'tests' }
MicBlogCreatorTest >> testWriteToNamed [

	| root file html| 
	
	file := self listOfFile at: 1.
	root := Microdown parse: file contents.
	html := (MicHTMLVisitor new visit: root) at: 1.
	
	MicBlogCreator new write: html to: fileSystem / 'html'  named: 'test.html'.
	
	self assert: (fileSystem / 'html/test.html') exists
]
