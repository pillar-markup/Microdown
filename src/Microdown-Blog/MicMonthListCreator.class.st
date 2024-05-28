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
MicMonthListCreator >> generateMicListBlockOfLinkDateTo: aDestination [

	| root link listElement |
	root := MicUnorderedListBlock new.

	self generateDateListSince2014 do: [ :each |
		listElement := MicListItemBlock new.
		link := self
			        makeALink: each asString
			        to:
			        aDestination asString , '/_monthBlog/'
			        , each asString.
		link parent: listElement.
		listElement parent: root ].
	^ root
]
