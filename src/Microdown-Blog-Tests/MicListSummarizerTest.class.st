Class {
	#name : 'MicListSummarizerTest',
	#superclass : 'TestCase',
	#instVars : [
		'micSummarizer'
	],
	#category : 'Microdown-Blog-Tests',
	#package : 'Microdown-Blog-Tests'
}

{ #category : 'fixture' }
MicListSummarizerTest >> createListOfFile [

	^ { self generateFilesystemExample1 .
	 self generateFilesystemExample2 .
	self generateFilesystemExample3}

]

{ #category : 'fixture' }
MicListSummarizerTest >> createListOfMicRootBlock [

	| singleSummarizer |
	singleSummarizer := MicSingleSummarizer new.
	singleSummarizer targetDirectory: '/html/' asFileReference.
	^ { (singleSummarizer summarize:
					 ((Microdown parse: self generateFilesystemExample1 contents)
						  fromFile: self generateFilesystemExample1)) .
		(singleSummarizer summarize:
					 ((Microdown parse: self generateFilesystemExample2 contents)
						  fromFile: self generateFilesystemExample2)) .
		 (singleSummarizer summarize:
					 ((Microdown parse: self generateFilesystemExample3 contents)
						  fromFile: self generateFilesystemExample3)) }
	
]

{ #category : 'fixture' }
MicListSummarizerTest >> createListOfMicRootBlockWithoutMetadata [

	| singleSummarizer |
	singleSummarizer := MicSingleSummarizer new.
	singleSummarizer targetDirectory: '/html/' asFileReference.
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
MicListSummarizerTest >> dumper1 [

	| root |
	root := Microdown parse:
		        '# [A Cool Story](' , '' , '/anExample1.html' , '' , ')'.
	root children add: (Microdown parse: '2019/01/09') children first.
	root children add: (Microdown parse:
			 'Pharo is cool but this is a superlong paragraph Simple powerful language: No constructors, no...')
			children first.

	^ root
]

{ #category : 'fixture' }
MicListSummarizerTest >> dumper2 [

	| root |
	root := Microdown parse:
		        '# [Pharo is cool](' , '' , '/anExample2.html' , '' , ')'.
	root children add:
		(Microdown parse: '2019/01/22') children first.
	root children add: (Microdown parse:
			 'If you are either a beginner or an expert in object-oriented programming, this MOOC will...')
			children first.

	^ root
]

{ #category : 'fixture' }
MicListSummarizerTest >> dumper3 [

	| root |
	root := Microdown parse:
		        '# [Mooc Pharo](' , '' , '/anExample3.html' , '' , ')'.
	root children add:
		(Microdown parse: '2018/01/29') children first.
	root children add: (Microdown parse:
			 'Welcome to the Pharo Mooc (a set of videos, exercises, challenges, and miniprojects).')
			children first.

	^ root
]

{ #category : 'fixture' }
MicListSummarizerTest >> generateFilesystemExample1 [

	| file |
	file := FileSystem memory workingDirectory / 'anExample1.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '{
    "date" : "2019/01/09"
}
# A Cool Story

Pharo is cool but _this is_ a superlong _paragraph_ Simple powerful language: No constructors, no types declaration, no interfaces, no primitive types. Yet a powerful and elegant language with a full syntax fitting in one postcard! Pharo is objects and messages all the way down. _Live_, immersive environment: Immediate feedback at any moment of your development: _Developing_, testing, debugging. Even in production environments, you will never be stuck in compiling and deploying steps again!
    

Amazing debugging experience: The Pharo environment includes a debugger unlike anything you''ve seen before. It allows you to step through code, restart the execution of methods, create methods on the fly, and much more!
' ].

	^ file asFileReference
]

{ #category : 'fixture' }
MicListSummarizerTest >> generateFilesystemExample2 [

	| file |
	file := FileSystem memory workingDirectory / 'anExample2.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '{
    "date" : "2019/01/22"
}
# Pharo is cool

If you are either a beginner or an expert in object-oriented programming, _this MOOC_ will change the way you program with objects: come and learn or rediscover _object-oriented programming_ with Pharo!

Pharo is a pure _object-oriented programming language_ in the tradition of Smalltalk. It offers a unique developing experience in constant interaction with live objects. Pharo is elegant, fun to use and very powerful. It is very easy to learn and enables to understand advanced concept in a natural way. When programming in Pharo, you are immersed in a world of live objects. You have immediate feedback at any moment of your development on objects representing web applications, code itself, graphics, network. More…
' ].

	^ file
]

{ #category : 'fixture' }
MicListSummarizerTest >> generateFilesystemExample3 [

	| file |
	file := FileSystem memory workingDirectory / 'anExample3.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '{
    "date" : "2018/01/29"
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

{ #category : 'running' }
MicListSummarizerTest >> setUp [

	super setUp.
	micSummarizer := MicListSummarizer new.
	micSummarizer targetDirectory: '/html/' asFileReference
]

{ #category : 'tests' }
MicListSummarizerTest >> testAssembleSummarizedDocuments [

	| summary |
	summary := micSummarizer assembleSummarizedDocuments:
		           self createListOfMicRootBlock.
	self
		assert: (summary isKindOf: MicRootBlock);
		assert: summary children size equals: 9
]

{ #category : 'tests' }
MicListSummarizerTest >> testContentsOfAssembledListsIsCorrect [

	| root dumper dumper1 dumper2 dumper3 |
	root := MicRealDumper new visit:
		        (micSummarizer assembleSummarizedDocuments:
			         self createListOfMicRootBlock).

	dumper1 := MicRealDumper new visit: self dumper1.
	dumper2 := MicRealDumper new visit: self dumper2.
	dumper3 := MicRealDumper new visit: self dumper3.

	dumper := dumper1 contents , dumper2 contents , dumper3 contents.

	self assert: root contents equals: dumper contents
]

{ #category : 'tests' }
MicListSummarizerTest >> testGroupByDate [

	| summarizedDocuments group |
	summarizedDocuments := self createListOfMicRootBlock.
	group := micSummarizer
		         group: summarizedDocuments
		         byDate: (Date newDay: 1 month: 'January' year: 2019) month.

	self assert: group size equals: 2
]

{ #category : 'tests' }
MicListSummarizerTest >> testGroupByDateWithoutAnyMetadata [

	| summarizedDocuments group |
	summarizedDocuments := self createListOfMicRootBlockWithoutMetadata.
	group := micSummarizer
		         group: summarizedDocuments
		         byDate: (Date newDay: 1 month: 'January' year: 2019) month.

	self assert: group size equals: 0
]

{ #category : 'tests' }
MicListSummarizerTest >> testSummarizeEmptyListOfFile [

	| summary |
	summary := micSummarizer summarizeFile: #().
	self
		assert: (summary isKindOf: MicRootBlock);
		assert: summary children size equals: 0
]

{ #category : 'tests' }
MicListSummarizerTest >> testSummarizeEmptyListOfSingleSummarizer [

	| summary |
	summary := micSummarizer assembleSummarizedDocuments: #(  ).
	self
		assert: (summary isKindOf: MicRootBlock);
		assert: summary children size equals: 0
]

{ #category : 'tests' }
MicListSummarizerTest >> testSummarizeFile [

	| summary |
	summary := micSummarizer summarizeFile: self createListOfFile.
	self
		assert: (summary isKindOf: MicRootBlock);
		assert: summary children size equals: 9
]
