Class {
	#name : 'MicCreateMonth',
	#superclass : 'Object',
	#category : 'Microdown-Blog',
	#package : 'Microdown-Blog'
}

{ #category : 'generate' }
MicCreateMonth class >> generateDateListSince2014 [

	| date t |
	date := Date newDay: 1 month: 1 year: 2014.

	t := Timespan
		     starting: date
		     duration:
		     (Duration years: [ Date today year - date year + 1 ] value).
	^ t months
]

{ #category : 'generate' }
MicCreateMonth class >> generateMicListBlockOfLinkDateTo: aDestination [

	| root link inlineParser listElement |
	root := MicUnorderedListBlock new.
	inlineParser := MicInlineParser new.

	self generateDateListSince2014 do: [ :each |
		listElement := MicListItemBlock new.
		link := MicDocumentTransformer makeALink: each asString to: aDestination, '/', each year asString,'/',each name,'/'.
		(link at:1) parent: listElement.
		listElement parent: root ].
	^ root
]
