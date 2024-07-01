Class {
	#name : 'MicBlogCreatorTest',
	#superclass : 'TestCase',
	#instVars : [
		'fileSystem',
		'blog',
		'resources'
	],
	#category : 'Microdown-Blog-Tests',
	#package : 'Microdown-Blog-Tests'
}

{ #category : 'initialization' }
MicBlogCreatorTest >> generateArchitecture [

	| ref1 ref2 ref3 ref4 |
	fileSystem := FileSystem memory.
	fileSystem createDirectory: '/html'.
	fileSystem createDirectory: '/source'.
	fileSystem createDirectory: '/source/test'.

	ref1 := fileSystem workingDirectory / 'source' / 'anExample1.md'.
	ref1 writeStreamDo: [ :stream |
		stream nextPutAll: resources generateFilesystemExample1 contents ].

	ref2 := fileSystem workingDirectory / 'source' / 'anExample2.md'.
	ref2 writeStreamDo: [ :stream |
		stream nextPutAll: resources generateFilesystemExample2 contents ].

	ref3 := fileSystem workingDirectory / 'source' / 'test' / 'anExample3.md'.
	ref3 writeStreamDo: [ :stream |
		stream nextPutAll: resources generateFilesystemExample3 contents ].

	ref4 := fileSystem workingDirectory / 'source' / 'anExample4.java'.
	ref4 writeStreamDo: [ :stream | stream nextPutAll: 'Du java' ]
]

{ #category : 'initialization' }
MicBlogCreatorTest >> listOfFile [

	^ (fileSystem / 'source') allFiles
]

{ #category : 'running' }
MicBlogCreatorTest >> setUp [

	super setUp.

	"Put here a common initialization logic for tests"
	resources := MicFileTestResources new.
	self generateArchitecture.
	blog := MicBlogCreator new.
	blog
		targetDirectory: fileSystem / 'html';
		sourceDirectory: fileSystem / 'source';
		dateList:
			(MicMonthListCreator new generateMicListBlockOfLinkDate)
]

{ #category : 'tests' }
MicBlogCreatorTest >> testCollectAllMarkDownFile [

	| fileList |
	
	fileList := blog collectAllMarkDownFile: blog sourceDirectory.

	self assert: fileList size equals: 3
]

{ #category : 'tests' }
MicBlogCreatorTest >> testCollectAndParseAllMarkdownFile [

	| allFileParse |

	blog copySourceDirectoryInTarget.
	allFileParse := blog collectAndParseAllMarkdownFile.

	self assert: allFileParse size equals: 3.
	self assert: (allFileParse first isKindOf: MicRootBlock)
]

{ #category : 'tests' }
MicBlogCreatorTest >> testCopySourceDirectoryInTarget [

	blog copySourceDirectoryInTarget.

	self
		assert: (fileSystem / 'html') children size equals: 4;
		assert: (fileSystem / 'html' / 'anExample1.md') exists;
		assert: (fileSystem / 'html' / 'anExample2.md') exists;
		assert: (fileSystem / 'html' / 'test' / 'anExample3.md') exists;
		assert: (fileSystem / 'html' / 'anExample4.java') exists
]

{ #category : 'tests' }
MicBlogCreatorTest >> testCreateAllHtmlFile [

	| allFile |
	blog createAllHtmlFile.

	allFile := (fileSystem / 'html') allFiles.

	self
		assert: (fileSystem / 'html' / 'index.html') exists;
		assert: (fileSystem / 'html' / 'anExample1.html') exists;
		assert: (fileSystem / 'html' / 'anExample2.html') exists;
		assert: (fileSystem / 'html' / 'test' / 'anExample3.html') exists;
		assert: (fileSystem / 'html' / 'anExample4.java') exists
]

{ #category : 'tests' }
MicBlogCreatorTest >> testCreateFromTo [

	| allFile |
	MicBlogCreator
		createFrom: fileSystem / 'source'
		to: fileSystem / 'html'.

	allFile := (fileSystem / 'html') allFiles.

	self assert: allFile size equals: 8
]

{ #category : 'tests' }
MicBlogCreatorTest >> testCreateHtmlFileToReplace [

	| root file |
	file := fileSystem / 'html' / 'anExample1.md'.

	blog copySourceDirectoryInTarget.

	root := Microdown parse: file contents.

	blog createHtmlFile: root toReplace: file.

	self assert: file fullName equals: '/html/anExample1.html'
]

{ #category : 'tests' }
MicBlogCreatorTest >> testCreateHtmlGroupFileAt [

	| root summarizer singleSummarizer allFileParse |
	summarizer := MicListSummarizer new.
	summarizer targetDirectory: 'html'.

	singleSummarizer := MicSingleSummarizer new.
	singleSummarizer targetDirectory: blog targetDirectory.

	allFileParse := self listOfFile collect: [ :each |
		                singleSummarizer summarizeFile: each ].

	root := summarizer
		        group: allFileParse
		        byDate: (Month year: 2019 month: 'January').
	root := summarizer summarize: root.

	blog
		createHtmlGroupFile: root
		at: (Month year: 2019 month: 'January').

	self assert:
		(fileSystem / 'html' / '_monthBlog' / 'January_2019.html') exists
]

{ #category : 'tests' }
MicBlogCreatorTest >> testCreateHtmlSummarize [

	| root summarizer |
	summarizer := MicListSummarizer new.
	summarizer targetDirectory: blog targetDirectory.
	root := summarizer summarizeFile: self listOfFile.
	blog createHtmlSummarize: root.

	self assert: (fileSystem / 'html' / 'index.html') exists
]

{ #category : 'tests' }
MicBlogCreatorTest >> testDownloadCSS [

	blog cssFrameworkName: 'Axist'.
	blog downloadCSS.

	self assert: (fileSystem / 'html' / 'css') isDirectory.
	self assert: (fileSystem / 'html' / 'css' / 'axist.min.css') exists
]

{ #category : 'tests' }
MicBlogCreatorTest >> testInitializeMonthList [

	| listSingleSummarizer singleSum1 singleSum2 singleSum3 |
	listSingleSummarizer := Array new: 3.

	singleSum1 := MicSingleSummarizer new targetDirectory:
		              blog targetDirectory.
	singleSum1 := singleSum1 summarizeFile:
		              fileSystem / 'source' / 'anExample1.md'.
	singleSum2 := MicSingleSummarizer new targetDirectory:
		              blog targetDirectory.
	singleSum2 := singleSum2 summarizeFile:
		              fileSystem / 'source' / 'anExample2.md'.
	singleSum3 := MicSingleSummarizer new targetDirectory:
		              blog targetDirectory.
	singleSum3 := singleSum3 summarizeFile:
		              fileSystem / 'source' / 'test' / 'anExample3.md'.

	listSingleSummarizer at: 1 put: singleSum1.
	listSingleSummarizer at: 2 put: singleSum2.
	listSingleSummarizer at: 3 put: singleSum3.

	blog initializeMonthList: listSingleSummarizer.

	self assert: (fileSystem / 'html' / '_monthBlog') allFiles size equals: 2
]

{ #category : 'tests' }
MicBlogCreatorTest >> testRenameMarkdownIntoHtmlFile [

	| fileRef |
	fileRef := MicBlogCreator new renameMarkdownIntoHtmlFile:
		           fileSystem / 'source' / 'anExample1.md'.

	self assert: (fileSystem / 'source' / 'anExample1.html') exists.
	self assert: (fileSystem / 'source' / 'anExample1.md') exists not
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
MicBlogCreatorTest >> testSortSingleSummarizedDocuments [

	| listOfSummarizedDocuments summarized1 summarized2 summarized3 singleSummarizer |
	listOfSummarizedDocuments := Array new: 3.
	singleSummarizer := MicSingleSummarizer new.
	singleSummarizer targetDirectory: '/'.

	summarized1 := singleSummarizer summarize:
		               ((Microdown parse:
			                 resources generateFilesystemExample1 contents)
			                fromFile: resources generateFilesystemExample1).
	summarized2 := singleSummarizer summarize:
		               ((Microdown parse:
			                 resources generateFilesystemExample2 contents)
			                fromFile: resources generateFilesystemExample2).
	summarized3 := singleSummarizer summarize:
		               ((Microdown parse:
			                 resources generateFilesystemExample3 contents)
			                fromFile: resources generateFilesystemExample3).

	listOfSummarizedDocuments at: 1 put: summarized2.
	listOfSummarizedDocuments at: 2 put: summarized3.
	listOfSummarizedDocuments at: 3 put: summarized1.

	blog sortSingleSummarizedDocuments: listOfSummarizedDocuments.

	self
		assert: (listOfSummarizedDocuments at: 1) equals: summarized3;
		assert: (listOfSummarizedDocuments at: 2) equals: summarized1;
		assert: (listOfSummarizedDocuments at: 3) equals: summarized2
]

{ #category : 'tests' }
MicBlogCreatorTest >> testWriteTo [

	| root file html |
	file := self listOfFile at: 1.
	root := Microdown parse: file contents.
	html := (MicHTMLVisitor new visit: root) at: 1.

	blog write: html to: 'test.html' asFileReference.

	self assert: (fileSystem / 'html' / 'test.html') exists
]
