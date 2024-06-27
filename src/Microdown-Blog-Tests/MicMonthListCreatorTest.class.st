Class {
	#name : 'MicMonthListCreatorTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Blog-Tests',
	#package : 'Microdown-Blog-Tests'
}

{ #category : 'tests' }
MicMonthListCreatorTest >> numberOfMonthSince2014 [ 

	^ Date today year - 2014 * 12 + Date today month index
]

{ #category : 'tests' }
MicMonthListCreatorTest >> testGenerateDateListSince2014 [

	| dateList |

	dateList := MicMonthListCreator new generateDateListSince2014.
	
	self assert: dateList size equals: (Date today year - 2014)*12 + Date today month index .
	self assert:  dateList first equals: (Date newDay: 1 month: 1 year: 2014) month .
	self assert:  dateList last equals: Date today month .
]

{ #category : 'tests' }
MicMonthListCreatorTest >> testGenerateMicListBlockOfLinkDateTo [

	| root fileSystem dateList |
	fileSystem := FileSystem memory.
	fileSystem createDirectory: '/html'.

	root := MicMonthListCreator new generateMicListBlockOfLinkDateTo:
		           fileSystem workingDirectory / '/html'.

	self assert: (root isKindOf: MicRootBlock ).
	self
		assert: root children size equals: 2;
		assert: (root children first isKindOf: MicHeaderBlock);
		assert: (root children second isKindOf: MicUnorderedListBlock).

	dateList := root children second.

	self
		assert: dateList children size equals: self numberOfMonthSince2014;
		assert: dateList children first children first plainText
		equals: '[January 2014](/_monthBlog/January_2014.html)';
		assert: dateList children last children first plainText
		equals: '[' , Date today month asString , '](/_monthBlog/'
			, Date today month name , '_' , Date today year asString , '.html)'
]

{ #category : 'tests' }
MicMonthListCreatorTest >> testGenerateMicListBlockOfLinkDateWithTo [

	| dateList fileSystem root |
	fileSystem := FileSystem memory.
	fileSystem createDirectory: '/html'.

	root := MicMonthListCreator new generateMicListBlockOfLinkDateTo:
		           fileSystem workingDirectory / '/html'.

	self
		assert: (root isKindOf: MicRootBlock);
		assert: root children size equals: 2;
		assert: (root children first isKindOf: MicHeaderBlock);
		assert: (root children second isKindOf: MicUnorderedListBlock).

	dateList := root children second.
	self
		assert: dateList children size equals: self numberOfMonthSince2014;
		assert: dateList children first children first plainText
		equals: '[January 2014](/_monthBlog/January_2014.html)';
		assert: dateList children last children first plainText
		equals: '[' , Date today month asString , '](/_monthBlog/'
			, Date today month name , '_' , Date today year asString , '.html)'
]
