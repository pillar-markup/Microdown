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

	| root link listElement disk |
	root := MicUnorderedListBlock new.

	(aFileReference fileSystem store isKindOf: WindowsStore) ifTrue: [
		disk := 'File:///', aFileReference fileSystem store currentDisk ].
	disk ifNil: [ disk := '' ].

	self generateDateListSince2014 do: [ :each |
		listElement := MicListItemBlock new.
		link := self
			        makeALink: each asString
			        to:
				        disk , aFileReference fullPath pathString , '/_monthBlog/'
				        , each name , '_' , each year asString , '.html'.
		link parent: listElement.
		listElement parent: root ].
	^ root
]
