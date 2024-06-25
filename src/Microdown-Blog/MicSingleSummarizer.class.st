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

	| p textElements newParagraph t |
	p := aMicRootBlock children
		     detect: [ :each | each isKindOf: MicParagraphBlock ]
		     ifNone: [
			     p := MicParagraphBlock new.
			     t := MicTextBlock new bodyString: 'Please add a paragraph'.
			     t parent: p.
			     ^ p ].

	textElements := self limitParagraphWord: p. 

	newParagraph := MicParagraphBlock new.
	"t := MicTextBlock new bodyString: textElements ensureNoSpace contents."
	t := (MicInlineParser parse: textElements) first.
	t parent: newParagraph.
	^ newParagraph
]

{ #category : 'parsing' }
MicSingleSummarizer >> headerLink: aMicRootBlock [

	| headerLink header path |
	headerLink := MicHeaderBlock new.
	header := self firstHeaderBlockOf: aMicRootBlock.

	path := (aMicRootBlock fromFile withoutExtension fullName
		         withoutPrefix: targetDirectory fullName) , '.html'.

	headerLink
		addChild: (self makeALink: header text to: path);
		level: header level.

	^ headerLink
]

{ #category : 'initialization' }
MicSingleSummarizer >> initialize [

	super initialize.
	maximumWords := 15.
]

{ #category : 'string-manipulation' }
MicSingleSummarizer >> limitParagraphWord: aMicParagraph [

	| text sub selectionSize newSub textElements |
	text := '' writeStream.
	aMicParagraph children do: [ :each | text nextPutAll: each plainText ].
	text close.

	sub := text contents substrings: ' '.
	selectionSize := maximumWords min: sub size.
	newSub := sub first: selectionSize.

	textElements := '' writeStream.
	newSub do: [ :each |
		textElements
			nextPutAll: each;
			nextPut: Character space ].

	sub size >= maximumWords ifTrue: [ textElements nextPutAll: '...' ].

	^ textElements close contents
]

{ #category : 'accessing' }
MicSingleSummarizer >> maximumWords: anInteger [ 
	maximumWords := anInteger
]

{ #category : 'parsing' }
MicSingleSummarizer >> summarize: aMicRootBlock [

	| element headerLink root |
	root := self verifyDateMetadata: aMicRootBlock.
	element := MicRootBlock new.
	headerLink := self headerLink: aMicRootBlock.

	element
		addChild: root children first;
		addChild: headerLink;
		addChild: (self firstParagraphBlockOf: root).

	^ element
]

{ #category : 'parsing' }
MicSingleSummarizer >> summarizeFile: aFileReference [

	| root |
	root := Microdown parse: aFileReference asFileReference contents.
	root fromFile: aFileReference.
	^ self summarize: root
]

{ #category : 'verifying' }
MicSingleSummarizer >> verifyDateMetadata: aMicRootBlock [

	| newMicRootBlock metadata |
	newMicRootBlock := MicRootBlock new.

	(aMicRootBlock children first isKindOf: MicMetaDataBlock)
		ifFalse: [
			metadata := MicMetaDataBlock new.
			metadata body:
				(Dictionary
					 newFromKeys: #( #date )
					 andValues: #( '25 December 1970' )) ]
		ifTrue: [
			metadata := aMicRootBlock children at: 1.
			(metadata body includesKey: #date) ifFalse: [
				metadata body at: #date put: '25 December 1970' ] ].
	metadata parent: newMicRootBlock.

	aMicRootBlock children
		do: [ :each | newMicRootBlock addChild: each ]
		without: metadata.
	^ newMicRootBlock
]
