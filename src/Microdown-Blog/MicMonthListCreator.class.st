"
Create a list of date since january 2014
"
Class {
	#name : 'MicMonthListCreator',
	#superclass : 'MicAbstractBlogCreator',
	#category : 'Microdown-Blog',
	#package : 'Microdown-Blog'
}

{ #category : 'create MonthList' }
MicMonthListCreator >> createListOfMonthListFromSummarized: singleSummarizedDocuments [

"take a list of single summarized documents and create a month list with only the month present in the metadata of each single summarized documents"

	| dateList |
	dateList := singleSummarizedDocuments collect: [ :each |
		            | date |
		            date := each children first atKey: #date.
		            date := Date readFrom: date pattern: 'y/m/d'.
		            date month ].
	^ dateList asSet
]

{ #category : 'create MonthList' }
MicMonthListCreator >> generateDateListSince2014 [

	| date t |
	date := Date newDay: 1 month: 1 year: 2014.

	t := Timespan starting: date month ending: (Date today addMonths: 1) month.

	^ t months
]

{ #category : 'generate' }
MicMonthListCreator >> generateMicListBlockOfLinkDate [

"Generate a MicListBlock of MicLinkBlock with each month from January 2014"

	^ self generateMicListBlockOfLinkDateWith:
		  self generateDateListSince2014
]

{ #category : 'generate' }
MicMonthListCreator >> generateMicListBlockOfLinkDateWith: aMonthList [

"Generate a MicListBlock of MicLinkBlock from each month in the month list parameter"

	| root link listElement |
	root := MicUnorderedListBlock new.
	aMonthList do: [ :each |
		listElement := MicListItemBlock new.
		link := self
			        makeALink: each asString
			        to: FileReference / '_monthBlog'
				        / (each name , '_' , each year asString , '.html').
		link parent: listElement.
		listElement parent: root ].

	^ self generateRootOfMicListBlock: root
]

{ #category : 'generate' }
MicMonthListCreator >> generateRootOfMicListBlock: aMicUnorderedListBlock [
"Generate a MicRootBlock from a MicUnorderedListBlock for add a header with 'Archives' for text"

	| root header |
	header := MicHeaderBlock new.
	header level: 3.
	(MicTextBlock new bodyString: 'Archives') parent: header.

	root := MicRootBlock new.
	^ root
		  addChild: header;
		  addChild: aMicUnorderedListBlock
]
