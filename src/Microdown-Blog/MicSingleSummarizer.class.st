Class {
	#name : 'MicSingleSummarizer',
	#superclass : 'MicAbstractBlogCreator',
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
				h level: 1.
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
		addChild: (self 
				  makeALink: header text
				  to:
					  targetDirectory printString, date year asString , '/' , date monthName
					  , '/' , date day asString , '/', header text);
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

	| element headerLink root|
	root := self verifyDateMetadata: aMicRootBlock.
	element := MicRootBlock new.
	headerLink := self headerLink: root.

	element
		addChild: root children first;
		addChild: headerLink;
		addChild: (self firstParagraphBlockOf: root).

	^ element
]

{ #category : 'parsing' }
MicSingleSummarizer >> summarizeFile: aFileReference [

	| p |
	p := Microdown parse: aFileReference asFileReference contents.
	^ self summarize: p
]

{ #category : 'as yet unclassified' }
MicSingleSummarizer >> verifyDateMetadata: aMicRootBlock [

	| newMicRootBlock metadata |
	newMicRootBlock := MicRootBlock new.

	((aMicRootBlock children at: 1) isKindOf: MicMetaDataBlock)
		ifFalse: [
			metadata := MicMetaDataBlock new.
			metadata body:
				(Dictionary
					 newFromKeys: #( #date )
					 andValues: #( '25 December 1970' ))]
		ifTrue: [
			metadata := aMicRootBlock children at: 1.
			(metadata body at: #date) ifNil: [
				metadata body at: #date put: '25 December 1970' ] ].
		metadata parent: newMicRootBlock.

	aMicRootBlock children
		do: [ :each | newMicRootBlock addChild: each ]
		without: metadata.
	^ newMicRootBlock
]
