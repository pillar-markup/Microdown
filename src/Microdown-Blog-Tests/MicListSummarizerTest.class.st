Class {
	#name : 'MicListSummarizerTest',
	#superclass : 'TestCase',
	#instVars : [
		'micSummarizer',
		'resources',
		'singleSummarizer'
	],
	#category : 'Microdown-Blog-Tests',
	#package : 'Microdown-Blog-Tests'
}

{ #category : 'as yet unclassified' }
MicListSummarizerTest >> createListOfFile [


	^ {
		  resources generateFilesystemExample1.
		  resources generateFilesystemExample2.
		  resources generateFilesystemExample3 }
]

{ #category : 'as yet unclassified' }
MicListSummarizerTest >> createListOfMicRootBlock [
	
	^ {
		  (singleSummarizer summarize:
			   ((Microdown parse: resources generateFilesystemExample1 contents)
				    fromFile: resources generateFilesystemExample1)).
		  (singleSummarizer summarize:
			   ((Microdown parse: resources generateFilesystemExample2 contents)
				    fromFile: resources generateFilesystemExample2)).
		  (singleSummarizer summarize:
			   ((Microdown parse: resources generateFilesystemExample3 contents)
				    fromFile: resources generateFilesystemExample3)) }
]

{ #category : 'as yet unclassified' }
MicListSummarizerTest >> createListOfMicRootBlockWithoutMetadata [

	^ {
		  (singleSummarizer summarize: ((Microdown parse:
				     self generateFilesystemExampleWithoutMetadata1 contents)
				    fromFile: self generateFilesystemExampleWithoutMetadata1)).
		  (singleSummarizer summarize: ((Microdown parse:
				     self generateFilesystemExampleWithoutMetadata2 contents)
				    fromFile: self generateFilesystemExampleWithoutMetadata2)).
		  (singleSummarizer summarize: ((Microdown parse:
				     self generateFilesystemExampleWithoutMetadata3 contents)
				    fromFile: self generateFilesystemExampleWithoutMetadata3)) }
]

{ #category : 'fixture' }
MicListSummarizerTest >> generateFilesystemExample3WithBrokenDate [

	| file |
	file := FileSystem memory workingDirectory / 'anExample3.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '{
    "date" : "20219190199191817161"
}
# Mooc Pharo

Welcome to the Pharo Mooc (a set of videos, exercises, challenges, and miniprojects). 

The Pharo Mooc is fully dubbed in french and english. It comes with subtitles in Japanese, english, french and spanish. This web site contains all the material of this Mooc in free access.

In addition, in average every 18 months the Mooc is proposed and run on the France Université Numérique platform (Even if the platform is french the mooc is run in both languages). 

When you participate to the mooc you get access to the quizz and the credit validation. 
' ].

	^ file
]

{ #category : 'fixture' }
MicListSummarizerTest >> generateFilesystemExampleWithoutMetadata1 [

	| file |
	file := FileSystem memory workingDirectory / 'anExample1.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '# A Cool Story

Pharo is cool but _this is_ a superlong _paragraph_ Simple powerful language: No constructors, no types declaration, no interfaces, no primitive types. Yet a powerful and elegant language with a full syntax fitting in one postcard! Pharo is objects and messages all the way down. _Live_, immersive environment: Immediate feedback at any moment of your development: _Developing_, testing, debugging. Even in production environments, you will never be stuck in compiling and deploying steps again!
    

Amazing debugging experience: The Pharo environment includes a debugger unlike anything you''ve seen before. It allows you to step through code, restart the execution of methods, create methods on the fly, and much more!
' ].

	^ file asFileReference
]

{ #category : 'fixture' }
MicListSummarizerTest >> generateFilesystemExampleWithoutMetadata2 [

	| file |
	file := FileSystem memory workingDirectory / 'anExample2.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '{# Pharo is cool

If you are either a beginner or an expert in object-oriented programming, _this MOOC_ will change the way you program with objects: come and learn or rediscover _object-oriented programming_ with Pharo!

Pharo is a pure _object-oriented programming language_ in the tradition of Smalltalk. It offers a unique developing experience in constant interaction with live objects. Pharo is elegant, fun to use and very powerful. It is very easy to learn and enables to understand advanced concept in a natural way. When programming in Pharo, you are immersed in a world of live objects. You have immediate feedback at any moment of your development on objects representing web applications, code itself, graphics, network. More…
' ].

	^ file
]

{ #category : 'fixture' }
MicListSummarizerTest >> generateFilesystemExampleWithoutMetadata3 [

	| file |
	file := FileSystem memory workingDirectory / 'anExample3.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '# Mooc Pharo

Welcome to the Pharo Mooc (a set of videos, exercises, challenges, and miniprojects). 

The Pharo Mooc is fully dubbed in french and english. It comes with subtitles in Japanese, english, french and spanish. This web site contains all the material of this Mooc in free access.

In addition, in average every 18 months the Mooc is proposed and run on the France Université Numérique platform (Even if the platform is french the mooc is run in both languages). 

When you participate to the mooc you get access to the quizz and the credit validation. 
' ].

	^ file
]

{ #category : 'as yet unclassified' }
MicListSummarizerTest >> setUp [

	super setUp.
	resources := MicFileTestResources new.
	micSummarizer := MicListSummarizer new.
	micSummarizer targetDirectory: '/html/' asFileReference.
	singleSummarizer := MicSingleSummarizer new.
	singleSummarizer targetDirectory: '/html/' asFileReference.
]

{ #category : 'as yet unclassified' }
MicListSummarizerTest >> testAssembleSummarizedDocuments [

	| summary |
	summary := micSummarizer assembleSummarizedDocuments:
		           self createListOfMicRootBlock.
	self
		assert: (summary isKindOf: MicRootBlock);
		assert: summary children size equals: 9
]

{ #category : 'as yet unclassified' }
MicListSummarizerTest >> testContentsOfAssembledListsIsCorrect [

	| root dumper dumper1 dumper2 dumper3 |
	root := MicRealDumper new visit:
		        (micSummarizer assembleSummarizedDocuments:
			         self createListOfMicRootBlock).

	dumper1 := MicRealDumper new visit: resources dumperInput1.
	dumper2 := MicRealDumper new visit: resources dumperInput2.
	dumper3 := MicRealDumper new visit: resources dumperInput3.

	dumper := dumper1 contents , dumper2 contents , dumper3 contents.

	self assert: root contents equals: dumper contents
]

{ #category : 'as yet unclassified' }
MicListSummarizerTest >> testGroupByDate [

	| summarizedDocuments group |
	summarizedDocuments := self createListOfMicRootBlock.
	group := micSummarizer
		         group: summarizedDocuments
		         byDate: (Date newDay: 1 month: 'January' year: 2019) month.

	self assert: group size equals: 2
]

{ #category : 'as yet unclassified' }
MicListSummarizerTest >> testGroupByDateWithoutAnyMetadata [

	| summarizedDocuments group |
	summarizedDocuments := self createListOfMicRootBlockWithoutMetadata.
	group := micSummarizer
		         group: summarizedDocuments
		         byDate: (Date newDay: 1 month: 'January' year: 2019) month.

	self assert: group size equals: 0
]

{ #category : 'as yet unclassified' }
MicListSummarizerTest >> testSummarizeEmptyListOfFile [

	| summary |
	summary := micSummarizer summarizeFile: #().
	self
		assert: (summary isKindOf: MicRootBlock);
		assert: summary children size equals: 0
]

{ #category : 'as yet unclassified' }
MicListSummarizerTest >> testSummarizeEmptyListOfSingleSummarizer [

	| summary |
	summary := micSummarizer assembleSummarizedDocuments: #(  ).
	self
		assert: (summary isKindOf: MicRootBlock);
		assert: summary children size equals: 0
]

{ #category : 'as yet unclassified' }
MicListSummarizerTest >> testSummarizeFile [

	| summary |
	summary := micSummarizer summarizeFile: self createListOfFile.
	self
		assert: (summary isKindOf: MicRootBlock);
		assert: summary children size equals: 9
]
