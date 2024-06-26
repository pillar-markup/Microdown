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

{ #category : 'fixtures' }
MicListSummarizerTest >> createListOfFile [


	^ {
		  resources generateFilesystemExample1.
		  resources generateFilesystemExample2.
		  resources generateFilesystemExample3 }
]

{ #category : 'fixtures' }
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

{ #category : 'fixtures' }
MicListSummarizerTest >> createListOfMicRootBlockWithoutMetadata [

	^ {
		  (singleSummarizer summarize: ((Microdown parse:
				     resources generateFilesystemExampleWithoutMetadata1 contents)
				    fromFile: resources generateFilesystemExampleWithoutMetadata1)).
		  (singleSummarizer summarize: ((Microdown parse:
				     resources generateFilesystemExampleWithoutMetadata2 contents)
				    fromFile: resources generateFilesystemExampleWithoutMetadata2)).
		  (singleSummarizer summarize: ((Microdown parse:
				     resources generateFilesystemExampleWithoutMetadata3 contents)
				    fromFile: resources generateFilesystemExampleWithoutMetadata3)) }
]

{ #category : 'fixtures' }
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

{ #category : 'running' }
MicListSummarizerTest >> setUp [

	super setUp.
	resources := MicFileTestResources new.
	micSummarizer := MicListSummarizer new.
	micSummarizer targetDirectory: '/html/' asFileReference.
	singleSummarizer := MicSingleSummarizer new.
	singleSummarizer targetDirectory: '/html/' asFileReference.
]

{ #category : 'tests' }
MicListSummarizerTest >> testAssembleSummarizedDocuments [

	| summary |
	summary := micSummarizer assembleSummarizedDocuments:
		           self createListOfMicRootBlock.
	self
		assert: (summary isKindOf: MicRootBlock);
		assert: summary children size equals: 9;
		assert:( summary children first isKindOf: MicHeaderBlock);
		assert:( summary children fourth isKindOf: MicHeaderBlock);
		assert:( summary children last isKindOf: MicParagraphBlock)
]

{ #category : 'tests' }
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

{ #category : 'tests' }
MicListSummarizerTest >> testGroupByDate [

	| summarizedDocuments group |
	summarizedDocuments := self createListOfMicRootBlock.
	group := micSummarizer
		         group: summarizedDocuments
		         byDate: (Date newDay: 1 month: 'January' year: 2019) month.

	self assert: group size equals: 2;
	assert: (group first isKindOf: MicRootBlock)
]

{ #category : 'tests' }
MicListSummarizerTest >> testGroupByDateWithoutAnyMetadata [

	| summarizedDocuments group |
	summarizedDocuments := self createListOfMicRootBlockWithoutMetadata.
	group := micSummarizer
		         group: summarizedDocuments
		         byDate: (Date readFrom: MicSingleSummarizer new replacementDate pattern: 'y/m/d') month.
		
	self assert: group size equals: 3;
	assert: (group first isKindOf: MicRootBlock)
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
		assert: summary children size equals: 9;
		assert:( summary children first isKindOf: MicHeaderBlock);
		assert:( summary children fourth isKindOf: MicHeaderBlock);
		assert:( summary children last isKindOf: MicParagraphBlock)
]
