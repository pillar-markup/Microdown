Class {
	#name : 'MicSingleSummarizer',
	#superclass : 'MicDocumentTransformer',
	#instVars : [
		'maximumWords'
	],
	#category : 'Microdown-Blog',
	#package : 'Microdown-Blog'
}

{ #category : 'accessing' }
MicSingleSummarizer >> firstHeaderBlockOf: aMicRootBlock [

	| header newHeader |
	header := aMicRootBlock children
		          detect: [ :each | each isKindOf: MicHeaderBlock ]
		          ifNone: [
			          | h t |
			          h := MicHeaderBlock new.
			          t := MicTextBlock new bodyString:
				               'Please define a header'.
			          t parent: h.
			          ^ h ].
	newHeader := MicHeaderBlock new.
	header headerElements do: [ :t | t copy parent: newHeader ].
	newHeader level: header level.
	^ newHeader
]

{ #category : 'accessing' }
MicSingleSummarizer >> firstParagraphBlockOf: aMicRootBlock [

	| p textElements newParagraph selectionSize t sub newSub |
	p := aMicRootBlock children
		     detect: [ :each | each isKindOf: MicParagraphBlock ]
		     ifNone: [
			     p := MicParagraphBlock new.
			     t := MicTextBlock new bodyString: 'Please add a paragraph'.
			     t parent: p.
			     ^ p ].

	sub := p text substrings: ' '.
	selectionSize := maximumWords min: sub size.
	newSub := sub first: selectionSize.

	textElements := '' writeStream.
	newSub do: [ :each |
		textElements
			nextPutAll: each;
			nextPut: Character space ].
		
	sub size >= maximumWords ifTrue: [ textElements
			nextPutAll: '...' ].
		
		textElements close.


	newParagraph := MicParagraphBlock new.
	t := MicTextBlock new bodyString: textElements ensureNoSpace contents.
	t parent: newParagraph.
	^ newParagraph
]

{ #category : 'parsing' }
MicSingleSummarizer >> headerLink: aMicRootBlock [

	| headerLink header date |
	headerLink := MicHeaderBlock new.
	header := self firstHeaderBlockOf: aMicRootBlock.
	date := (aMicRootBlock children at: 1) body at: #date.
	date := date asDate.
	headerLink
		addChild: ((self class
				  makeALink: header text
				  to:
					  targetDirectory , date year asString , '/' , date monthName
					  , '/' , date day asString , '/', header text) at: 1);
		level: header level.

	^ headerLink
]

{ #category : 'initialization' }
MicSingleSummarizer >> initialize [

	super initialize.
	maximumWords := 15.
]

{ #category : 'accessing' }
MicSingleSummarizer >> maximumWords: anInteger [ 
	maximumWords := anInteger
]

{ #category : 'parsing' }
MicSingleSummarizer >> summarize: aMicRootBlock [

	| element headerLink |
	element := MicRootBlock new.
	headerLink := self headerLink: aMicRootBlock .
	
	element
		addChild: aMicRootBlock children first;
		addChild: headerLink;
		addChild: (self firstParagraphBlockOf: aMicRootBlock).

	^ element
]

{ #category : 'parsing' }
MicSingleSummarizer >> summarizeFile: aFileReference [

	| p |
	p := Microdown parse: aFileReference asFileReference contents.
	^ self summarize: p
]
