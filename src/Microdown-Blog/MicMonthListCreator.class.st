"
Create a list of date since january 2014
"
Class {
	#name : 'MicMonthListCreator',
	#superclass : 'MicAbstractBlogCreator',
	#category : 'Microdown-Blog',
	#package : 'Microdown-Blog'
}

{ #category : 'as yet unclassified' }
MicMonthListCreator >> createListOfMonthListFromSummarized: singleSummarizedDocuments [

	| dateList |
	dateList := singleSummarizedDocuments collect: [ :each |
		            | date |
		            date := each children first atKey: #date.
		            date := Date readFrom: date pattern: 'y/m/d'.
		            date month ].
	^ dateList asSet
]

{ #category : 'generate' }
MicMonthListCreator >> generateDateListSince2014 [

	| date t |
	date := Date newDay: 1 month: 1 year: 2014.

	t := Timespan starting: date month ending: (Date today addMonths: 1) month.

	^ t months
]

{ #category : 'generate' }
MicMonthListCreator >> generateMicListBlockOfLinkDate [

	^ self
		  generateMicListBlockOfLinkDateWith: self generateDateListSince2014
]

{ #category : 'generate' }
MicMonthListCreator >> generateMicListBlockOfLinkDateWith: aMonthList [

	| unorderedList link listElement |
	unorderedList := MicUnorderedListBlock new.
	aMonthList do: [ :each |
		listElement := MicListItemBlock new.
		link := self
			        makeALink: each asString
			        to: FileReference / 'monthBlog'
				        / (each name , '_' , each year asString , '.html').
		link parent: listElement.
		listElement parent: unorderedList ].

	^ self generateRootOfMicListBlock: unorderedList
]

{ #category : 'generate' }
MicMonthListCreator >> generateRootOfMicListBlock: aMicUnorderedListBlock [

	| root header |
	header := MicHeaderBlock new.
	header level: 3.
	(MicTextBlock new bodyString: 'Archives') parent: header.

	root := MicRootBlock new.
	^ root
		  addChild: header;
		  addChild: aMicUnorderedListBlock
]
