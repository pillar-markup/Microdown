Class {
	#name : 'MicMonthListCreatorTest',
	#superclass : 'TestCase',
	#instVars : [
		'monthListCreator',
		'ressources'
	],
	#category : 'Microdown-Blog-Tests',
	#package : 'Microdown-Blog-Tests'
}

{ #category : 'tests' }
MicMonthListCreatorTest >> numberOfMonthSince2014 [ 

	^ Date today year - 2014 * 12 + Date today month index
]

{ #category : 'running' }
MicMonthListCreatorTest >> setUp [
	super setUp.

	"Put here a common initialization logic for tests"
	
	ressources := MicFileTestResources new.
	
	monthListCreator := MicMonthListCreator new.
	monthListCreator root: MicFileTestResources new genericEmptyRootPath
]

{ #category : 'tests' }
MicMonthListCreatorTest >> testCreateListOfMonthListFromSummarized [

	| dateList january2019 january2018 listSummarizerTest|
	listSummarizerTest := MicListSummarizerTest new.
	listSummarizerTest setUp.
	dateList := monthListCreator createListOfMonthListFromSummarized: listSummarizerTest createListOfMicRootBlock.
	
	january2019 := Month year: 2019 month: 1.
	january2018 := Month year: 2018 month: 1.

	self assert: (dateList isKindOf: Set);
	assert: dateList size equals: 2;
	assert: (dateList includes: january2018);
	assert: (dateList includes: january2019)
]

{ #category : 'tests' }
MicMonthListCreatorTest >> testCreateListOfMonthListFromSummarizedAreSet [

	| singleSummarizer summarizedDocument dateList january2019 |
	
	singleSummarizer := MicSingleSummarizer new.
	singleSummarizer targetDirectory: '/html/' asFileReference;
	root: MicFileTestResources new genericEmptyRootPath.
	
	summarizedDocument := (singleSummarizer summarize:
			   ((Microdown parse: ressources generateFilesystemExample1 contents)
				    fromFile: ressources generateFilesystemExample1)).
	dateList := monthListCreator createListOfMonthListFromSummarized: { summarizedDocument copy. summarizedDocument copy. summarizedDocument copy }.

	january2019 := Month year: 2019 month: 1.

	self assert: (dateList isKindOf: Set);
	assert: dateList size equals: 1;
	assert: (dateList includes: january2019)
]

{ #category : 'tests' }
MicMonthListCreatorTest >> testGenerateDateListSince2014 [

	| dateList |

	dateList := monthListCreator generateDateListSince2014.
	
	self assert: dateList size equals: (Date today year - 2014)*12 + Date today month index .
	self assert:  dateList first equals: (Date newDay: 1 month: 1 year: 2014) month .
	self assert:  dateList last equals: Date today month .
]

{ #category : 'tests' }
MicMonthListCreatorTest >> testGenerateMicListBlockOfLinkDate [

	| root fileSystem dateList |
	fileSystem := FileSystem memory.
	fileSystem createDirectory: '/html'.

	root := monthListCreator generateMicListBlockOfLinkDate.

	self assert: (root isKindOf: MicRootBlock).
	self
		assert: root children size equals: 2;
		assert: (root children first isKindOf: MicHeaderBlock);
		assert: (root children second isKindOf: MicUnorderedListBlock).

	dateList := root children second.

	self
		assert: dateList children size equals: self numberOfMonthSince2014;
		assert: dateList children first children first plainText
		equals: '[January 2014](/monthBlog/January_2014.html)';
		assert: dateList children last children first plainText
		equals: '[' , Date today month asString , '](/monthBlog/'
			, Date today month name , '_' , Date today year asString , '.html)'
]

{ #category : 'tests' }
MicMonthListCreatorTest >> testGenerateMicListBlockOfLinkDateWith [

	| dateList fileSystem root |
	fileSystem := FileSystem memory.
	fileSystem createDirectory: '/html'.

	root := monthListCreator generateMicListBlockOfLinkDate.

	self
		assert: (root isKindOf: MicRootBlock);
		assert: root children size equals: 2;
		assert: (root children first isKindOf: MicHeaderBlock);
		assert: (root children second isKindOf: MicUnorderedListBlock).

	dateList := root children second.
	self
		assert: dateList children size equals: self numberOfMonthSince2014;
		assert: dateList children first children first plainText
		equals: '[January 2014](/monthBlog/January_2014.html)';
		assert: dateList children last children first plainText
		equals: '[' , Date today month asString , '](/monthBlog/'
			, Date today month name , '_' , Date today year asString , '.html)'
]

{ #category : 'tests' }
MicMonthListCreatorTest >> testGenerateMicListBlockOfLinkDateWithRootPath [

	| dateList fileSystem root |
	fileSystem := FileSystem memory.
	fileSystem createDirectory: '/html'.
	
	monthListCreator root: ressources genericNonEmptyRootPath.

	root := monthListCreator generateMicListBlockOfLinkDate.

	self
		assert: (root isKindOf: MicRootBlock);
		assert: root children size equals: 2;
		assert: (root children first isKindOf: MicHeaderBlock);
		assert: (root children second isKindOf: MicUnorderedListBlock).

	dateList := root children second.
	self
		assert: dateList children size equals: self numberOfMonthSince2014;
		assert: dateList children first children first plainText
		equals: '[January 2014](', ressources genericNonEmptyRootPath ,'/monthBlog/January_2014.html)';
		assert: dateList children last children first plainText
		equals: '[' , Date today month asString , '](', ressources genericNonEmptyRootPath ,'/monthBlog/'
			, Date today month name , '_' , Date today year asString , '.html)'
]
