"
Create a list of date since january 2014
"
Class {
	#name : 'MicMonthListCreator',
	#superclass : 'MicAbstractBlogCreator',
	#category : 'Microdown-Blog',
	#package : 'Microdown-Blog'
}

{ #category : 'generate' }
MicMonthListCreator >> generateDateListSince2014 [

	| date t |
	date := Date newDay: 1 month: 1 year: 2014.

	t := Timespan starting: date month ending: (Date today addMonths: 1) month.

	^ t months
]

{ #category : 'generate' }
MicMonthListCreator >> generateMicListBlockOfLinkDateTo: aFileReference [

	^ self generateMicListBlockOfLinkDateWith: self generateDateListSince2014 To: aFileReference 
]

{ #category : 'generate' }
MicMonthListCreator >> generateMicListBlockOfLinkDateWith: aDateList To: aFileReference [

	| root link listElement |
	
	
	root := MicUnorderedListBlock new.
	aDateList do: [ :each |
		listElement := MicListItemBlock new.
		link := self
			        makeALink: each asString
			        to:
				        '/_monthBlog/' , each name , '_' , each year asString , '.html'.
		link parent: listElement.
		listElement parent: root ].
	
	^ self generateSectionOfMicListBlock: root.
]

{ #category : 'generate' }
MicMonthListCreator >> generateSectionOfMicListBlock: aMicUnorderedListBlock [

	| root header |
	header := MicHeaderBlock new.
	header level: 3.
	(MicTextBlock new bodyString: 'Archives') parent: header.

	root := MicSectionBlock new.
	^ root
		  header: header;
		  body: aMicUnorderedListBlock
]
