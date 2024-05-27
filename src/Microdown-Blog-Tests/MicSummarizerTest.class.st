Class {
	#name : 'MicSummarizerTest',
	#superclass : 'TestCase',
	#instVars : [
		'micSummarizer'
	],
	#category : 'Microdown-Blog-Tests',
	#package : 'Microdown-Blog-Tests'
}

{ #category : 'tests' }
MicSummarizerTest >> createListOfFile [

	| q |
	q := Array new: 3.
	q at: 1 put: self generateFilesystemExample1;
	at: 2 put: self generateFilesystemExample2;
	at: 3 put: self generateFilesystemExample3.
	^ q
]

{ #category : 'tests' }
MicSummarizerTest >> createListOfMicRootBlock [

	| q singleSummarizer |
	q := Array new: 3.
	singleSummarizer := MicSingleSummarizer new.
	singleSummarizer targetDirectory: '/html/'.
	q
		at: 1 put: (singleSummarizer summarize:
					 ((Microdown parse: self generateFilesystemExample1 contents)
						  fromFile: self generateFilesystemExample1));
		at: 2 put: (singleSummarizer summarize:
					 ((Microdown parse: self generateFilesystemExample2 contents)
						  fromFile: self generateFilesystemExample2));
		at: 3 put: (singleSummarizer summarize:
					 ((Microdown parse: self generateFilesystemExample3 contents)
						  fromFile: self generateFilesystemExample3)).
	^ q
]

{ #category : 'tests' }
MicSummarizerTest >> generateFilesystemExample1 [

	| file |
	file := FileSystem memory workingDirectory / 'anExample1.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '{
    "date" : "8 January 2019"
}
# A Cool Story

Pharo is cool but _this is_ a superlong _paragraph_ Simple powerful language: No constructors, no types declaration, no interfaces, no primitive types. Yet a powerful and elegant language with a full syntax fitting in one postcard! Pharo is objects and messages all the way down. _Live_, immersive environment: Immediate feedback at any moment of your development: _Developing_, testing, debugging. Even in production environments, you will never be stuck in compiling and deploying steps again!
    

Amazing debugging experience: The Pharo environment includes a debugger unlike anything you''ve seen before. It allows you to step through code, restart the execution of methods, create methods on the fly, and much more!
' ].

	^ file asFileReference
]

{ #category : 'tests' }
MicSummarizerTest >> generateFilesystemExample2 [

	| file |
	file := FileSystem memory workingDirectory / 'anExample2.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '{
    "date" : "22 January 2019"
}
# Pharo is cool

If you are either a beginner or an expert in object-oriented programming, _this MOOC_ will change the way you program with objects: come and learn or rediscover _object-oriented programming_ with Pharo!

Pharo is a pure _object-oriented programming language_ in the tradition of Smalltalk. It offers a unique developing experience in constant interaction with live objects. Pharo is elegant, fun to use and very powerful. It is very easy to learn and enables to understand advanced concept in a natural way. When programming in Pharo, you are immersed in a world of live objects. You have immediate feedback at any moment of your development on objects representing web applications, code itself, graphics, network. More…
' ].

	^ file
]

{ #category : 'tests' }
MicSummarizerTest >> generateFilesystemExample3 [

	| file |
	file := FileSystem memory workingDirectory / 'anExample3.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '{
    "date" : "29 January 2018"
}
# Mooc Pharo

Welcome to the Pharo Mooc (a set of videos, exercises, challenges, and miniprojects). 

The Pharo Mooc is fully dubbed in french and english. It comes with subtitles in Japanese, english, french and spanish. This web site contains all the material of this Mooc in free access.

In addition, in average every 18 months the Mooc is proposed and run on the France Université Numérique platform (Even if the platform is french the mooc is run in both languages). 

When you participate to the mooc you get access to the quizz and the credit validation. 
' ].

	^ file
]

{ #category : 'running' }
MicSummarizerTest >> setUp [

	super setUp.

	"Put here a common initialization logic for tests"
	micSummarizer := MicSummarizer new.
	micSummarizer targetDirectory: '/html/'
]

{ #category : 'tests' }
MicSummarizerTest >> testGroupByDate [

	| summary group |
	summary := self createListOfMicRootBlock.
	group := micSummarizer
		         group: summary
		         byDate: (Date newDay: 1 month: 'January' year: 2019) month.

	self assert: group size equals: 2
]

{ #category : 'tests' }
MicSummarizerTest >> testSummarize [

	| summary |
	summary := micSummarizer summarize: self createListOfMicRootBlock.
	self
		assert: (summary isKindOf: MicRootBlock);
		assert: summary children size equals: 6
]

{ #category : 'tests' }
MicSummarizerTest >> testSummarizeFile [

	| summary |
	summary := micSummarizer summarizeFile: self createListOfFile.
	self
		assert: (summary isKindOf: MicRootBlock);
		assert: summary children size equals: 6
]
