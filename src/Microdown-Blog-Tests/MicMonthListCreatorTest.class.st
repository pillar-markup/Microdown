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

	| section fileSystem dateList |
	fileSystem := FileSystem memory.
	fileSystem createDirectory: '/html'.

	section := MicMonthListCreator new
		            generateMicListBlockOfLinkDateTo:
		            fileSystem workingDirectory / '/html'.

	self assert: (section isKindOf: MicSectionBlock).
	self assert: section children size equals: 3;
	assert: (section children first isKindOf: MicHeaderBlock);
	assert: (section children second isKindOf: MicUnorderedListBlock).
	
	dateList := section children second.
	
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

	| dateList fileSystem section |
	fileSystem := FileSystem memory.
	fileSystem createDirectory: '/html'.

	section := MicMonthListCreator new
		            generateMicListBlockOfLinkDateTo:
		            fileSystem workingDirectory / '/html'.

	self assert: (section isKindOf: MicSectionBlock);
	assert: section children size equals: 3;
	assert: (section children first isKindOf: MicHeaderBlock);
	assert: (section children second isKindOf: MicUnorderedListBlock).
	
	dateList := section children second.
	self
		assert: dateList children size equals: self numberOfMonthSince2014;
		assert: dateList children first children first plainText
		equals: '[January 2014](/_monthBlog/January_2014.html)';
		assert: dateList children last children first plainText
		equals: '[' , Date today month asString , '](/_monthBlog/'
			, Date today month name , '_' , Date today year asString , '.html)'
]
